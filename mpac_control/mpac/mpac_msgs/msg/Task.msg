#task for a given robot
mpac_msgs/RobotTarget target
mpac_msgs/Path path
mpac_msgs/Paths paths
int32 criticalPoint #path point beyond which robot should not proceed (-1 means no critical point)
int32 criticalRobotID #robot responsible for "releasing" the criticalPoint
int32 releasingPoint #point criticalRobotID should reach to release criticalPoint
mpac_msgs/RobotConstraints constraints
mpac_msgs/DeltaTVec dts
mpac_msgs/CoordinatorTimeVec cts
bool update # if this task is based on a previous task (e.g. updated with a new path path or coordination times etc.)
bool abort # if the current task should be aborted - the vehicle will enter the WAIT_STATE
int32 PathGetMethod #The method to get the path, 0--free plan by grid map  1--track plan in road net
