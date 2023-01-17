#include <ros/ros.h>
#include <mpac_msgs/Path.h>
#include <mpac_msgs/Paths.h>
#include <mpac_msgs/UpdateMap.h>
#include <mpac_msgs/ControlAction.h>
#include <visualization_msgs/Marker.h>
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <geometry_msgs/Twist.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/PointCloud.h>
#include <sensor_msgs/point_cloud_conversion.h>

#include <mpac_conversions/conversions.h>
#include <mpac_global_planner/WorldOccupancyMap.h>
#include <mpac_global_planner/nav_msgs_occupancy_grid_to_planner_map.h>
#include <mpac_global_planner/CollisionDetector.h>

#include <thread>
#include <mutex>
#include <condition_variable>

#include <pcl/PCLPointCloud2.h>
#include <pcl/common/transforms.h>
#include <pcl/filters/voxel_grid.h> ///filter
#include <pcl/filters/radius_outlier_removal.h>
#include <pcl/filters/passthrough.h>
#include <pcl/point_cloud.h>
#include <pcl_conversions/pcl_conversions.h>

#include <actionlib/server/simple_action_server.h>
#include <sineva_nav/SetGoalSrv.h>
#include <sineva_nav/CheckGoalStatusSrv.h>

#include <sineva_nav/CloseSafeAreaSrv.h>

#include "lattice_planner.h"
#include "controller.h"
#include "swTimer.h"
#include "mpc.h"

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>

#include <std_msgs/Int8.h>
#include "sineva_nav/pose2D.h"

//定义控制服务器
typedef actionlib::SimpleActionServer<mpac_msgs::ControlAction> ControlServer;

class LocalPlannerNode
{
private:
    ros::Subscriber route_line_sub_;
    ros::Subscriber robot_state_sub_;
    ros::Subscriber parameters_sub_;
    ros::Subscriber pointCloud_sub_;
    ros::Subscriber camera_points_sub_;
    ros::Subscriber odometry_sub_;

    ros::Publisher map_pub_;
    ros::Publisher cmd_vel_pub_;
    ros::Publisher path_pub_;
    ros::Publisher marker_pub;
    ros::Publisher heart_beat_pub_;

    ros::ServiceServer updateMap_srv;
    ros::ServiceServer setTask_srv;
    ros::ServiceServer checkGoalStatus_srv;
    ros::ServiceServer safeAreaCheck_srv;
    ros::Timer timer_wait;
    ros::Timer timer_updateLocalTraj;
    ros::Timer timer_heartbeat;

    void RouteLineCB(const mpac_msgs::PathsConstPtr &msg);
    void RobotStateCB(const sineva_nav::pose2D::ConstPtr &msg);
    void RobotOdomCB(const nav_msgs::OdometryConstPtr &msg);

    void ParametersCB();
    bool updateMapCB(mpac_msgs::UpdateMap::Request &req, mpac_msgs::UpdateMap::Response &res);
    bool CheckGoalStatusCB(sineva_nav::CheckGoalStatusSrv::Request &req, sineva_nav::CheckGoalStatusSrv::Response &res);

    bool SafeareaCheckCB(sineva_nav::CloseSafeAreaSrv::Request &req, sineva_nav::CloseSafeAreaSrv::Response &res);

    void pointcloud2CB(sensor_msgs::PointCloud2 msg);
    void LaserPointsCB(sensor_msgs::PointCloud2 msg);
    void CameraPointsCB(sensor_msgs::PointCloud2 msg);
    void waitTimerCB(const ros::TimerEvent &);
    void pubHeartbeatTimeroutCB(const ros::TimerEvent &);

    void ExecuteTaskCB(const mpac_msgs::ControlGoalConstPtr &goal);
    void SetRoatLine(const mpac_msgs::Paths &msg);

    void PreemptCB();
    void sendCommand(Control &command);
    void updateLocalPath();
    void updateLocalPath_V2();

    nav_msgs::Odometry predictPose(nav_msgs::Odometry lastPose, double difTime);

    mpac_generic::State2dControl getLastestState2d();

    mpac_generic::State2dControl getClosestRefPoint(const mpac_generic::Path &path, const mpac_generic::Pose2d &curPose);

    mpac_generic::State2dControl getClosestRefState(const mpac_generic::Trajectory &traj, const mpac_generic::State2dControl &curState);

    ros::NodeHandle nh;

    LatticePlanner *local_planner_;
    ControllerMPC controller_;

    std::shared_ptr<WorldOccupancyMap> local_map_;
    std::shared_ptr<CollisionDetector> cd_;

    bool ref_line_seted;
    mpac_generic::State2dControl current_state;
    mpac_generic::State2dControl goal_state;
    mpac_generic::State2dControl start_state;

    mpac_generic::Control last_control;
    mpac_generic::Control max_control;
    mpac_msgs::RobotTarget current_target;

    bool reachGoal();
    void UpdateLocalTraj();
    void UpdateLocalTrajCB(const ros::TimerEvent &);
    bool isLocalTrajValid;
    bool isLocalTrajFree(mpac_generic::Trajectory &traj);
    bool isNeedToUpdateLocalTraj(mpac_generic::Trajectory &traj, mpac_generic::State2dControl &curState);
    mpac_generic::Trajectory localTraj;
    mpac_generic::Trajectory localTrajForCollisionDetector;

    double turnInPlace(double angular_diff);
    std::deque<mpac_generic::Path> control_paths_;
    std::vector<sensor_msgs::PointCloud2> dynamic_obstacles_msgs_;

    std::mutex mapMutex_;
    std::mutex stateMutex_;
    std::mutex odomMutex_;
    std::mutex trajMutex_;
    std::mutex localPlanMutex_;
    std::mutex planMutex_;
    std::mutex CollisionMutex_;

    mpac_generic::Point2dVec dynamicObstacles_;

    mpac_generic::Trajectory traj_stop;

    ControlServer control_server_;
    mpac_msgs::ControlFeedback feedback;

    double dis_goal = -1.0;
    double max_linearVelocity_set = 1.2;
    double min_linearVelocity_set = -0.3;
    double max_angleVelocity_set = 0.8;
    double max_speed_limit = max_linearVelocity_set;
    double max_speed_adjust = max_linearVelocity_set;
    double max_speed_slowDown = max_linearVelocity_set;

    std::vector<mpac_generic::Control> robot_controls_;
    mpac_generic::Control current_speed;

    nav_msgs::Odometry lastest_lidar_pose_sub;
    nav_msgs::Odometry lastest_lidar_pose_update;

    bool wait_first;
    bool localPlannerIsReady;
    bool isInChannel;

    std::thread localPlanThread;
    std::condition_variable cv_localPlan;

    double v_send;
    double w_send;

    double dis_slowDown;
    bool camera_enable = false;
    bool camera_obs = false;
    bool shutdownLaserPoints = true;

    ros::Time time_traj;
    ros::Time time_camera_stop;

public:
    LocalPlannerNode(/* args */);
    ~LocalPlannerNode();
    void start();
};

LocalPlannerNode::LocalPlannerNode(/* args */) : control_server_(nh, "local_control",
                                                                 boost::bind(&LocalPlannerNode::ExecuteTaskCB, this, _1), false)
{
    control_server_.registerPreemptCallback(boost::bind(&LocalPlannerNode::PreemptCB, this));

    ref_line_seted = false;
    last_control.v = 0.0;
    last_control.w = 0.0;

    isLocalTrajValid = false;
    wait_first = true;

    //订阅的消息
    robot_state_sub_ = nh.subscribe<sineva_nav::pose2D>("/lidar_pose", 1, &LocalPlannerNode::RobotStateCB, this);
    pointCloud_sub_ = nh.subscribe<sensor_msgs::PointCloud2>("laser_points_filtered", 1, &LocalPlannerNode::LaserPointsCB, this);
    camera_points_sub_ = nh.subscribe<sensor_msgs::PointCloud2>("camera_points_filtered", 1, &LocalPlannerNode::CameraPointsCB, this);
    odometry_sub_ = nh.subscribe<nav_msgs::Odometry>("/odom", 1, &LocalPlannerNode::RobotOdomCB, this);

    //发布的服务
    updateMap_srv = nh.advertiseService("update_map_local", &LocalPlannerNode::updateMapCB, this);
    checkGoalStatus_srv = nh.advertiseService("nav_mpac/goal_status", &LocalPlannerNode::CheckGoalStatusCB, this);
    safeAreaCheck_srv = nh.advertiseService("nav_mpac/safearea_check", &LocalPlannerNode::SafeareaCheckCB, this);


    //发布的消息
    cmd_vel_pub_ = nh.advertise<geometry_msgs::Twist>("nav_mpac/cmd_vel", 1);
    path_pub_ = nh.advertise<nav_msgs::Path>("nav_mpac/localplan_path", 1);
    marker_pub = nh.advertise<visualization_msgs::Marker>("visualization_marker", 1);
    map_pub_ = nh.advertise<nav_msgs::OccupancyGrid>("local_map", 1, true);
    heart_beat_pub_ = nh.advertise<std_msgs::Int8>("heartBeat", 1);

    //定时器
    timer_wait = nh.createTimer(ros::Duration(0), &LocalPlannerNode::waitTimerCB, this, true, false);
    timer_heartbeat = nh.createTimer(ros::Duration(1), &LocalPlannerNode::pubHeartbeatTimeroutCB, this, false, true);

    local_map_.reset(new WorldOccupancyMap());
    local_planner_ = new LatticePlanner(local_map_);
    std::unique_ptr<CollisionDetector> unique(new CollisionDetector(local_map_.get()));
    cd_ = std::move(unique);

    traj_stop.clear();
    control_server_.start();

    localPlanThread = std::thread(&LocalPlannerNode::updateLocalPath, this);
    localPlanThread.detach();

    isInChannel = false;
    localPlannerIsReady = false;

    time_traj = ros::Time::now();
    time_camera_stop = ros::Time::now();
}

LocalPlannerNode::~LocalPlannerNode()
{
    delete local_planner_;
}

void LocalPlannerNode::ExecuteTaskCB(const mpac_msgs::ControlGoalConstPtr &goal)
{
    SPDLOG_INFO("[MPAC_LOCAL_NODE] --> Execute New Task!");
    wait_first = true;
    localPlannerIsReady = false;
    //   设置控制器参数
    {
        // Motion parameters
        CP::max_linearVelocity = goal->params.max_linearVelocity;
        CP::min_linearVelocity = goal->params.min_linearVelocity;
        CP::max_angularVelocity = goal->params.max_angularVelocity;
        CP::min_angularVelocity = goal->params.min_angularVelocity;

        CP::max_linearAcceleration = goal->params.max_linearAcceleration;
        CP::min_linearAcceleration = goal->params.min_linearAcceleration;
        CP::max_angularAcceleration = goal->params.max_angularAcceleration;
        CP::min_angularAcceleration = goal->params.min_angularAcceleration;
        // MPC parameters
        CP::gain_state_x = goal->params.gain_state_x;
        CP::gain_state_y = goal->params.gain_state_y;
        CP::gain_state_theta = goal->params.gain_state_theta;
        CP::gain_control_v = goal->params.gain_control_v;
        CP::gain_control_w = goal->params.gain_control_w;

        CP::avoid_mode = goal->params.avoidMode;
        CP::wait_time = goal->params.waitTime;
        CP::extra_distance = goal->params.extraDistance;

        CP::robot_width = goal->params.robot_model.carWidth;
        CP::robot_length_frond = goal->params.robot_model.carFrontLength;
        CP::robot_length_back = goal->params.robot_model.carBackLength;

        max_linearVelocity_set = CP::max_linearVelocity;
        min_linearVelocity_set = CP::min_linearVelocity;

        max_angleVelocity_set = CP::max_angularVelocity;

        dis_slowDown = max_linearVelocity_set * max_linearVelocity_set / 0.8 + 0.5;

        controller_.init();
    }

    SPDLOG_INFO("Control Parameters: max_v [{}]  min_v [{}] avoidModel: [{}] path_get_method:{}", CP::max_linearVelocity, CP::min_linearVelocity, CP::avoid_mode, goal->task.PathGetMethod);
    current_target = goal->task.target;
    CP::path_get_method = goal->task.PathGetMethod;
    SPDLOG_INFO("Target id: {}", current_target.goalId.c_str());

    SetRoatLine(goal->task.paths);

    feedback.state = 0;

    start();

    SPDLOG_INFO("Task Is Finished");
}

void LocalPlannerNode::PreemptCB()
{
    if (control_server_.isActive())
    {
        control_server_.setPreempted();
        SPDLOG_WARN("PreemptCB!");
        Control command(0, 0);
        sendCommand(command);
    }
}

bool LocalPlannerNode::reachGoal()
{
    double dis_diff, angle_diff;

    stateMutex_.lock();
    mpac_generic::State2dControl latest_state = current_state;
    stateMutex_.unlock();

    angle_diff = goal_state.pose(2) - latest_state.pose(2);
    angle_diff = atan2(sin(angle_diff), cos(angle_diff));

    if (fabs(angle_diff) < 0.034)
    {
        dis_diff = (goal_state.pose - latest_state.pose).topRows(2).norm();
        if (fabs(dis_diff) < 0.02)
        {
            return true;
        }
    }

    return false;
}

void LocalPlannerNode::SetRoatLine(const mpac_msgs::Paths &msg)
{
    SPDLOG_INFO("[MPAC_LOCAL_NODE] --> Start Set Roat Lines: {} paths", msg.paths.size());
    control_paths_.clear();
    for (size_t i = 0; i < msg.paths.size(); i++)
    {
        mpac_generic::Path path_temp;
        path_temp = mpac_conversions::createPathFromPathMsg(msg.paths[i]);
        SPDLOG_INFO("[MPAC_LOCAL_NODE] --> Roat Line [{}] has {} points", i, path_temp.sizePath());
        path_temp.pointTypes.clear();
        for (size_t j = 0; j < path_temp.sizePath(); j++)
        {
            mpac_generic::PointType pointType;
            pointType.max_speed_ = msg.paths[i].point_types[j].maxSpeed;
            pointType.forward_ = msg.paths[i].point_types[j].forward;
            pointType.offset_ = msg.paths[i].point_types[j].offset;
            path_temp.pointTypes.push_back(pointType);
        }
        path_temp.pathDistance = mpac_generic::getTotalDistance(path_temp);
        // mpac_generic::Path path = mpac_generic::minIncrementalDistancePath(path_temp, 0.05);
        control_paths_.push_back(path_temp);
    }
    SPDLOG_INFO("[MPAC_LOCAL_NODE] --> Finish Set Roat Lines!");
}
double LocalPlannerNode::turnInPlace(double angular_diff)
{
    double ret = max_angleVelocity_set;
    if (fabs(angular_diff) > M_PI_2)
    {
        ret = max_angleVelocity_set;
    }
    else
    {
        ret = max_angleVelocity_set * cos((M_PI_2 - fabs(angular_diff)));

        ret = (ret < 0.02) ? 0.02 : ret;
    }
    ret = mpac_generic::sign(angular_diff) * ret;
    return ret;
}

void LocalPlannerNode::RobotOdomCB(const nav_msgs::OdometryConstPtr &msg)
{
    if (fabs(msg->twist.twist.linear.x) > 2.5 || fabs(msg->twist.twist.angular.z) > 5.0)
    {
        SPDLOG_ERROR("odom:{} {}", msg->twist.twist.linear.x, msg->twist.twist.angular.z);
        return;
    }

    // robot_controls_.push_back(Control(msg->twist.twist.linear.x, msg->twist.twist.angular.z));
    // if (robot_controls_.size() > 2)
    // {
    //     robot_controls_.erase(robot_controls_.begin());
    // }
    // double v_sum = 0.0;
    // double w_sum = 0.0;
    // int count = robot_controls_.size();
    // for (size_t i = 0; i < count; i++)
    // {
    //     v_sum = v_sum + robot_controls_[i].v;
    //     w_sum = w_sum + robot_controls_[i].w;
    // }

    odomMutex_.lock();
    current_speed.v = msg->twist.twist.linear.x;
    current_speed.w = msg->twist.twist.angular.z;
    odomMutex_.unlock();

    stateMutex_.lock();
    current_state.v = current_speed.v;
    current_state.w = current_speed.w;
    stateMutex_.unlock();
}

void LocalPlannerNode::RobotStateCB(const sineva_nav::pose2D::ConstPtr &msg)
{
    // stateMutex_.lock();

    nav_msgs::Odometry msg_odom;
    msg_odom.header = msg->header;
    msg_odom.pose.pose.position.x = msg->pose.x;
    msg_odom.pose.pose.position.y = msg->pose.y;
    msg_odom.pose.pose.orientation.z = sin(msg->pose.theta / 2);
    msg_odom.pose.pose.orientation.w = cos(msg->pose.theta / 2);

    mpac_generic::Pose2d pose;

    pose << msg_odom.pose.pose.position.x, msg_odom.pose.pose.position.y, tf::getYaw(msg_odom.pose.pose.orientation);

    // pose << msg->pose.x, msg->pose.y, msg->pose.theta;
    if (control_server_.isActive())
    {
        // SPDLOG_INFO("Current pose:{},{},{}", pose(0), pose(1), pose(2));
        if ((current_state.pose - pose).topRows(2).norm() > 0.5)
        {

            SPDLOG_WARN("last    pose:{} {}", current_state.pose(0), current_state.pose(1));
            SPDLOG_WARN("current pose:{} {}", pose(0), pose(1));
            // PreemptCB();
            // assert(0);
        }
        double time_diff = (msg->header.stamp - lastest_lidar_pose_sub.header.stamp).toSec();
        if (time_diff > 0.1)
        {
            SPDLOG_WARN("time diff:{}", time_diff);
        }
    }
    current_state.pose = pose;
    lastest_lidar_pose_sub = msg_odom;
    lastest_lidar_pose_update = msg_odom;
    // stateMutex_.unlock();

    int x_cell, y_cell;
    local_map_->world2map(pose(0), pose(1), x_cell, y_cell);

    //判断是否在限速区
    int value_speed = local_map_->getSpeedValueInCell(x_cell, y_cell);
    if (value_speed > 0)
    {
        max_speed_limit = value_speed / 100.0;
    }
    else
    {
        max_speed_limit = max_linearVelocity_set;
    }

    //判断是否在窄通道区
    int value_channel = local_map_->getChannelValueInCell(x_cell, y_cell);
    if (value_channel > 0)
    {
        // max_speed_limit = std::min(max_speed_limit, value_channel / 100.0);
        isInChannel = true;
    }
    else
    {
        isInChannel = false;
    }
}

bool LocalPlannerNode::updateMapCB(mpac_msgs::UpdateMap::Request &req, mpac_msgs::UpdateMap::Response &res)
{
    SPDLOG_INFO("Start updating local map!");
    mapMutex_.lock();
    if (req.updateGridMap)
    {
        for (size_t i = 0; i < req.map.data.size(); i++)
        {
            req.map.data[i] = 0;
        }
        convertNavMsgsOccupancyGridToWorldOccupancyMapRef(req.map, *local_map_, -1);
    }
    if (req.updateProhibitionMap)
    {
        convertVectorMapToWorldOccupancyMapData(req.prohibition_map, *local_map_, mpac_generic::VectorMapType::ProhibitedMap);
    }
    if (req.updateDirectionMap)
    {
        convertVectorMapToWorldOccupancyMapData(req.direction_map, *local_map_, mpac_generic::VectorMapType::DirectionMap);
    }
    if (req.updateSpeedMap)
    {
        convertVectorMapToWorldOccupancyMapData(req.speed_map, *local_map_, mpac_generic::VectorMapType::SpeedMap);
    }
    if (req.updateNarrowChannelMap)
    {
        convertVectorMapToWorldOccupancyMapData(req.channel_map, *local_map_, mpac_generic::VectorMapType::ChannelMap);
    }

    local_map_->mapMerge();
    mapMutex_.unlock();
    SPDLOG_INFO("Finish updating local map!");

    return true;
}
bool LocalPlannerNode::CheckGoalStatusCB(sineva_nav::CheckGoalStatusSrv::Request &req, sineva_nav::CheckGoalStatusSrv::Response &res)
{

    ROS_INFO("check goal status!");
    mpac_generic::Pose2d pose(req.x, req.y, req.yaw);

    res.result = !(cd_->isCollisionFree(pose, CP::robot_width / 2, CP::robot_width / 2, CP::robot_length_frond, CP::robot_length_back));

    return true;
}
bool LocalPlannerNode::SafeareaCheckCB(sineva_nav::CloseSafeAreaSrv::Request &req, sineva_nav::CloseSafeAreaSrv::Response &res)
{
    if(req.enable)   // if enable == 1 ,close laser and camera  else open
    {
        shutdownLaserPoints = true;
        camera_enable = false;  

        res.result = 0;
        return true;
    }
    else
    {
        shutdownLaserPoints = false;
        camera_enable = true; 
        
        res.result = 0;
        return true;
    }

    
}


void LocalPlannerNode::waitTimerCB(const ros::TimerEvent &)
{

    PreemptCB();
    printf("re set goal!\n");

    //二次规划前更新动态障碍物
    if (dynamicObstacles_.size() > 0)
    {
        mpac_msgs::UpdateMap updateMap_srv;
        for (size_t i = 0; i < dynamicObstacles_.size(); i++)
        {
            geometry_msgs::Point pt;
            pt.x = dynamicObstacles_[i].x();
            pt.y = dynamicObstacles_[i].y();
            updateMap_srv.request.dynamic_map.vertices.push_back(pt);
        }
        ros::ServiceClient client = nh.serviceClient<mpac_msgs::UpdateMap>("update_map_global");
        updateMap_srv.request.updateDynamicMap = true;
        client.call(updateMap_srv);
    }

    sineva_nav::SetGoalSrv srv_SetGoal;
    geometry_msgs::Pose goal_pose;
    srv_SetGoal.request.goal = current_target.goal.pose;
    srv_SetGoal.request.goal_id = current_target.goalId;
    srv_SetGoal.request.timeout = -1;
    srv_SetGoal.response.result = -1;

    ros::ServiceClient client = nh.serviceClient<sineva_nav::SetGoalSrv>("nav_mpac/set_goal");
    client.call(srv_SetGoal);
    // assert(0);
}
mpac_generic::State2dControl LocalPlannerNode::getClosestRefPoint(const mpac_generic::Path &path, const mpac_generic::Pose2d &curPose)
{
    double dis_min = 1000.0;
    int index_closest = 0;
    int num_points = path.sizePath();
    for (size_t i = 0; i < num_points; i++)
    {
        double dis_tmp = (path.poses[i] - curPose).topRows(2).norm();
        if (dis_tmp < dis_min)
        {
            dis_min = dis_tmp;
            index_closest = i;
        }
    }

    mpac_generic::State2dControl closestControlPoint;
    closestControlPoint.pose = path.poses[index_closest];
    closestControlPoint.v = path.pointTypes[index_closest].max_speed_;
    closestControlPoint.w = CP::max_angularVelocity;

    CP::localPlanParameters.max_width_sample = path.pointTypes[index_closest].offset_;
    CP::localPlanParameters.step_width_sample = 0.05;

    if (isInChannel || max_linearVelocity_set > 1.5)
    {
        CP::localPlanParameters.max_width_sample = 0.2;
        CP::localPlanParameters.step_width_sample = 0.02;
        // spdlog::info("IN CHANNEL!");
    }

    return closestControlPoint;
}

mpac_generic::State2dControl LocalPlannerNode::getClosestRefState(const mpac_generic::Trajectory &ref_traj, const mpac_generic::State2dControl &curState)
{
    mpac_generic::State2dControl result = curState;
    
    int index_cloest = 0;
    double dis_min = 100000;

    for (size_t i = 0; i < ref_traj.poses.size(); i++)
    {

        double dis_tem = (curState.pose - ref_traj.poses[i]).topRows(2).norm();
        if (dis_tem < dis_min)
        {
            dis_min = dis_tem;
            result.pose = ref_traj.poses[i];
            result.v = ref_traj.getControl(i).v;
            result.v = ref_traj.getControl(i).w;
        }
    }
    return result;
}

mpac_generic::State2dControl LocalPlannerNode::getLastestState2d()
{
    double v = 0.0;
    double w = 0.0;

    {
        std::lock_guard<std::mutex> lk(odomMutex_);
        v = current_speed.v;
        w = current_speed.w;
    }

    stateMutex_.lock();

    mpac_generic::State2dControl lastest_state;
    ros::Time current_time = ros::Time::now();
    double time_diff = (current_time - lastest_lidar_pose_update.header.stamp).toSec();
    double ds = time_diff * v;
    double da = time_diff * w;
    double yaw = tf::getYaw(lastest_lidar_pose_update.pose.pose.orientation);
    lastest_state.pose(0) = lastest_lidar_pose_update.pose.pose.position.x + ds * cos(yaw + da / 2.0);
    lastest_state.pose(1) = lastest_lidar_pose_update.pose.pose.position.y + ds * sin(yaw + da / 2.0);
    lastest_state.pose(2) = yaw + da;
    lastest_state.pose(2) = atan2(sin(lastest_state.pose(2)), cos(lastest_state.pose(2)));
    // lastest_state.v = current_state.v;
    // lastest_state.w = current_state.w;
    lastest_state.v = v_send;
    lastest_state.w = w_send;

    lastest_lidar_pose_update.header.stamp = current_time;
    lastest_lidar_pose_update.pose.pose.position.x = lastest_state.pose(0);
    lastest_lidar_pose_update.pose.pose.position.y = lastest_state.pose(1);
    lastest_lidar_pose_update.pose.pose.orientation = tf::createQuaternionMsgFromYaw(lastest_state.pose(2));

    stateMutex_.unlock();

    return lastest_state;
}

void LocalPlannerNode::start()
{

    ros::Rate rate(20);

    while (ros::ok() && !control_paths_.empty() && control_server_.isActive())
    {
        localTraj.clear();
        isLocalTrajValid = false;
        mpac_generic::Path cur_path = control_paths_.front();
        control_paths_.pop_front();
        mpac_generic::Path line_ref = mpac_generic::minIncrementalDistancePath(cur_path, 0.1);

        localPlannerIsReady = false;
        {
            std::lock_guard<std::mutex> lock(localPlanMutex_);
            if (!local_planner_->setRefLine(line_ref))
            {
                SPDLOG_ERROR("Failed to set reference path！");
                PreemptCB();
            }
            else
            {
                SPDLOG_INFO("Succeed to set reference path！");
                localPlannerIsReady = true;
            }
        }

        //实际目标点作为最后一条轨迹的终点
        if (control_paths_.empty())
        {
            goal_state.pose(0) = current_target.goal.pose.position.x;
            goal_state.pose(1) = current_target.goal.pose.position.y;
            goal_state.pose(2) = tf::getYaw(current_target.goal.pose.orientation);
            goal_state.v = 0.0;
            goal_state.w = 0.0;
        }
        else
        {
            goal_state.pose(0) = control_paths_.front().poses.front()(0);
            goal_state.pose(1) = control_paths_.front().poses.front()(1);
            double dir_yaw = control_paths_.front().poses.front()(2);
            goal_state.pose(2) = dir_yaw;
            goal_state.v = 0.0;
            goal_state.w = 0.0;
        }

        start_state.pose = local_planner_->getRefPoint(cur_path.poses.front());
        start_state.v = 0.0;
        start_state.w = 0.0;

        bool reachgoal = false;
        bool isRotationInPlaceEnd = false;
        bool isRotationInPlaceStart = true;

        //判断当前路径的运动方向
        if (cur_path.pointTypes[0].forward_)
        {
            CP::move_direction = 1;
        }
        else
        {
            CP::move_direction = 0;
            double yaw = start_state.pose.z() + M_PI;
            start_state.pose.z() = atan2(sin(yaw), cos(yaw));
        }

        spdlog::info("GOAL POINT:({} {} {}),move direction:{}", goal_state.pose(0), goal_state.pose(1), goal_state.pose(2), CP::move_direction);
        {
            std::lock_guard<std::mutex> lock(localPlanMutex_);
            UpdateLocalTraj();
        }

        while (ros::ok() && !reachgoal && control_server_.isActive())
        {
            Control command;
            ros::spinOnce();

            //轨迹跟踪
            {
                mpac_generic::State2dControl lastest_state = getLastestState2d();
                double dis_left = local_planner_->getResidualDistance(lastest_state);

                //计算距离目标点的剩余路程
                double dis_left_total = dis_left;
                for (size_t i = 0; i < control_paths_.size(); i++)
                {
                    dis_left_total = dis_left_total + control_paths_[i].pathDistance;
                }

                if (!isLocalTrajValid || camera_obs)
                {
                    spdlog::error("Local plan failed!");
                    command.v = 0.0;
                    command.w = 0.0;
                    feedback.state = -1;
                    feedback.remainingDistance = dis_left_total;
                }
                else //基于局部轨迹进行运动控制
                {

                    mpac_generic::State2dControl closestControlPoint = getClosestRefPoint(cur_path, lastest_state.pose);

                    //根据离目标距离，进行速度调节
                    if (dis_left > dis_slowDown)
                    {
                        if (CP::move_direction == 1)
                        {
                            CP::max_linearVelocity = std::min({max_linearVelocity_set, max_speed_limit, closestControlPoint.v, max_speed_adjust});
                            CP::min_linearVelocity = 0.0;
                        }
                        else
                        {
                            CP::max_linearVelocity = 0.0;
                            CP::min_linearVelocity = std::max({min_linearVelocity_set, -max_speed_limit, closestControlPoint.v});
                        }
                    }
                    else
                    {
                        if (CP::move_direction == 1)
                        {
                            max_speed_slowDown = max_linearVelocity_set * cos((dis_slowDown - dis_left) / dis_slowDown * M_PI_2);
                            CP::max_linearVelocity = std::min({max_speed_slowDown, max_speed_limit, closestControlPoint.v, max_speed_adjust});
                            CP::max_linearVelocity = std::max(CP::max_linearVelocity, 0.02);
                            CP::min_linearVelocity = 0.0;
                        }
                        else
                        {
                            CP::max_linearVelocity = 0.0;
                            max_speed_slowDown = min_linearVelocity_set * cos((dis_slowDown - dis_left) / dis_slowDown * M_PI_2);
                            CP::min_linearVelocity = std::max({max_speed_slowDown, -max_speed_limit, closestControlPoint.v});
                            CP::min_linearVelocity = std::min(CP::min_linearVelocity, -0.02);
                        }
                        if (dis_left < 0.01)
                        {
                            isRotationInPlaceEnd = true;
                            spdlog::info("stop pose:{},{},{},{},{}", lastest_state.pose(0), lastest_state.pose(1), lastest_state.pose(2), current_speed.v, current_speed.w);
                        }
                    }

                    if (isRotationInPlaceStart)
                    {
                        //起步阶段进行方向调整
                        double angular_diff = getAngularNormDist(start_state.getPose2d(), lastest_state.getPose2d());
                        if (fabs(angular_diff) < 0.034) //到达目标位姿
                        {
                            command.v = 0.0;
                            command.w = 0.0;
                            isRotationInPlaceStart = false;
                        }
                        else //原地旋转
                        {
                            command.v = 0.0;
                            command.w = turnInPlace(angular_diff);
                            feedback.state = 0;
                            camera_enable = false;
                            // spdlog::info("Start rotating in place at the start point: angle_diff[{}]  w[{}]！",angular_diff,command.w);
                        }
                    }
                    else if (isRotationInPlaceEnd)
                    {
                        //停靠阶段进行方向调整
                        double angular_diff = getAngularNormDist(goal_state.getPose2d(), lastest_state.getPose2d());
                        if (fabs(angular_diff) < 0.017) //到达目标位姿
                        {
                            command.v = 0.0;
                            command.w = 0.0;
                            feedback.state = 0;
                            reachgoal = true;
                            localTraj.clear();
                            if (control_paths_.empty())
                            {
                                feedback.state = 1;
                            }
                            else
                            {
                                feedback.state = 0;
                            }
            
                        }
                        else //原地旋转
                        {
                            command.v = 0.0;
                            command.w = turnInPlace(angular_diff);
                            feedback.state = 0;
                            camera_enable = false; 
                            // spdlog::info("Start rotating in place at the goal point: angle_diff[{}]  w[{}]！",angular_diff,command.w);
                        }
                    }
                    else
                    {
                        //正常行走阶段，mpc控制器获取速度指令
                        trajMutex_.lock();
                        ros::Time start_ = ros::Time::now();
                        if (dis_left <dis_slowDown)
                        {
                            controller_.getCommandStop(lastest_state, localTraj, command);
                        }
                        else
                        {
                            controller_.getCommand(lastest_state, localTraj, command);
                        }
                        camera_enable = true;
                        trajMutex_.unlock();
                        feedback.state = 0;
                    }
                }
            }
            //发布状态和速度
            control_server_.publishFeedback(feedback);
            sendCommand(command);

            if (reachgoal && control_paths_.empty())
            {
                control_server_.setSucceeded();
                spdlog::info("Control Server Set Succeed");
                return;
            }

            rate.sleep();
        }
    }
}

void LocalPlannerNode::pointcloud2CB(sensor_msgs::PointCloud2 msg)
{

    swTimer timer_build;

    // 只有在激活状态时才处理动态点云

    // if (!control_server_.isActive())
    // {
    //     return;
    // }

    dynamic_obstacles_msgs_.push_back(msg);
    if (dynamic_obstacles_msgs_.size() > 2)
    {
        dynamic_obstacles_msgs_.erase(dynamic_obstacles_msgs_.begin());
    }
    swTimer timer_pts;
    mapMutex_.lock();
    timer_pts.stop();
    std::cout << "更新动态点云解锁用时：" << timer_pts.get() << std::endl;
    timer_pts.start();
    if (!dynamicObstacles_.empty())
    {
        local_map_->removeObstacles(dynamicObstacles_);
        dynamicObstacles_.clear();
    }
    timer_pts.stop();
    std::cout << "清空动态点云用时：" << timer_pts.get() << std::endl;

    for (size_t i = 0; i < dynamic_obstacles_msgs_.size(); i++)
    {
        sensor_msgs::PointCloud pointCloud;
        sensor_msgs::convertPointCloud2ToPointCloud(dynamic_obstacles_msgs_[i], pointCloud);
        for (size_t j = 0; j < pointCloud.points.size(); j++)
        {
            Eigen::Vector2d point;
            point << pointCloud.points[j].x, pointCloud.points[j].y;
            dynamicObstacles_.push_back(point);
        }
    }

    local_map_->addObstacles(dynamicObstacles_);
    timer_pts.start();
    mpac_generic::State2dControl lastest_state = getLastestState2d();

    local_map_->updateLocalMap(dynamicObstacles_, lastest_state.pose);

    mapMutex_.unlock();
    timer_pts.stop();
    std::cout << "更新局部地图用时：" << timer_pts.get() << std::endl;
}

void LocalPlannerNode::LaserPointsCB(sensor_msgs::PointCloud2 msg)
{

    // 只有在激活状态时才处理动态点云

    if (!control_server_.isActive())
    {
        return;
    }

    if(shutdownLaserPoints)
    {
        if(!dynamicObstacles_.empty())
        {
            dynamicObstacles_.clear();
        }
        return;   
    }


    dynamic_obstacles_msgs_.push_back(msg);
    if (dynamic_obstacles_msgs_.size() > 5)
    {
        dynamic_obstacles_msgs_.erase(dynamic_obstacles_msgs_.begin());
    }
    dynamicObstacles_.clear();

    for (size_t i = 0; i < dynamic_obstacles_msgs_.size(); i++)
    {
        sensor_msgs::PointCloud pointCloud;
        sensor_msgs::convertPointCloud2ToPointCloud(dynamic_obstacles_msgs_[i], pointCloud);
        for (size_t j = 0; j < pointCloud.points.size(); j++)
        {
            Eigen::Vector2d point;
            int x_cell, y_cell;
            local_map_->world2map(pointCloud.points[j].x, pointCloud.points[j].y, x_cell, y_cell);

            //判断是否在窄通道
            int value_channel = local_map_->getChannelValueInCell(x_cell, y_cell);
            if (value_channel > 0 && value_channel < 100)
            {
                continue;
            }
            point << pointCloud.points[j].x, pointCloud.points[j].y;
            dynamicObstacles_.push_back(point);
        }
    }

    mpac_generic::State2dControl lastest_state = getLastestState2d();
    swTimer timer_pts;
    mapMutex_.lock();
    local_map_->updateLocalMap(dynamicObstacles_, lastest_state.pose);
    mapMutex_.unlock();
    timer_pts.stop();
    // std::cout<<"更新局部地图用时："<<timer_pts.get()<<std::endl;
}

void LocalPlannerNode::CameraPointsCB(sensor_msgs::PointCloud2 msg)
{

    // spdlog::info("获取视觉点云");

    //获取局部轨迹
    {
        std::lock_guard<std::mutex> lock(trajMutex_);
        localTrajForCollisionDetector = localTraj;
    }
    //如果局部轨迹路径点数量小于1，直接返回
    if(localTrajForCollisionDetector.poses.size()<1)
    {
        return;
    }

    //点云转换
    sensor_msgs::PointCloud pointCloud;
    sensor_msgs::convertPointCloud2ToPointCloud(msg, pointCloud);

    //计算点云到局部路径距离
    for (size_t j = 0; j < pointCloud.points.size(); j++)
    {
        mpac_generic::State2dControl camera_point;
        camera_point.pose(0) = pointCloud.points[j].x;
        camera_point.pose(1) = pointCloud.points[j].y;

        mpac_generic::State2dControl closest_waypoint;

        closest_waypoint = getClosestRefState(localTrajForCollisionDetector,camera_point);

        // spdlog::info("point_cam:{},{}    point_path:{},{}",camera_point.pose(0),camera_point.pose(1),closest_waypoint.pose(0),closest_waypoint.pose(1));
                
        double distance_start = hypot(camera_point.pose(0)-current_state.pose(0),camera_point.pose(1)-current_state.pose(1));
        double distance = hypot(camera_point.pose(0)-closest_waypoint.pose(0),camera_point.pose(1)-closest_waypoint.pose(1));

        if(distance_start < 0.7)        //如果车辆正在旋转 使用它判断 
        {
            //  spdlog::warn("distance:{}",distance_start);   
            // time_camera_stop = ros::Time::now();
            return ;
        }
        if((distance < CP::robot_width/2+0.02) && camera_enable)  //如果车辆正在旋转   false 
        {
            Eigen::Vector2d point;
            int x_cell, y_cell;
            local_map_->world2map(pointCloud.points[j].x, pointCloud.points[j].y, x_cell, y_cell);

            //判断是否在窄通道
            int value_channel = local_map_->getChannelValueInCell(x_cell, y_cell);
            if (value_channel > 0 && value_channel < 100)
            {
                if(distance < CP::robot_width/2-0.1)
                {
                    time_camera_stop = ros::Time::now();
                    return;
                }
            }
            else
            {
                time_camera_stop = ros::Time::now();
                return ;
            }
            //spdlog::info("cam_v_w:{},{}",closest_waypoint.v,closest_waypoint.w);
  
        }

    }
}

void LocalPlannerNode::sendCommand(Control &command)
{

    // ROS_INFO("[MPAC_LOCAL_NODE] --> Seed Command:(%f %f)  current V(%f %f)", command.v, command.w, current_state.v, current_state.w);
    // SPDLOG_INFO("Command:{},{}", command.v, command.w);
    //碰撞检测
    //最小停止时间
    // double time_stop = std::max(fabs(command.v/CP::max_linearAcceleration),fabs(command.w/CP::max_angularAcceleration))+0.1;
    // double time_predict = 0.1;
    geometry_msgs::Twist twist;
    twist.linear.z = 1;
    int num_predict = 1;
    // double v_inc = command.v / num_predict;
    // double w_inc = command.w / num_predict;

    // //预测周期0.1
    // mpac_generic::Pose2d next_pose = getLastestState2d().pose;

    // for (size_t i = 0; i < num_predict; i++)
    // {

    //     next_pose(0) = next_pose(0) + command.v * num_predict * 0.1 * cos(next_pose(2) + command.w * num_predict * 0.1 / 2.0);
    //     next_pose(1) = next_pose(1) + command.v * num_predict * 0.1 * sin(next_pose(2) + command.w * num_predict * 0.1 / 2.0);
    //     next_pose(2) = next_pose(2) + command.w * num_predict * 0.1;
    //     next_pose(2) = atan2(sin(next_pose(2)), cos(next_pose(2)));
    //     if (!cd_->isCollisionFree(next_pose, CP::robot_width / 2, CP::robot_width / 2, CP::robot_length_frond, CP::robot_length_back))
    //     {
    //         command.v = 0.0;
    //         command.w = 0.0;
    //         twist.linear.z = -1;
    //         SPDLOG_ERROR("!!!!!!!!!!!!Collision!!!!!!!!!!!!!!");
    //         break;
    //     }
    // }

        if((ros::Time::now()-time_camera_stop).toSec()<2)      
        {
            camera_obs = true;
            command.v = 0.0;
            command.w = 0.0;  
            spdlog::warn("直线停止!    视觉避障触发!");                      
        }else
        {
            camera_obs = false;
        }
        

    twist.linear.x = command.v;
    twist.angular.z = command.w;

    // spdlog::info("cmd:{}  speed:{}",command.v,current_speed.v);
    // if (fabs(command.v)<0.01 && fabs(v_send)>0.01)
    // {
    //     twist.linear.z = -1;
    // }

    v_send = twist.linear.x;
    w_send = twist.angular.z;

    cmd_vel_pub_.publish(twist);
}

void LocalPlannerNode::updateLocalPath()
{
    while (true)
    {
        {
            std::lock_guard<std::mutex> lock(localPlanMutex_);
            UpdateLocalTraj();
        }
        usleep(1000 * 100);
    }
}

void LocalPlannerNode::updateLocalPath_V2()
{
    while (true)
    {
        std::unique_lock<std::mutex> lck(planMutex_);
        cv_localPlan.wait(lck);
        {
            std::lock_guard<std::mutex> lock(localPlanMutex_);
            UpdateLocalTraj();
        }
    }
}

void LocalPlannerNode::UpdateLocalTrajCB(const ros::TimerEvent &)
{
    std::lock_guard<std::mutex> lock(localPlanMutex_);
    ros::Time start_ = ros::Time::now();
    UpdateLocalTraj();
}

void LocalPlannerNode::UpdateLocalTraj()
{

    if (!control_server_.isActive())
    {
        return;
    }

    if (!localPlannerIsReady)
    {
        SPDLOG_INFO("Local Planner Is Not Ready!");
        return;
    }

    if (!cd_->isCollisionFree(goal_state.pose, CP::robot_width / 2, CP::robot_width / 2, CP::robot_length_frond, CP::robot_length_back))
    {
        spdlog::info("目标点被占用");
        isLocalTrajValid = false;
        // return;
    }

    //正常状态下每0.5s做一次局部规划
    if (isLocalTrajFree(localTraj))
    {
        if ((ros::Time::now() - time_traj).toSec() < 0.5 && isLocalTrajValid)
        {
            return;
        }
    }
    else
    {
        spdlog::info("道路被阻");
        isLocalTrajValid = false;
    }

    mpac_generic::State2dControl latest_state;
    {
        std::lock_guard<std::mutex> lk(stateMutex_);
        latest_state = current_state;
    }

    mpac_generic::State2dControl start_state;

    start_state =   getClosestRefState(localTraj,latest_state);
    dis_goal = local_planner_->getResidualDistance(latest_state);
    mpac_generic::Trajectory tempTrajectory;
    ros::Time start_time = ros::Time::now();
    { // get local path by lattice
        std::lock_guard<std::mutex> lock(mapMutex_);
        if (dis_goal > 2)
        {
            isLocalTrajValid = local_planner_->getLocalTrajecoty(start_state, tempTrajectory, sampleMode::CRUISING);
        }
        else
        {
            if ((dis_goal > 1) || !(localTraj.poses.size() > 0) || !isLocalTrajValid)
            {
                isLocalTrajValid = local_planner_->getLocalTrajecoty(start_state, tempTrajectory, sampleMode::STOPPING);
            }
            else
            {
                return;
            }
        }
    }

    // spdlog::info("local plan using time:{}", (ros::Time::now() - start_time).toSec());

    if (isLocalTrajValid)
    {

        time_traj = ros::Time::now();

        {
            std::lock_guard<std::mutex> lock(trajMutex_);
            localTraj = tempTrajectory;
        }

        //发布局部路径
        nav_msgs::Path pathmsg;
        pathmsg.header.frame_id = "map";
        pathmsg.header.stamp = ros::Time::now();
        geometry_msgs::PoseStamped pose;
        pose.header.frame_id = "map";
        pose.header.stamp = pathmsg.header.stamp;

        for (size_t i = 0; i < tempTrajectory.sizePath(); i++)
        {
            pose.pose.position.x = tempTrajectory.poses[i](0);
            pose.pose.position.y = tempTrajectory.poses[i](1);
            pathmsg.poses.push_back(pose);
        }
        path_pub_.publish(pathmsg);
    }else
    {
        spdlog::warn("局部路径规划失败！");
    }
}

bool LocalPlannerNode::isLocalTrajFree(mpac_generic::Trajectory &traj)
{

    if (traj.sizePath() < 1)
    {
        spdlog::warn("轨迹为空");
        return true;
    }

    double dis_free = 0.0;
    double dis_all = 0.0;
    double dis_safe = 0.2; //局部路线距离障碍物0.2m的时候需要减速
    double dis_inc = 0.0;
    bool find = false;
    if (isInChannel)
    {
        dis_safe = -0.1;
    }

    for (size_t i = 1; i < localTraj.sizePath(); i++)
    {
        mapMutex_.lock();
        double dis_obs = local_map_->getShortestDistanceFromObstacles(localTraj.poses[i]);
        mapMutex_.unlock();

        if (dis_obs < (CP::robot_width / 2.0))
        {
            SPDLOG_INFO("The current local trajectory is not free,need to update! pose:{},{}  distance from obstacles:{}", localTraj.poses[i].x(), localTraj.poses[i].y(), dis_obs);
            return false;
        }
        if (dis_obs < (CP::robot_width / 2.0 + dis_safe))
        {
            find = true;
        }

        //遇障减速，窄通道不减速
        dis_inc = hypot(localTraj.poses[i](0) - localTraj.poses[i - 1](0), localTraj.poses[i](1) - localTraj.poses[i - 1](1));
        if (!find)
        {
            dis_free += dis_inc;
        }

        dis_all += dis_inc;
    }
    // mapMutex_.unlock();
    max_speed_adjust = max_linearVelocity_set;
    max_speed_adjust = dis_free / dis_all * (max_linearVelocity_set - 0.3) + 0.3;

    // spdlog::info("dis_free:{}   dis_all:{}",dis_free,dis_all);

    return true;
}

bool LocalPlannerNode::isNeedToUpdateLocalTraj(mpac_generic::Trajectory &traj, mpac_generic::State2dControl &curState)
{
    if (!isLocalTrajFree(traj))
    {
        return true;
    }

    //计算剩余距离
    double dis_min = 1000;
    int index_min = 0;
    for (size_t i = 1; i < localTraj.sizePath(); i++)
    {
        double dis_tmp = hypot(localTraj.poses[i](0) - curState.pose[0], localTraj.poses[i](1) - curState.pose[1]);
        if (dis_tmp < dis_min)
        {
            dis_min = dis_tmp;
            index_min = i;
        }
    }

    if (index_min == 0)
    {
        return false;
    }

    double dis_left = 0;
    for (size_t i = index_min; i < localTraj.sizePath(); i++)
    {
        dis_left += hypot(localTraj.poses[i](0) - localTraj.poses[i - 1](0), localTraj.poses[i](1) - localTraj.poses[i - 1](1));
    }

    return dis_left < fabs(curState.v) * 0.5;
}

void LocalPlannerNode::pubHeartbeatTimeroutCB(const ros::TimerEvent &)
{
    std_msgs::Int8 heartBeatmsg;
    heartBeatmsg.data = 4; // 4-local planner node
    heart_beat_pub_.publish(heartBeatmsg);
}

int main(int argc, char **argv)
{

    // log
    std::vector<spdlog::sink_ptr> spdlog_sinks;
    spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());
    // spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>("~/tmp/mpac/mpac_local_planner.log", true));
    spdlog_sinks[0]->set_level(spdlog::level::info);
    // spdlog_sinks[1]->set_level(spdlog::level::debug);
    auto localPlannerLogger = std::make_shared<spdlog::logger>("localPlanner", spdlog_sinks.begin(), spdlog_sinks.end());
    spdlog::set_default_logger(localPlannerLogger);
    spdlog::set_level(spdlog::level::debug);
    localPlannerLogger->info("local planner launched!");
    // log

    ros::init(argc, argv, "mpac_local_planner_node");
    ros::NodeHandle params("~");

    LocalPlannerNode planner;
    ros::spin();
}
