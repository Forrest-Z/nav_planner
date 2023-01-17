/**
 * @file controller.h
 * @author shaochang (you@domain.com)
 * @brief mpc controller for differential wheel motion model
 *        state:x y yaw   control: v w
 * 
 *        x_j = v * cos(yaw)
 *        y_j = v * sin(yaw)    --->   X_j = AX+Bu+O
 *        yaw_j = w
 *        
 *        X_n = A_ * X_n-1 + B_ * U_n-1 + O_;
 *
 *        A_ <<  1, 0, -v * dt * sin(yaw),
 *               0, 1, v * dt * cos(yaw),
 *               0, 0, 1;
 * 
          B_ << dt * cos(yaw), 0,
                dt * sin(yaw), 0,
                0, dt;

          O_ <<  yaw * v * sin(yaw),
                -yaw * v * cos(yaw),
                 0;

          Y = X - Xref = A_m * X0 + B_m * U _ + O_m
 * 
 * @version 0.1
 * @date 2021-05-17
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include "controlParameters.h"
#include <mpac_generic/interfaces.h>
#include <mpac_generic/path_utils.h>
#include <qpConstraints.h>
#include "Eigen/Dense"

using namespace mpac_generic;

class ControllerMPC
{
private:

    void caclMatrixA( State2dControl &current_state);

    void caclMatrixB( State2dControl &current_state);

    void caclMatrixO( State2dControl &current_state, Trajectory &ref_traj);

    void form_p( State2dControl &current_state);
    void formHessian( State2dControl &current_state);
    void formConstrains( State2dControl &current_state, Trajectory &ref_traj);

    double solution[CONTROL_CONCAT_LEN];
    int failed_qp_counter;

    qpConstraints constraints_;

    Eigen::MatrixXd A_m;
    Eigen::MatrixXd B_m;
    Eigen::MatrixXd O_m;
    Eigen::MatrixXd U_r;

    Eigen::MatrixXd Q;
    Eigen::MatrixXd R;
    Eigen::MatrixXd Q_S;
    Eigen::MatrixXd R_S;

    /// 0.5*Hessian matrix of the objective function
    std::vector<double> Hessian;
    // Vector of the objective function
    std::vector<double> p;

public:
    ControllerMPC(/* args */);
    ~ControllerMPC();

    void getCommand( State2dControl &current_state, Trajectory ref_traj, Control &command);

    void getCommandStop( State2dControl &current_state, Trajectory ref_traj, Control &command);

    void getCommand_V2( State2dControl &current_state, Trajectory ref_traj, Control &command);
    void init();
};
