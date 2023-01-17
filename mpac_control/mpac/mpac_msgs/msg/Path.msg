#path for a given robot
int32 robot_id #TODO: Deprecate this
int32 goal_id  #TODO: Deprecate this
mpac_msgs/PoseSteering target_start
mpac_msgs/PoseSteering target_goal
mpac_msgs/PoseSteering[] path
mpac_msgs/PointType[] point_types  #0--movable  1--fixed
float64 offset
