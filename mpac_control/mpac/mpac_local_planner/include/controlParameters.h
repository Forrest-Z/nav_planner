#pragma once

#include <stdexcept>
#include <string>
#include <stdint.h>
#include <math.h>

using namespace std;

struct LatticeParameters
{
    double max_width_sample;
    double step_width_sample;

    double max_time_sample;
    double min_time_sample;

    double target_speed;
    double step_speed_sample;

    double w_jerk;
    double w_time;
    double w_diffV;
    double w_offset;
    double w_collision;
    double w_distance;

    LatticeParameters()
    {
        max_width_sample = 2.0;
        step_width_sample = 0.05;

        max_time_sample = 2.0;
        min_time_sample = 1.0;

        target_speed = 1.0;
        step_speed_sample = 0.1;

        w_jerk = 5;
        w_time = 10;
        w_diffV = 10;
        w_offset = 20;
        w_collision = 10;
        w_distance = 20;
    }
    ~LatticeParameters(){};
};

const double SAMPLING_PERIOD_SEC = 0.10;
const int PREVIEW_WINDOW_LEN = 10;
const int CONTROL_VAR_N = 2;
const int STATE_VAR_N = 3;
const int STATE_CONCAT_LEN = STATE_VAR_N * PREVIEW_WINDOW_LEN;
const int CONTROL_CONCAT_LEN = CONTROL_VAR_N * PREVIEW_WINDOW_LEN;
const int PREVIEW_WINDOW_LEN_EXT = PREVIEW_WINDOW_LEN + 1;

class CP
{
public:
    //Shape parameters
    static double robot_width;
    static double robot_length_frond;
    static double robot_length_back;
    
    // Motion parameters
    static double max_linearVelocity;
    static double min_linearVelocity;
    static double max_angularVelocity;
    static double min_angularVelocity;

    static double max_linearAcceleration;
    static double min_linearAcceleration;
    static double max_angularAcceleration;
    static double min_angularAcceleration;

    static int move_direction; //1 forward 0 back

    // Lattice parameters
    static LatticeParameters localPlanParameters;

    // MPC parameters
    static double gain_state_x;
    static double gain_state_y;
    static double gain_state_theta;
    static double gain_control_v;
    static double gain_control_w;
    static int avoid_mode;
    static int path_get_method;
    static int wait_time;
    static double extra_distance;
};
