#pragma once

// #include "commonDefines.h"
#include "controlParameters.h"
#include <mpac_generic/interfaces.h>
#include <mpac_generic/path_utils.h>
/**
 * @brief Constraints of the QP problem.
 *  A*x<=b
 */

class qpConstraints
{
private:

    bool enable_position_constraints;
    bool enable_cen_acc_constraints;
    bool enable_tan_acc_constraints;
    bool enable_orientation_constraints;

    void initPointers();

public:
    /// Matrix A of constraints
    // double *A;
    // double *b;

    std::vector<double> A;
    std::vector<double> b;


    /// Upper bounds on control variables
    std::vector<double> ub;
    /// Lower bounds on control variables
    std::vector<double> lb;

    /// Total number of state constraints.

    void form(mpac_generic::State2dControl &current_state, const mpac_generic::Trajectory &pre_win);

    int min_constraints_num;
    int constraints_total_num;

    qpConstraints(/* args */);
    ~qpConstraints();
};
