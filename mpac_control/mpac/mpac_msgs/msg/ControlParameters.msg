#necessary parameters used by controller

#Sharp parameters
mpac_msgs/RobotConfigs robot_model

# Motion parameters
float32 max_linearVelocity
float32 min_linearVelocity
float32 max_angularVelocity
float32 min_angularVelocity

float32 max_linearAcceleration
float32 min_linearAcceleration
float32 max_angularAcceleration
float32 min_angularAcceleration

# MPC parameters

float32 gain_state_x
float32 gain_state_y
float32 gain_state_theta
float32 gain_control_v
float32 gain_control_w

# Plan parameters

int32 AVOID = 0 
int32 WAIT = 1

int32 avoidMode #AVOID　or WAIT
int32 waitTime #the max time when planMode is wait
float32 extraDistance