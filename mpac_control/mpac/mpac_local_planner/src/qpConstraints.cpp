#include "qpConstraints.h"
#include "controlParameters.h"

enum constraintNumber
{
    QP_B_TANACC_U_LEN = PREVIEW_WINDOW_LEN - 1,
    QP_B_TANACC_L_LEN = PREVIEW_WINDOW_LEN - 1,
};

qpConstraints::qpConstraints()
{
    // A = NULL;
    // b = NULL;
    ub.resize(CONTROL_CONCAT_LEN);
    lb.resize(CONTROL_CONCAT_LEN);

    enable_tan_acc_constraints = true; //切向加速度约束

    min_constraints_num = 0;


    if (enable_tan_acc_constraints)
    {
        min_constraints_num = 2 * CONTROL_VAR_N * (PREVIEW_WINDOW_LEN - 1);
    }
}

qpConstraints::~qpConstraints()
{
    // if (b != NULL)
    // {
    //     delete[] b;
    // }

    // if (A != NULL)
    // {
    //     delete[] A;
    // }
}
void qpConstraints::form(mpac_generic::State2dControl &current_state, const mpac_generic::Trajectory &pre_win)
{
    constraints_total_num = min_constraints_num;

    // printf("max_v:%f min_v:%f\n  max_al:%f  min_al:%f\n", CP::max_linearVelocity, CP::min_linearVelocity, CP::max_linearAcceleration,CP::min_linearAcceleration);
    // 控制变量的上下边界

    for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
    {
        int index = i * CONTROL_VAR_N;

        // lb[index] = CP::min_linearVelocity - pre_win.getControl(i + 1).v;
        // ub[index] = CP::max_linearVelocity - pre_win.getControl(i + 1).v;

        // lb[index + 1] = CP::min_angularVelocity - pre_win.getControl(i + 1).w;
        // ub[index + 1] = CP::max_angularVelocity - pre_win.getControl(i + 1).w;

        lb[index] = CP::min_linearVelocity;
        ub[index] = CP::max_linearVelocity;

        lb[index + 1] = CP::min_angularVelocity;
        ub[index + 1] = CP::max_angularVelocity;
    }

    // if (b != NULL)
    // {
    //     delete[] b;
    // }

    // b = new double[constraints_total_num]();
    b.clear();
    b.resize(constraints_total_num,0.0);

    for (size_t i = 0; i < QP_B_TANACC_U_LEN; i++)
    {
        b[i] = SAMPLING_PERIOD_SEC * CP::max_linearAcceleration;
        b[i + QP_B_TANACC_U_LEN] = -SAMPLING_PERIOD_SEC * CP::min_linearAcceleration;
        b[i + QP_B_TANACC_U_LEN * 2] = SAMPLING_PERIOD_SEC * CP::max_angularAcceleration;
        b[i + QP_B_TANACC_U_LEN * 3] = -SAMPLING_PERIOD_SEC * CP::min_angularAcceleration;
    }
    double v0_min = SAMPLING_PERIOD_SEC * CP::min_linearAcceleration + current_state.v;
    double v0_max = SAMPLING_PERIOD_SEC * CP::max_linearAcceleration + current_state.v;

    double w0_min = SAMPLING_PERIOD_SEC * CP::min_angularAcceleration + current_state.w;
    double w0_max = SAMPLING_PERIOD_SEC * CP::max_angularAcceleration + current_state.w;

    if (lb[0] < v0_min)
    {
        lb[0] = v0_min;
    }
    if (ub[0] > v0_max)
    {
        ub[0] = v0_max;
    }

    if (lb[1] < w0_min)
    {
        lb[1] = w0_min;
    }
    if (ub[1] > w0_max)
    {
        ub[1] = w0_max;
    }

    // if (A != NULL)
    // {
    //     delete[] A;
    // }

    int size_a = CONTROL_CONCAT_LEN * constraints_total_num;

    A.clear();
    A.resize(size_a,0.0);

    // A = new double[size_a]()

    int PREVIEW_WINDOW_LEN_LAST = PREVIEW_WINDOW_LEN-1;

    for (int i = 0; i < PREVIEW_WINDOW_LEN_LAST; i++)
    {

        int ind = i * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N;
        A[ind] = -1;
        A[ind + CONTROL_VAR_N] = 1;

        int ind_l = (i + PREVIEW_WINDOW_LEN_LAST) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N;
        A[ind_l] = 1;
        A[ind_l + CONTROL_VAR_N] = -1;

        int ind_a = (i + PREVIEW_WINDOW_LEN_LAST * 2) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N + 1;
        A[ind_a] = -1;
        A[ind_a + CONTROL_VAR_N] = 1;

        int ind_a_l = (i + PREVIEW_WINDOW_LEN_LAST * 3) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N + 1;
        A[ind_a_l] = 1;
        A[ind_a_l + CONTROL_VAR_N] = -1;
    }
}


// void qpConstraints::form(mpac_generic::State2dControl &current_state, const mpac_generic::Trajectory &pre_win)
// {
//     constraints_total_num = min_constraints_num;

//     // printf("max_v:%f min_v:%f\n", CP::max_linearVelocity, CP::min_linearVelocity);
//     // 控制变量的上下边界

//     for (size_t i = 0; i < PREVIEW_WINDOW_LEN; i++)
//     {
//         int index = i * CONTROL_VAR_N;

//         lb[index] = CP::min_linearVelocity - pre_win.getControl(i + 1).v;
//         ub[index] = CP::max_linearVelocity - pre_win.getControl(i + 1).v;

//         lb[index + 1] = CP::min_angularVelocity - pre_win.getControl(i + 1).w;
//         ub[index + 1] = CP::max_angularVelocity - pre_win.getControl(i + 1).w;
//     }

//     // if (b != NULL)
//     // {
//     //     delete[] b;
//     // }

//     // b = new double[constraints_total_num]();
//     b.clear();
//     b.resize(constraints_total_num,0.0);

//     for (size_t i = 0; i < QP_B_TANACC_U_LEN; i++)
//     {
//         b[i] = SAMPLING_PERIOD_SEC * CP::max_linearAcceleration - pre_win.getControl(i + 2).v + pre_win.getControl(i + 1).v;
//         b[i + QP_B_TANACC_U_LEN] = -(SAMPLING_PERIOD_SEC * CP::min_linearAcceleration - pre_win.getControl(i + 2).v + pre_win.getControl(i + 1).v);
//         b[i + QP_B_TANACC_U_LEN * 2] = SAMPLING_PERIOD_SEC * CP::max_angularAcceleration - pre_win.getControl(i + 2).w + pre_win.getControl(i + 1).w;
//         b[i + QP_B_TANACC_U_LEN * 3] = -(SAMPLING_PERIOD_SEC * CP::min_angularAcceleration - pre_win.getControl(i + 2).w + pre_win.getControl(i + 1).w);
//     }
//     double v0_min = SAMPLING_PERIOD_SEC * (CP::min_linearAcceleration)-pre_win.getControl(1).v + current_state.v;
//     double v0_max = SAMPLING_PERIOD_SEC * CP::max_linearAcceleration - pre_win.getControl(1).v + current_state.v;

//     double w0_min = SAMPLING_PERIOD_SEC * (CP::min_angularAcceleration)-pre_win.getControl(1).w + current_state.w;
//     double w0_max = SAMPLING_PERIOD_SEC * CP::max_angularAcceleration - pre_win.getControl(1).w + current_state.w;

//     if (lb[0] < v0_min)
//     {
//         lb[0] = v0_min;
//     }
//     if (ub[0] > v0_max)
//     {
//         ub[0] = v0_max;
//     }

//     if (lb[1] < w0_min)
//     {
//         lb[1] = w0_min;
//     }
//     if (ub[1] > w0_max)
//     {
//         ub[1] = w0_max;
//     }

//     // if (A != NULL)
//     // {
//     //     delete[] A;
//     // }

//     int size_a = CONTROL_CONCAT_LEN * constraints_total_num;

//     A.clear();
//     A.resize(size_a,0.0);

//     // A = new double[size_a]()

//     int PREVIEW_WINDOW_LEN_LAST = PREVIEW_WINDOW_LEN-1;

//     for (int i = 0; i < PREVIEW_WINDOW_LEN_LAST; i++)
//     {

//         int ind = i * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N;
//         A[ind] = -1;
//         A[ind + CONTROL_VAR_N] = 1;

//         int ind_l = (i + PREVIEW_WINDOW_LEN_LAST) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N;
//         A[ind_l] = 1;
//         A[ind_l + CONTROL_VAR_N] = -1;

//         int ind_a = (i + PREVIEW_WINDOW_LEN_LAST * 2) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N + 1;
//         A[ind_a] = -1;
//         A[ind_a + CONTROL_VAR_N] = 1;

//         int ind_a_l = (i + PREVIEW_WINDOW_LEN_LAST * 3) * CONTROL_CONCAT_LEN + i * CONTROL_VAR_N + 1;
//         A[ind_a_l] = 1;
//         A[ind_a_l + CONTROL_VAR_N] = -1;
//     }
// }