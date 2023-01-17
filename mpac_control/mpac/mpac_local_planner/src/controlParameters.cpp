#include "controlParameters.h"
double CP::robot_width = 0.7;
double CP::robot_length_frond = 0.5;
double CP::robot_length_back = 0.5;

// Motion parameters
double CP::max_linearVelocity = 1.0;
double CP::min_linearVelocity = -0.3;
double CP::max_angularVelocity = 45.0 / 180.0 * M_PI;
double CP::min_angularVelocity = -45.0 / 180.0 * M_PI;

double CP::max_linearAcceleration = 1.0;
double CP::min_linearAcceleration = -1.0;
double CP::max_angularAcceleration = 90.0 / 180.0 * M_PI;
double CP::min_angularAcceleration = -90.0 / 180.0 * M_PI;

int CP::move_direction = 1;

// MPC parameters

double CP::gain_state_x = 20.0;
double CP::gain_state_y = 20.0;
double CP::gain_state_theta = 1.0;
double CP::gain_control_v = 1.0;
double CP::gain_control_w = 0.5;

int CP::avoid_mode = 0;
int CP::path_get_method = 0;
int CP::wait_time = -1;
double CP::extra_distance = -1;

LatticeParameters CP::localPlanParameters = LatticeParameters();
