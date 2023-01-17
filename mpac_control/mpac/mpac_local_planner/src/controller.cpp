#include "controller.h"
#include "qpOASES.hpp"
#include <spdlog/spdlog.h>

Controller::Controller(/* args */)
{
    init();
}

void Controller::init()
{
    H.resize(CONTROL_CONCAT_LEN, CONTROL_CONCAT_LEN);
    S.resize(STATE_CONCAT_LEN, STATE_VAR_N);
    Q.resize(STATE_CONCAT_LEN, STATE_CONCAT_LEN);
    R.resize(CONTROL_CONCAT_LEN, CONTROL_CONCAT_LEN);
    Hessian.resize(CONTROL_CONCAT_LEN * CONTROL_CONCAT_LEN);

    Q = Eigen::Matrix<double, STATE_CONCAT_LEN, STATE_CONCAT_LEN>::Zero();

    R = Eigen::Matrix<double, CONTROL_CONCAT_LEN, CONTROL_CONCAT_LEN>::Zero();

    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        Q(i * STATE_VAR_N, i * STATE_VAR_N) = CP::gain_state_x;
        Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = CP::gain_state_y;
        Q(i * STATE_VAR_N + 2, i * STATE_VAR_N + 2) = CP::gain_state_theta;

        R(i * CONTROL_VAR_N, i * CONTROL_VAR_N) = CP::gain_control_v;
        R(i * CONTROL_VAR_N + 1, i * CONTROL_VAR_N + 1) = CP::gain_control_w;
    }

    p.resize(CONTROL_CONCAT_LEN);
    failed_qp_counter = 0;
}

Controller::~Controller()
{
}

void Controller::caclMatrixA(double dt, double v, double yaw, Eigen::MatrixXd &A)
{

    A.resize(STATE_VAR_N, STATE_VAR_N);
    A << 1, 0, -v * dt * sin(yaw),
        0, 1, v * dt * cos(yaw),
        0, 0, 1;
}

void Controller::caclMatrixB(double dt, double yaw, Eigen::MatrixXd &B)
{

    B.resize(STATE_VAR_N, CONTROL_VAR_N);
    B = Eigen::Matrix<double, STATE_VAR_N, CONTROL_VAR_N>::Zero();
    B << dt * cos(yaw), 0,
        dt * sin(yaw), 0,
        0, dt;
}

void Controller::caclMatrixS(Trajectory &ref_traj)
{
    // printf("caclMatrixS\n");

    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        Eigen::MatrixXd A;
        caclMatrixA(SAMPLING_PERIOD_SEC, ref_traj.getControl(i + 1).v, ref_traj.poses[i].z(), A);
        if (i != 0)
        {
            S.middleRows(STATE_VAR_N * i, STATE_VAR_N) = S.middleRows(STATE_VAR_N * (i - 1), STATE_VAR_N) * A;
        }
        else
        {
            S.middleRows(STATE_VAR_N * i, STATE_VAR_N) = A;
        }
    }
}

void Controller::caclMatrixH(Trajectory &ref_traj)
{
    // printf("caclMatrixH\n");
    H = Eigen::Matrix<double, STATE_CONCAT_LEN, CONTROL_CONCAT_LEN>::Zero();
    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        Eigen::MatrixXd B;
        caclMatrixB(SAMPLING_PERIOD_SEC, ref_traj.poses[i + 1].z(), B);
        H.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * i, STATE_VAR_N) = B;
        for (size_t j = i + 1; j < PREVIEW_WINDOW_LEN; j++)
        {

            Eigen::MatrixXd A;

            caclMatrixA(SAMPLING_PERIOD_SEC, ref_traj.getControl(j + 1).v, ref_traj.poses[j].z(), A);

            H.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * j, STATE_VAR_N) = A * H.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * (j - 1), STATE_VAR_N);
        }
    }
}
void Controller::form_p( State2dControl &current_state, Trajectory &ref_traj)
{
    //　p = H*Q*S0
    // printf("form_p\n");
    Pose2d error_pose;
    error_pose = current_state.getPose2d() - ref_traj.poses[1];

    error_pose(2) = atan2(sin(error_pose(2)), cos(error_pose(2)));

    Eigen::VectorXd SX0;
    SX0.resize(STATE_CONCAT_LEN);
    for (size_t i = 0; i < STATE_CONCAT_LEN; i++)
    {
        SX0(i) = (S.middleRows(i, 1) * error_pose)(0, 0);
    }

    Eigen::VectorXd H_Q_SX0;
    H_Q_SX0 = H.transpose() * Q * SX0;

    // fill_n(p, SW_CONTROL_CONCAT_LEN, 0.0);
    p.resize(CONTROL_CONCAT_LEN, 0.0);
    for (size_t i = 0; i < CONTROL_CONCAT_LEN; i++)
    {
        p[i] = H_Q_SX0(i);
    }
}

void Controller::formHessian( State2dControl &current_state, Trajectory &ref_traj)
{
    Eigen::MatrixXd Hessian_M; //Hessian矩阵　Hessian=H^QH+R

    Hessian_M = Eigen::Matrix<double, CONTROL_CONCAT_LEN, CONTROL_CONCAT_LEN>::Zero();

    Hessian_M = H.transpose() * Q * H + R;

    int index = 0;
    for (size_t i = 0; i < CONTROL_CONCAT_LEN; i++)
    {
        for (size_t j = 0; j < CONTROL_CONCAT_LEN; j++)
        {
            Hessian[index] = Hessian_M(i, j);
            index++;
        }
    }
}

void Controller::formConstrains(State2dControl &current_state, Trajectory &ref_traj)
{
    constraints_.form(current_state, ref_traj);
}
void Controller::getCommand( State2dControl &current_state, Trajectory ref_traj, Control &command)
{

    CP::max_angularVelocity = std::max({CP::max_linearVelocity*1.5,CP::max_angularVelocity});
    CP::min_angularVelocity = -CP::max_angularVelocity;

    int index_cloest = 0;
    double dis = 5;

    for (size_t i = 0; i < ref_traj.poses.size(); i++)
    {

        double dis_tem = (current_state.pose - ref_traj.poses[i]).topRows(2).norm();
        if (dis_tem < dis)
        {
            dis = dis_tem;
            index_cloest = i;
        }
    }

    if (index_cloest<(ref_traj.poses.size()-1))
    {
        index_cloest++;
    }
    

    double angle_diff = ref_traj.poses[index_cloest].z() - current_state.pose.z();
    angle_diff = atan2(sin(angle_diff), cos(angle_diff));
    if (fabs(angle_diff) > (45.0 / 180.0 * M_PI))
    {
        command.v = 0.0;
        command.w = mpac_generic::sign(angle_diff) * 0.3;
        return;
    }

    mpac_generic::Trajectory preview_win;
    printf("                           \n");
    printf("%f %f %f %f %f\n", current_state.pose(0), current_state.pose(1), current_state.pose(2), current_state.v, current_state.w);
    printf("----------------------\n");
    for (size_t i = index_cloest; i < (index_cloest + PREVIEW_WINDOW_LEN_EXT); i++)
    {
        int ind = (i < ref_traj.poses.size()) ? i : (ref_traj.poses.size() - 1);
        preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
        printf("%f %f %f %f %f\n", ref_traj.poses[ind](0), ref_traj.poses[ind](1), ref_traj.poses[ind](2), ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
    }

    {
        for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
        {
            Q(i * STATE_VAR_N, i * STATE_VAR_N) = CP::gain_state_x;
            Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = CP::gain_state_y;
            Q(i * STATE_VAR_N + 2, i * STATE_VAR_N + 2) = CP::gain_state_theta;

            R(i * CONTROL_VAR_N, i * CONTROL_VAR_N) = CP::gain_control_v;
            R(i * CONTROL_VAR_N + 1, i * CONTROL_VAR_N + 1) = CP::gain_control_w;
        }
    }

    caclMatrixS(preview_win);
    caclMatrixH(preview_win);
    form_p(current_state, preview_win);
    formHessian(current_state, preview_win);
    formConstrains(current_state, preview_win);
    qpOASES::QProblem qp(CONTROL_CONCAT_LEN, constraints_.constraints_total_num, qpOASES::HST_POSDEF);

    int nWSR = 100;
    double cputime = 0.05;

    qpOASES::Options qp_options;
    qp_options.setToDefault();

    // Hessian is positive definite
    qp_options.enableRegularisation = qpOASES::BT_FALSE;
    qp_options.numRegularisationSteps = 0;
    qp_options.enableFlippingBounds = qpOASES::BT_FALSE;
    qp_options.enableNZCTests = qpOASES::BT_FALSE;

    // All bounds are inactive at the first iteration
    qp_options.initialStatusBounds = qpOASES::ST_INACTIVE; // Flipping bounds require it to be ST_LOWER / ST_UPPER

    /// @swAssume Control inputs never have -/+Inf bounds.
    qp_options.enableFarBounds = qpOASES::BT_FALSE; // Flipping bounds require it to be BT_TRUE

    qp.setOptions(qp_options);

    // for (size_t i = 0; i < constraints_.lb.size(); i++)
    // {
    //     printf("l:%f  u:%f\n", constraints_.lb[i], constraints_.ub[i]);
    // }

    if (qp.init(Hessian.data(),
                p.data(),
                constraints_.A.data(),
                constraints_.lb.data(),
                constraints_.ub.data(),
                NULL,
                constraints_.b.data(),
                nWSR,
                &cputime) == qpOASES::SUCCESSFUL_RETURN)
    {

        fill_n(solution, CONTROL_CONCAT_LEN, 0.0);

        if (qp.getPrimalSolution(solution) == qpOASES::SUCCESSFUL_RETURN)
        {

            failed_qp_counter = 0;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[0] + ref_control.v;
            command.w = solution[1] + ref_control.w;
            if(fabs(command.w - current_state.w)>0.03){
                printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
            }
            printf("command:%f %f\n",solution[0], solution[1]);

        }
        else if (failed_qp_counter < 5)
        {
            failed_qp_counter++;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[failed_qp_counter] + ref_control.v;
            command.w = solution[failed_qp_counter] + ref_control.w;

        }
    }
    else
    {
        SPDLOG_WARN("qp init failed!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
}

void Controller::getCommandStop( State2dControl &current_state, Trajectory ref_traj, Control &command){
    CP::max_angularVelocity = std::max({CP::max_linearVelocity*1.5,CP::max_angularVelocity});
    CP::min_angularVelocity = -CP::max_angularVelocity;

    int index_cloest = 0;
    double dis = 5;

    for (size_t i = 0; i < ref_traj.poses.size(); i++)
    {

        double dis_tem = (current_state.pose - ref_traj.poses[i]).topRows(2).norm();
        if (dis_tem < dis)
        {
            dis = dis_tem;
            index_cloest = i;
        }
    }

    if (index_cloest<(ref_traj.poses.size()-1))
    {
        index_cloest++;
    }
    

    double angle_diff = ref_traj.poses[index_cloest].z() - current_state.pose.z();
    angle_diff = atan2(sin(angle_diff), cos(angle_diff));
    if (fabs(angle_diff) > (45.0 / 180.0 * M_PI))
    {
        command.v = 0.0;
        command.w = mpac_generic::sign(angle_diff) * 0.3;
        return;
    }

    mpac_generic::Trajectory preview_win;
    // printf("                           \n");
    // printf("%f %f %f %f %f\n", current_state.pose(0), current_state.pose(1), current_state.pose(2), current_state.v, current_state.w);
    // printf("----------------------\n");
    for (size_t i = index_cloest; i < (index_cloest + PREVIEW_WINDOW_LEN_EXT); i++)
    {
        int ind = (i < ref_traj.poses.size()) ? i : (ref_traj.poses.size() - 1);
        preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
        // printf("%f %f %f %f %f\n", ref_traj.poses[ind](0), ref_traj.poses[ind](1), ref_traj.poses[ind](2), ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
    }

    {
        for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
        {
            Q(i * STATE_VAR_N, i * STATE_VAR_N) = CP::gain_state_x*2;
            Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = CP::gain_state_y*2;
            Q(i * STATE_VAR_N + 2, i * STATE_VAR_N + 2) = CP::gain_state_theta/2;

            R(i * CONTROL_VAR_N, i * CONTROL_VAR_N) = CP::gain_control_v/2;
            R(i * CONTROL_VAR_N + 1, i * CONTROL_VAR_N + 1) = CP::gain_control_w/2;
        }
    }
    
    caclMatrixS(preview_win);
    caclMatrixH(preview_win);
    form_p(current_state, preview_win);
    formHessian(current_state, preview_win);
    formConstrains(current_state, preview_win);
    qpOASES::QProblem qp(CONTROL_CONCAT_LEN, constraints_.constraints_total_num, qpOASES::HST_POSDEF);

    int nWSR = 100;
    double cputime = 0.05;

    qpOASES::Options qp_options;
    qp_options.setToDefault();

    // Hessian is positive definite
    qp_options.enableRegularisation = qpOASES::BT_FALSE;
    qp_options.numRegularisationSteps = 0;
    qp_options.enableFlippingBounds = qpOASES::BT_FALSE;
    qp_options.enableNZCTests = qpOASES::BT_FALSE;

    // All bounds are inactive at the first iteration
    qp_options.initialStatusBounds = qpOASES::ST_INACTIVE; // Flipping bounds require it to be ST_LOWER / ST_UPPER

    /// @swAssume Control inputs never have -/+Inf bounds.
    qp_options.enableFarBounds = qpOASES::BT_FALSE; // Flipping bounds require it to be BT_TRUE

    qp.setOptions(qp_options);

    // for (size_t i = 0; i < constraints_.lb.size(); i++)
    // {
    //     printf("l:%f  u:%f\n", constraints_.lb[i], constraints_.ub[i]);
    // }

    if (qp.init(Hessian.data(),
                p.data(),
                constraints_.A.data(),
                constraints_.lb.data(),
                constraints_.ub.data(),
                NULL,
                constraints_.b.data(),
                nWSR,
                &cputime) == qpOASES::SUCCESSFUL_RETURN)
    {

        fill_n(solution, CONTROL_CONCAT_LEN, 0.0);

        if (qp.getPrimalSolution(solution) == qpOASES::SUCCESSFUL_RETURN)
        {

            failed_qp_counter = 0;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[0] + ref_control.v;
            command.w = solution[1] + ref_control.w;
            // printf("command:%f %f\n",command.v, command.w);

        }
        else if (failed_qp_counter < 5)
        {
            failed_qp_counter++;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[failed_qp_counter] + ref_control.v;
            command.w = solution[failed_qp_counter] + ref_control.w;

        }
    }
    else
    {
        SPDLOG_WARN("qp init failed!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
}

void Controller::getCommand_V2( State2dControl &current_state, Trajectory ref_traj, Control &command)
{

    int index_cloest = 0;
    double dis = INFINITY;

    for (size_t i = 0; i < ref_traj.poses.size(); i++)
    {

        double dis_tem = (current_state.pose - ref_traj.poses[i]).topRows(2).norm();
        if (dis_tem < dis)
        {
            dis = dis_tem;
            index_cloest = i;
        }
    }

    double look_ahead_dis_control = CP::max_linearVelocity;
    int index_goal = index_cloest;
    mpac_generic::Pose2d goal_pose;
    for (size_t i = index_cloest; i < ref_traj.poses.size(); i++)
    {
        index_goal = i;
        double dis_tem = (current_state.pose - ref_traj.poses[i]).topRows(2).norm();
        if (dis_tem > look_ahead_dis_control)
        {
            break;
        }
    }

    goal_pose = ref_traj.poses[index_goal];

    double angle_diff = goal_pose(2) - current_state.pose(2);
    angle_diff = atan2(sin(angle_diff), cos(angle_diff));

    double target_angle = atan2((goal_pose(1) - current_state.pose(1)), (goal_pose(0) - current_state.pose(0)));
    double target_direction = target_angle - current_state.pose(2);
    target_direction =  atan2(sin(target_direction),cos(target_direction));
    double target_line = hypot((goal_pose(1) - current_state.pose(1)), (goal_pose(0) - current_state.pose(0)));

    target_line = std::max(target_line, 0.2);
    command.v = ref_traj.getControl(index_cloest).v;
    command.w = sin(target_direction) * command.v / target_line;

    if (fabs(command.w) > CP::max_angularVelocity)
    {
        double coffe = CP::max_angularVelocity / fabs(command.w);
        command.w = command.w * coffe;
        command.v = command.v * coffe;
    }
}