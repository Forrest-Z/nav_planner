#include "mpc.h"
#include "qpOASES.hpp"
#include <spdlog/spdlog.h>

ControllerMPC::ControllerMPC(/* args */)
{
    init();
}

void ControllerMPC::init()
{

    A_m.resize(STATE_CONCAT_LEN, STATE_VAR_N);
    B_m.resize(STATE_CONCAT_LEN, CONTROL_CONCAT_LEN);
    O_m.resize(STATE_CONCAT_LEN, 1);
    U_r.resize(CONTROL_CONCAT_LEN, 1);
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

ControllerMPC::~ControllerMPC()
{
}

void ControllerMPC::caclMatrixA( State2dControl &current_state)
{

    Eigen::MatrixXd A;
    A.resize(STATE_VAR_N, STATE_VAR_N);

    double v = current_state.v;
    double yaw = current_state.pose(2);
    double dt = SAMPLING_PERIOD_SEC;

    A << 1, 0, -v * dt * sin(yaw),
        0, 1, v * dt * cos(yaw),
        0, 0, 1;

    A_m = Eigen::Matrix<double, STATE_CONCAT_LEN, STATE_VAR_N>::Zero();

    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        if (i != 0)
        {
            A_m.middleRows(STATE_VAR_N * i, STATE_VAR_N) = A_m.middleRows(STATE_VAR_N * (i - 1), STATE_VAR_N) * A;
        }
        else
        {
            A_m.middleRows(STATE_VAR_N * i, STATE_VAR_N) = A;
        }
    }
}

void ControllerMPC::caclMatrixB( State2dControl &current_state)
{

    Eigen::MatrixXd A;
    A.resize(STATE_VAR_N, STATE_VAR_N);
    Eigen::MatrixXd B;
    B.resize(STATE_VAR_N, CONTROL_VAR_N);

    double v = current_state.v;
    double yaw = current_state.pose(2);
    double dt = SAMPLING_PERIOD_SEC;

    A << 1, 0, -v * dt * sin(yaw),
        0, 1, v * dt * cos(yaw),
        0, 0, 1;

    B << dt * cos(yaw), 0,
         dt * sin(yaw), 0,
         0, dt;

    B_m = Eigen::Matrix<double, STATE_CONCAT_LEN, CONTROL_CONCAT_LEN>::Zero();
    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {

        B_m.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * i, STATE_VAR_N) = B;
        for (size_t j = i + 1; j < PREVIEW_WINDOW_LEN; j++)
        {

            B_m.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * j, STATE_VAR_N) = A * B_m.middleCols(CONTROL_VAR_N * i, CONTROL_VAR_N).middleRows(STATE_VAR_N * (j - 1), STATE_VAR_N);
        }
    }
}

void ControllerMPC::caclMatrixO( State2dControl &current_state, Trajectory &ref_traj)
{
    Eigen::MatrixXd A;
    A.resize(STATE_VAR_N, STATE_VAR_N);
    Eigen::MatrixXd O;
    O.resize(STATE_VAR_N, 1);

    double v = current_state.v;
    double yaw = current_state.pose(2);
    double dt = SAMPLING_PERIOD_SEC;

    A << 1, 0, -v * dt * sin(yaw),
        0, 1, v * dt * cos(yaw),
        0, 0, 1;

    O << dt * v * sin(yaw) * yaw,
         -dt * v * cos(yaw) * yaw,
        0;

    O_m = Eigen::Matrix<double, STATE_CONCAT_LEN, 1>::Zero();
    U_r = Eigen::Matrix<double, CONTROL_CONCAT_LEN, 1>::Zero();
    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        if (i != 0)
        {
            O_m.middleRows(STATE_VAR_N * i, STATE_VAR_N) = A * O_m.middleRows(STATE_VAR_N * (i - 1), STATE_VAR_N) + O;
        }
        else
        {
            O_m.middleRows(STATE_VAR_N * i, STATE_VAR_N) = O;
        }
    }

    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        Eigen::MatrixXd Ref;
        Ref.resize(STATE_VAR_N, 1);
        Ref <<  ref_traj.poses[i+1](0),
                ref_traj.poses[i+1](1),
                ref_traj.poses[i+1](2);

        O_m.middleRows(STATE_VAR_N * i, STATE_VAR_N) = O_m.middleRows(STATE_VAR_N * i, STATE_VAR_N)-Ref;

        Eigen::MatrixXd u_ref;
        u_ref.resize(CONTROL_VAR_N, 1);
        u_ref << ref_traj.getControl(i+1).v,
                 0.0;
                
        U_r.middleRows(CONTROL_VAR_N * i, CONTROL_VAR_N) = u_ref;
    }
}


void ControllerMPC::form_p( State2dControl &current_state)
{
    //　p = H*Q*S0
    // printf("form_p\n");
    Eigen::VectorXd X0;
    X0.resize(STATE_VAR_N);
    X0 <<  current_state.pose(0),
           current_state.pose(1),
           current_state.pose(2);

    Eigen::VectorXd H_Q_SX0;
    H_Q_SX0 = (A_m * X0 + O_m).transpose() * Q * B_m - U_r.transpose() * R;
    // H_Q_SX0 = (A_m * X0 + O_m).transpose() * Q * B_m;

    // fill_n(p, SW_CONTROL_CONCAT_LEN, 0.0);
    p.resize(CONTROL_CONCAT_LEN, 0.0);
    for (size_t i = 0; i < CONTROL_CONCAT_LEN; i++)
    {
        p[i] = H_Q_SX0(i);
    }
}

void ControllerMPC::formHessian( State2dControl &current_state)
{
    // printf("formHessian\n");
    Eigen::MatrixXd Hessian_M; //Hessian矩阵　Hessian=H^QH+R

    Hessian_M = Eigen::Matrix<double, CONTROL_CONCAT_LEN, CONTROL_CONCAT_LEN>::Zero();

    Hessian_M = B_m.transpose() * Q * B_m + R;

    int index = 0;
    for (size_t i = 0; i < CONTROL_CONCAT_LEN; i++)
    {
        for (size_t j = 0; j < CONTROL_CONCAT_LEN; j++)
        {
            Hessian[index] = Hessian_M(i, j) * 0.5;
            index++;
        }
    }
}

void ControllerMPC::formConstrains( State2dControl &current_state, Trajectory &ref_traj)
{
    // printf("formCOnstrains\n");
    constraints_.form(current_state, ref_traj);
}
void ControllerMPC::getCommand( State2dControl &current_state, Trajectory ref_traj, Control &command)
{

    if(ref_traj.poses.size()<1)
    {
       spdlog::warn("the trajectory is empty!");
       command.v = 0.0;
       command.w = 0.0;
       return;
    }
    CP::max_angularVelocity = std::max({CP::max_linearVelocity * 1.5, CP::max_angularVelocity});
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

    if (index_cloest < (ref_traj.poses.size() - 1))
    {
        index_cloest++;
    }

    double angle_diff = ref_traj.poses[index_cloest].z() - current_state.pose.z();
    angle_diff = atan2(sin(angle_diff), cos(angle_diff));
    if (fabs(angle_diff) > (45.0 / 180.0 * M_PI))
    {
        command.v = 0.0;
        command.w = mpac_generic::sign(angle_diff) * 0.3;
        spdlog::info("rotation is place:{}",command.w);
        return;
    }

    bool inSecondQuadrant = false;
    bool inThirdQuadrant = false;

    if( current_state.pose.z() > M_PI / 2)
    {
        inSecondQuadrant = true;
    }
    
    if( current_state.pose.z() <  -M_PI / 2)
    {
        inThirdQuadrant = true;
    }


    mpac_generic::Trajectory preview_win;
    double last_angle = 0.0;
    // printf("                           \n");
    // printf("%f %f %f %f %f\n", current_state.pose(0), current_state.pose(1), current_state.pose(2), current_state.v, current_state.w);
    // printf("----------------------\n");
    for (size_t i = index_cloest; i < (index_cloest + PREVIEW_WINDOW_LEN_EXT); i++)
    {
        int ind = (i < ref_traj.poses.size()) ? i : (ref_traj.poses.size() - 1);
        preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
        // preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, 0.0, 0.0);
        // printf("%f %f %f %f %f\n", ref_traj.poses[ind](0), ref_traj.poses[ind](1), ref_traj.poses[ind](2), ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);

        if( ref_traj.poses[ind].z() > M_PI / 2)
        {
            inSecondQuadrant = true;
        }

        if( ref_traj.poses[ind].z() <  -M_PI / 2)
        {
            inThirdQuadrant = true;
        }
    }
    last_angle = preview_win.poses.back().z();
    if(inSecondQuadrant && inThirdQuadrant)
    {
        if( current_state.pose(2) <  -M_PI / 2)
        {
           current_state.pose(2) = current_state.pose(2) + M_PI *2.0;
        }

        for(size_t i = 0; i < PREVIEW_WINDOW_LEN_EXT; i++)
        {
            if( preview_win.poses[i](2) <  -M_PI / 2)
            {
                preview_win.poses[i](2) = preview_win.poses[i](2) + M_PI *2.0;
            }
        }
    }   
    {
        for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
        {
            Q(i * STATE_VAR_N, i * STATE_VAR_N) = CP::gain_state_x * std::max(fabs(sin(last_angle)),0.1);
            Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = CP::gain_state_y*std::max(fabs(cos(last_angle)),0.1);
            Q(i * STATE_VAR_N + 2, i * STATE_VAR_N + 2) = CP::gain_state_theta;

            R(i * CONTROL_VAR_N, i * CONTROL_VAR_N) = CP::gain_control_v;
            R(i * CONTROL_VAR_N + 1, i * CONTROL_VAR_N + 1) = CP::gain_control_w;
        }
    }

    caclMatrixA(current_state);
    caclMatrixB(current_state);
    caclMatrixO(current_state,preview_win);
    form_p(current_state);
    formHessian(current_state);
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

    // for (size_t i = 0; i < constraints_.b.size(); i++)
    // {
    //     printf("b_%d:%f\n", i,constraints_.b[i]);
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
            command.v = solution[0];
            command.w = solution[1];
        }
        else if (failed_qp_counter < 5)
        {
            spdlog::warn("qp get primal solution!");
            failed_qp_counter++;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[failed_qp_counter];
            command.w = solution[failed_qp_counter];
        }
    }
    else
    {
        SPDLOG_WARN("qp init failed!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
}

void ControllerMPC::getCommandStop( State2dControl &current_state, Trajectory ref_traj, Control &command)
{
   
    if(ref_traj.poses.size()<1)
    {
       spdlog::warn("the trajectory is empty!");
       command.v = 0.0;
       command.w = 0.0;
       return;
    }

    CP::max_angularVelocity = std::max({CP::max_linearVelocity * 1.5, CP::max_angularVelocity});
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

    if (index_cloest < (ref_traj.poses.size() - 1))
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
    
    bool inSecondQuadrant = false;
    bool inThirdQuadrant = false;

    if( current_state.pose.z() > M_PI / 2){
        inSecondQuadrant = true;
    }
    if( current_state.pose.z() <  -M_PI / 2){
        inThirdQuadrant = true;
    }

    mpac_generic::Trajectory preview_win;
    // printf("                           \n");
    // printf("%f %f %f %f %f\n", current_state.pose(0), current_state.pose(1), current_state.pose(2), current_state.v, current_state.w);
    // printf("----------------------\n");
    for (size_t i = index_cloest; i < (index_cloest + PREVIEW_WINDOW_LEN_EXT); i++)
    {
        int ind = (i < ref_traj.poses.size()) ? i : (ref_traj.poses.size() - 1);
       preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
        // preview_win.addTrajectoryPoint(ref_traj.poses[ind], 0, 0.0, 0.0);

        if( ref_traj.poses[ind].z() > M_PI / 2)
        {
            inSecondQuadrant = true;
        }

        if( ref_traj.poses[ind].z() <  -M_PI / 2)
        {
            inThirdQuadrant = true;
        }

        // printf("%f %f %f %f %f\n", ref_traj.poses[ind](0), ref_traj.poses[ind](1), ref_traj.poses[ind](2), ref_traj.getControl(ind).v, ref_traj.getControl(ind).w);
    }

    if(inSecondQuadrant && inThirdQuadrant)
    {
        if( current_state.pose(2) <  -M_PI / 2)
        {
           current_state.pose(2) = current_state.pose(2) + M_PI *2.0;
        }

        for(size_t i = 0; i < PREVIEW_WINDOW_LEN_EXT; i++)
        {
            if( preview_win.poses[i](2) <  -M_PI / 2)
            {
                preview_win.poses[i](2) = preview_win.poses[i](2) + M_PI *2.0;
            }
        }
    }

    double last_angle = preview_win.poses.back().z();
    {
        double gain_x = CP::gain_state_x *std::max(fabs(sin(last_angle)),0.1)*2;
        double gain_y = CP::gain_state_y * std::max(fabs(cos(last_angle)),0.1)*2;
        for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
        {
            // Q(i * STATE_VAR_N, i * STATE_VAR_N) = CP::gain_state_x *std::max(fabs(sin(last_angle)),0.1)*2;
            // Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = CP::gain_state_y * std::max(fabs(cos(last_angle)),0.1)*2;
            Q(i * STATE_VAR_N, i * STATE_VAR_N) = gain_x;
            Q(i * STATE_VAR_N + 1, i * STATE_VAR_N + 1) = gain_y;            
            Q(i * STATE_VAR_N + 2, i * STATE_VAR_N + 2) = CP::gain_state_theta / 2;

            R(i * CONTROL_VAR_N, i * CONTROL_VAR_N) = CP::gain_control_v / 2;
            R(i * CONTROL_VAR_N + 1, i * CONTROL_VAR_N + 1) = CP::gain_control_w / 2;
        }
    }

    caclMatrixA(current_state);
    caclMatrixB(current_state);
    caclMatrixO(current_state,preview_win);
    form_p(current_state);
    formHessian(current_state);
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
    
    // for (size_t i = 0; i < constraints_.b.size(); i++)
    // {
    //     printf("b_%d:%f\n", i,constraints_.b[i]);
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
            command.v = solution[0];
            command.w = solution[1];
            // printf("command:%f %f\n",command.v, command.w);
        }
        else if (failed_qp_counter < 5)
        {
            failed_qp_counter++;
            Control ref_control;
            ref_control = preview_win.getControl(1);
            command.v = solution[failed_qp_counter];
            command.w = solution[failed_qp_counter];
        }
    }
    else
    {
        SPDLOG_WARN("qp init failed!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
}

void ControllerMPC::getCommand_V2( State2dControl &current_state, Trajectory ref_traj, Control &command)
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
    target_direction = atan2(sin(target_direction), cos(target_direction));
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
