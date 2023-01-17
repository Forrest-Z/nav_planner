/**
 * @file controller.h
 * @author shaochang (you@domain.com)
 * @brief mpc controller for differential wheel motion model
 *        state:x y yaw   control: v w
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

class Controller
{
private:
    /**
     * @brief Calculate the Jacobian matrix of the state term
     * 
     * @param dt Time increment
     * @param v  Speed of linearization point
     * @param yaw Angle of linearization point
     * @param A  Jacobian matrix of the state term at linearization point
     */
    void caclMatrixA(double dt, double v, double yaw, Eigen::MatrixXd &A);

    /**
     * @brief Calculate the Jacobian matrix of the control term
     * 
     * @param dt Time increment
     * @param yaw Angle of linearization point
     * @param B Jacobian matrix of the control term at linearization point
     */
    void caclMatrixB(double dt, double yaw, Eigen::MatrixXd &B);
    
    /**
     * @brief X=S+HU Calculate the Constant matrix which is depended on input trajectory
     * 
     * @param ref_traj 
     */
    void caclMatrixS(Trajectory &ref_traj);

    void caclMatrixH(Trajectory &ref_traj);

    void form_p( State2dControl &current_state, Trajectory &ref_traj);
    void formHessian( State2dControl &current_state, Trajectory &ref_traj);
    void formConstrains( State2dControl &current_state, Trajectory &ref_traj);

    double solution[CONTROL_CONCAT_LEN];
    int failed_qp_counter;

    qpConstraints constraints_;

    Eigen::MatrixXd H;
    Eigen::MatrixXd S;
    Eigen::MatrixXd Q;
    Eigen::MatrixXd R;
    Eigen::MatrixXd Q_S;
    Eigen::MatrixXd R_S;

    /// 0.5*Hessian matrix of the objective function
    std::vector<double> Hessian;
    // Vector of the objective function
    std::vector<double> p;

public:
    Controller(/* args */);
    ~Controller();

    void getCommand( State2dControl &current_state, Trajectory ref_traj, Control &command);

    void getCommandStop( State2dControl &current_state, Trajectory ref_traj, Control &command);

    void getCommand_V2( State2dControl &current_state, Trajectory ref_traj, Control &command);
    void init();
};
