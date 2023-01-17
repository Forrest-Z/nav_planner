#include <ros/ros.h>

#include <tf/transform_datatypes.h>

#include <visualization_msgs/Marker.h>
#include <mpac_rviz/mpac_rviz.h>
#include <nav_msgs/Path.h>
#include <std_msgs/Int8.h>

#include <mpac_generic/path_utils.h>
#include <mpac_generic/io.h>
#include <mpac_generic/utils.h>

#include <mpac_geometry/geometry.h>
#include <mpac_geometry/pallet_model_2d.h>

#include <mpac_msgs/ComputeTask.h>
#include <mpac_msgs/UpdateTask.h>
#include <mpac_msgs/ExecuteTask.h>
#include <mpac_msgs/GetPath.h>
#include <mpac_msgs/GetGeoFence.h>
#include <mpac_msgs/GetVectorMap.h>
#include <mpac_msgs/GetPolygonConstraints.h>
#include <mpac_msgs/GetSmoothedPath.h>
#include <mpac_msgs/GetSmoothedStraightPath.h>
#include <mpac_msgs/GetDeltaTVec.h>
#include <mpac_msgs/ObjectPoseEstimation.h>
#include <mpac_msgs/ComputeTask.h>
#include <mpac_msgs/SetTask.h>
#include <mpac_msgs/UpdateMap.h>
#include <mpac_msgs/ControllerTrajectoryChunkVec.h>
#include <mpac_msgs/ControllerTrajectoryChunk.h>
#include <mpac_msgs/ControllerCommand.h>
#include <mpac_msgs/ControllerReport.h>
#include <mpac_msgs/RobotTarget.h>
#include <mpac_msgs/ForkReport.h>
#include <mpac_msgs/ForkCommand.h>
#include <mpac_msgs/RobotReport.h>
#include <mpac_msgs/ObjectPose.h>
#include <mpac_msgs/VectorMap.h>
#include <mpac_msgs/GeoFence.h>
#include <mpac_msgs/RobotConfigs.h>
#include <mpac_msgs/ControlParameters.h>
#include <mpac_msgs/PlanParameters.h>
#include <mpac_msgs/UpdateCarModel.h>
#include <mpac_msgs/ControlAction.h>
#include <actionlib/client/simple_action_client.h>

#include <mpac_constraint_extract/polygon_constraint.h> // Only used for visualization.
#include <mpac_constraint_extract/conversions.h>
#include <mpac_constraint_extract/grid_map.h>
#include <mpac_constraint_extract/utils.h>

#include <boost/thread/condition.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/thread.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/archive/text_oarchive.hpp>
#include <boost/serialization/vector.hpp>
#include <boost/serialization/utility.hpp> // for std::pair
#include <iostream>
#include <fstream>

#include <mpac_manager/pallet_handling_utils.h>
#include <mpac_manager/vehicle_state.h>
#include <mpac_manager/trajectory_generation.h>
// #include <mpac_node_utils/robot_target_handler.h>
#include <mpac_trajectory_processor/trajectory_processor_naive_ct.h>
#include <mpac_trajectory_processor/trajectory_processor_naive.h>

#include <sensor_msgs/LaserScan.h>
#include <tf/transform_listener.h>
#include <laser_geometry/laser_geometry.h>
#include <std_msgs/Float64MultiArray.h>

#include <nav_msgs/Odometry.h>

#include "rapidjson/document.h"
#include "spdlog/spdlog.h"

#include <sineva_nav/CancelGoalSrv.h>
#include <sineva_nav/CheckGoalStatusSrv.h>
#include <sineva_nav/EnableSrv.h>
#include <sineva_nav/GetStateSrv.h>
#include <sineva_nav/JsonCommSrv.h>
#include <sineva_nav/SetGoalSrv.h>
#include <sineva_nav/SetInitialPoseSrv.h>
#include <sineva_nav/SetPathSrv.h>
#include <sineva_nav/MapReq.h>
#include <sineva_nav/UpdateMapSrv.h>
#include "sineva_nav/pose2D.h"

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>

#include <execinfo.h>
#include <signal.h>

#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/PointCloud.h>
#include <sensor_msgs/point_cloud_conversion.h>

//控制客户端
typedef actionlib::SimpleActionClient<mpac_msgs::ControlAction> ControlClient;

class KMOVehicleExecutionNode
{

private:
  ros::NodeHandle nh_;

  ros::ServiceServer service_compute_;
  ros::ServiceServer service_execute_;
  ros::ServiceServer service_setGoal_;
  ros::ServiceServer service_cancelGoal_;
  ros::ServiceServer service_getTaskStatus_;
  ros::ServiceServer service_goalStatus_;
  ros::ServiceServer service_setPlanner_;
  ros::ServiceServer service_updateGridMap_;
  ros::ServiceServer service_updateVectorMap_;
  ros::ServiceServer service_updateRoadNetMap_;

  ros::Publisher command_pub_;
  ros::Publisher marker_pub_;
  ros::Publisher path_pub_;
  ros::Publisher global_path_pub_;
  ros::Publisher heart_beat_pub_;

  ros::Subscriber point_cloud_sub_;
  ros::Subscriber robot_pose_sub_;
  ros::Subscriber control_report_sub_;
  ros::Subscriber fork_report_sub_;
  ros::Subscriber enc_sub_;
  ros::Subscriber map_sub_;
  ros::Subscriber pallet_poses_sub_;
  ros::Subscriber velocity_constraints_sub_;

  ros::Timer timer_plan_;
  ros::Timer timer_pub_global_path_;
  ros::Timer timer_heartbeat;
  ros::Timer timer_wait;

  ControlClient control_client_;

  boost::mutex map_mutex_, inputs_mutex_, current_mutex_, plan_mutex_, control_mutex_, task_status_mutex_, points_mutex_;

  boost::thread client_thread_plan_;
  boost::thread client_thread_control_;
  boost::condition_variable cond_plan_;
  boost::condition_variable cond_control_;

  bool valid_map_;
  nav_msgs::OccupancyGrid current_map_;

  nav_msgs::Odometry current_state_;
  nav_msgs::Path current_global_path_;

  mpac_msgs::RobotTarget current_target_;
  mpac_msgs::RobotConfigs robot_configs_;
  mpac_msgs::PlanParameters plan_parameters_;
  mpac_msgs::ControlParameters control_parameters_;

  mpac_msgs::Task current_task_;
  mpac_generic::TaskStatus task_status_;

  // Visualization params
  bool visualize_;

  // Used for the laser safety functionallities - important, the boost polygon performs really bad when used in debug mode (factor of 100s).
  // tf::TransformListener tf_listener_

  bool isPlanningTimeout;
  bool isCancelGoal;

  bool valid_planner_;

  bool isPlanning;

  std_msgs::Int8 heartBeatmsg;

  sensor_msgs::PointCloud2ConstPtr dynamicPointsMsg;

  double remainingDistance;
  double maxOffsetDistance;
  double waitTime;

  bool goalIsCanceled;

  int goalCount;
  // mpac_geometry::Polygons nonCrossingAreas;

public:
  KMOVehicleExecutionNode(ros::NodeHandle &paramHandle) : control_client_("local_control", true)
  {

    // Robot Parameters
    paramHandle.param<std::string>("model", robot_configs_.carModel, std::string("agv_s200"));
    paramHandle.param<float>("height", robot_configs_.carHeight, 0.3);
    paramHandle.param<float>("length", robot_configs_.carLength, 0.96);
    paramHandle.param<float>("width", robot_configs_.carWidth, 0.70);
    paramHandle.param<bool>("visualize", visualize_, false);

    // Control Parameters
    paramHandle.param<float>("max_linearVelocity", control_parameters_.max_linearVelocity, 1.0);
    paramHandle.param<float>("min_linearVelocity", control_parameters_.min_linearVelocity, -0.3);
    paramHandle.param<float>("max_angularVelocity", control_parameters_.max_angularVelocity, 0.5);
    paramHandle.param<float>("min_angularVelocity", control_parameters_.min_angularVelocity, -0.5);
    paramHandle.param<float>("max_linearAcceleration", control_parameters_.max_linearAcceleration, 0.5);
    paramHandle.param<float>("min_linearAcceleration", control_parameters_.min_linearAcceleration, -0.5);
    paramHandle.param<float>("max_angularAcceleration", control_parameters_.max_angularAcceleration, 0.5);
    paramHandle.param<float>("min_angularAcceleration", control_parameters_.min_angularAcceleration, -0.5);
    paramHandle.param<float>("gain_state_x", control_parameters_.gain_state_x, 100.0);
    paramHandle.param<float>("gain_state_y", control_parameters_.gain_state_y, 100.0);
    paramHandle.param<float>("gain_state_theta", control_parameters_.gain_state_theta, 10.0);
    paramHandle.param<float>("gain_control_v", control_parameters_.gain_control_v, 1.0);
    paramHandle.param<float>("gain_control_w", control_parameters_.gain_control_w, 0.1);
    paramHandle.param<int>("avoidMode", control_parameters_.avoidMode, 0);
    paramHandle.param<int>("waitTime", control_parameters_.waitTime, -1);
    paramHandle.param<float>("extraDistance", control_parameters_.extraDistance, -1.0);

    // Services
    service_updateVectorMap_ = nh_.advertiseService("nav_mpac/update_virtual_costmap", &KMOVehicleExecutionNode::updateVectorMapCB, this);
    service_updateGridMap_ = nh_.advertiseService("nav_mpac/update_static_map", &KMOVehicleExecutionNode::updataGridMapCB, this);
    service_setGoal_ = nh_.advertiseService("nav_mpac/set_goal", &KMOVehicleExecutionNode::setGoalCB, this);
    service_cancelGoal_ = nh_.advertiseService("nav_mpac/cancel_goal", &KMOVehicleExecutionNode::cancelGoalCB, this);
    service_setPlanner_ = nh_.advertiseService("nav_mpac/planner_setting", &KMOVehicleExecutionNode::setPlannerCB, this);
    service_getTaskStatus_ = nh_.advertiseService("nav_mpac/get_state", &KMOVehicleExecutionNode::getStatusCB, this);

    // Publishers
    command_pub_ = nh_.advertise<mpac_msgs::ControllerCommand>("control/controller/commands", 1000);
    path_pub_ = nh_.advertise<nav_msgs::Path>("pathfinder/path", 1);
    global_path_pub_ = nh_.advertise<nav_msgs::Path>("nav_mpac/global_path", 1);
    heart_beat_pub_ = nh_.advertise<std_msgs::Int8>("heartBeat", 1);
    marker_pub_ = nh_.advertise<visualization_msgs::Marker>("visualization_marker", 10000);

    // Subscribers
    robot_pose_sub_ = nh_.subscribe<sineva_nav::pose2D>("/lidar_pose", 1, &KMOVehicleExecutionNode::robotPoseCB, this);
    point_cloud_sub_ = nh_.subscribe("laser_points_filtered", 1, &KMOVehicleExecutionNode::pointcloud2CB, this);
    // map_sub_ = nh_.subscribe<nav_msgs::OccupancyGrid>("/map", 10, &KMOVehicleExecutionNode::process_map, this);

    // Timers
    timer_plan_ = nh_.createTimer(ros::Duration(0), &KMOVehicleExecutionNode::planningTimeoutCB, this, true, false); // one shot and not autostart
    timer_pub_global_path_ = nh_.createTimer(ros::Duration(1), &KMOVehicleExecutionNode::pubGlobalPathTimeoutCB, this, false, false);
    timer_heartbeat = nh_.createTimer(ros::Duration(1), &KMOVehicleExecutionNode::pubHeartbeatTimeroutCB, this, false, true);
    timer_wait = nh_.createTimer(ros::Duration(0), &KMOVehicleExecutionNode::waitTimerCB, this, true, false);

    // call worker thread
    client_thread_plan_ = boost::thread(boost::bind(&KMOVehicleExecutionNode::globalPlan, this));
    client_thread_control_ = boost::thread(boost::bind(&KMOVehicleExecutionNode::localControl, this));

    // Init
    init();
  }

  ~KMOVehicleExecutionNode()
  {
    // if(client_thread_plan_.joinable())
    // {
    //     client_thread_plan_.join();
    // }

    // if(client_thread_control_.joinable())
    // {
    //     client_thread_control_.join();
    // }
  }

  void init()
  {
    valid_map_ = false;
    isPlanningTimeout = false;
    isCancelGoal = false;
    valid_planner_ = false;
    task_status_ = mpac_generic::TaskStatus::TASK_FREE;
    heartBeatmsg.data = 3; // 3-manage node
    isPlanning = false;
    goalCount = 0;
  }

  void waitForGridMap()
  {
    SPDLOG_INFO("Wait for gird map........................");
    bool isGetMap = false;
    bool isUpdateMapFinished = false;
    ros::ServiceClient client_getMap = nh_.serviceClient<sineva_nav::MapReq>("nav_mpac/request_map");
    sineva_nav::MapReq srv_getMap;
    srv_getMap.request.mapRequest = "offline_map";
    srv_getMap.response.result = -1;

    while (!isGetMap && ros::ok())
    {
      // SPDLOG_INFO("Try to get grid map data .........");
      if (client_getMap.call(srv_getMap) && (srv_getMap.response.result == 1) && srv_getMap.response.mapDate.info.width > 0 && srv_getMap.response.mapDate.info.height > 0)
      {
        SPDLOG_INFO("Get map data sucessfully!");
        SPDLOG_INFO("Info of map data:{},{},{}", srv_getMap.response.mapDate.info.width, srv_getMap.response.mapDate.info.height, srv_getMap.response.mapDate.data.size());
        isGetMap = true;
      }
      usleep(100 * 1000);
      ros::spinOnce();
    }
    while (!isUpdateMapFinished && ros::ok())
    {
      SPDLOG_INFO("Try to update grid map data for global planner and local planner........");
      if (updataGridMap(srv_getMap.response.mapDate))
      {
        SPDLOG_INFO("Update grid map data sucessfully");
        isUpdateMapFinished = true;
        return;
      }
      usleep(100 * 1000);
      ros::spinOnce();
    }
  }

  void globalPlan()
  {
    while (ros::ok())
    {

      SPDLOG_INFO("Wait for new goal..................");

      boost::unique_lock<boost::mutex> uniqueLock(plan_mutex_);
      cond_plan_.wait(uniqueLock);

      SPDLOG_INFO("Global plan thread has been waken up!!!!");
      task_status_ = mpac_generic::TaskStatus::TASK_PLANNING;

      if (timer_wait.hasStarted())
      {
        SPDLOG_WARN("Stop road blocked waiting timer!");
        timer_wait.stop();
      }

      isPlanning = true;

      current_target_.start.pose = current_state_.pose.pose;

      //封装全局规划服务
      mpac_msgs::GetPath srv;
      srv.request.target = current_target_;
      srv.request.plan_parameters = plan_parameters_;
      ros::ServiceClient client = nh_.serviceClient<mpac_msgs::GetPath>("get_path");

      //判断起点和终点是不是同一点
      {
        double yaw_start = atan2(srv.request.target.start.pose.orientation.z, srv.request.target.start.pose.orientation.w) * 2.0;
        yaw_start = atan2(sin(yaw_start), cos(yaw_start));

        double yaw_goal = atan2(srv.request.target.goal.pose.orientation.z, srv.request.target.goal.pose.orientation.w) * 2.0;
        yaw_goal = atan2(sin(yaw_goal), cos(yaw_goal));

        if (fabs(srv.request.target.start.pose.position.x - srv.request.target.goal.pose.position.x) < 0.05 &&
            fabs(srv.request.target.start.pose.position.y - srv.request.target.goal.pose.position.y) < 0.05 &&
            fabs(yaw_start - yaw_goal) < 0.1)
        {
          spdlog::info("起止点位置相同！");
          spdlog::info("起点：{}, {}, {}", srv.request.target.start.pose.position.x, srv.request.target.start.pose.position.y, yaw_start);
          spdlog::info("终点：{}, {}, {}", srv.request.target.goal.pose.position.x, srv.request.target.goal.pose.position.y, yaw_goal);
          sleep(2);
          task_status_ = mpac_generic::TaskStatus::TASK_REACHED_GOAL;
          continue;
        }
      }

      // Debug
      // srv.request.target.start.pose.position.x = 1.956;
      // srv.request.target.start.pose.position.y = 0.123;

      // srv.request.target.goal.pose.position.x = 11.37;
      // srv.request.target.goal.pose.position.y = 0.34;

      ros::Time plan_start = ros::Time::now();
      bool isGetGlobalPathInPlanTime = false;

      spdlog::info("11111111111");

      while (!isGetGlobalPathInPlanTime)
      {
        //更新动态点云
        // spdlog::info("22222222222222");
        // if (!updateDynamicObstaclesForGlobalMap())
        // {
        //   SPDLOG_WARN("Failed to update dynamic obstacles！");
        //   task_status_ = mpac_generic::TaskStatus::TASK_GLOBAL_FAILED;
        //   continue;
        // }
        // spdlog::info("3333333333333333");

        bool isGetGlobalPath = client.call(srv);
        double planTimeUsed = (ros::Time::now() - plan_start).toSec();

        //判断当前任务是否被取消
        if (isCancelGoal)
        {
          SPDLOG_WARN("This task has been canceled!");
          task_status_ = mpac_generic::TaskStatus::TASK_CANCEL_GOAL;
          isPlanning = false;
          break;
        }

        //判断全局规划是否超时
        if ((srv.request.plan_parameters.planTime > 0) && (planTimeUsed > srv.request.plan_parameters.planTime))
        {
          SPDLOG_WARN("This task is failed because the time used by global planning {} exceeds the set value {}！", planTimeUsed, plan_parameters_.planTime);
          task_status_ = mpac_generic::TaskStatus::TASK_GLOBAL_FAILED;
          isPlanning = false;
          break;
        }

        //判断是否规划出全局路径
        if (isGetGlobalPath)
        {
          SPDLOG_INFO("Get_path successful:{} paths", srv.response.paths.paths.size());
          isGetGlobalPathInPlanTime = true;
          current_task_.target = srv.request.target;
          current_task_.paths = srv.response.paths;
          current_task_.PathGetMethod = srv.response.PathGetMethod;

          cond_control_.notify_one();
          task_status_ = mpac_generic::TaskStatus::TASK_RUNNING;
          current_global_path_ = srv.response.path_pub;
          timer_pub_global_path_.start();
          isPlanning = false;
          break;
        }
        else
        {
          SPDLOG_WARN("Get_path failed!!!");
        }

        isPlanning = false;

        sleep(1);
      }
    }
  }

  void localControl()
  {
    while (ros::ok())
    {

      SPDLOG_INFO("Local control thread is waiting for new task!");

      boost::unique_lock<boost::mutex> uniqueLock(control_mutex_);
      cond_control_.wait(uniqueLock);

      task_status_ = mpac_generic::TaskStatus::TASK_RUNNING;
      //等待服务器初始化完成
      SPDLOG_INFO("Local control thread has been waken up  and wait for local control server.......");
      control_client_.waitForServer();
      SPDLOG_INFO("Local control server is ready!");
      //定义要做的目标
      mpac_msgs::ControlGoal goal;
      goal.id = goalCount;
      goal.task = current_task_;
      control_parameters_.robot_model = robot_configs_;
      goal.params = control_parameters_;
      //发送目标至服务器
      control_client_.sendGoal(goal,
                               boost::bind(&KMOVehicleExecutionNode::TaskDoneCb, this, _1, _2),
                               boost::bind(&KMOVehicleExecutionNode::ActiveCb, this),
                               boost::bind(&KMOVehicleExecutionNode::FeedbackCb, this, _1));

      SPDLOG_INFO("The target task {} has been sent, waiting for the processing result......", goalCount);

      goalCount++;

      //道理被阻等待时间
      {
        waitTime = (this->control_parameters_.avoidMode == 0 && this->plan_parameters_.planMode == 0) ? 1 : this->control_parameters_.waitTime;
        //定时器为0时，表示永不超时;实际要求其立马触发

        if (this->control_parameters_.waitTime == 0)
        {
          waitTime = 1;
        }

        //如果当前轨迹是路网图，则不进行二次规划
        if (current_task_.PathGetMethod == 1)
        {
          waitTime = -1;
        }
        
        if (this->control_parameters_.max_linearVelocity > 1.5 && waitTime > 0)
        {
          waitTime = std::max(waitTime, 2.0);
        }
      }

      control_client_.waitForResult(ros::Duration(0));
      //根据返回结果，做相应的处理
      if (control_client_.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
      {
        SPDLOG_INFO("!!!!!!!!!!!!!!!!!!!!!Reach Goal!!!!!!!!!!!!!!!!!!!");
        task_status_ = mpac_generic::TaskStatus::TASK_REACHED_GOAL;
        timer_pub_global_path_.stop();
      }
      else
      {
        SPDLOG_WARN("The current task has been interrupted!!!!!!!!!!!!!!");
        goalIsCanceled = true;
        control_client_.cancelAllGoals();
        mpac_generic::TaskStatus::TASK_CANCEL_GOAL;
        if (timer_wait.hasStarted())
        {
          SPDLOG_WARN("Stop road blocked waiting timer!");
          timer_wait.stop();
        }
      }
    }
  }

  // Called once when the goal completes
  void TaskDoneCb(const actionlib::SimpleClientGoalState &state,
                  const mpac_msgs::ControlResultConstPtr &result)
  {
    SPDLOG_INFO("Task is finished in state [{}]", state.toString().c_str());
  }

  // 当目标激活的时候，会调用一次
  void ActiveCb()
  {
    SPDLOG_INFO("Task just went active");
  }

  // 接收服务器的反馈信息
  void FeedbackCb(const mpac_msgs::ControlFeedbackConstPtr &feedback)
  {
    if (task_status_ == mpac_generic::TaskStatus::TASK_PLANNING)
    {
      return;
    }
    switch (feedback->state)
    {
    case -1:

      task_status_ = mpac_generic::TaskStatus::TASK_LOCAL_FAILED;
      remainingDistance = feedback->remainingDistance;
      SPDLOG_WARN("Local control feedback - TASK_LOCAL_FAILED! remainingDistance:{},waitTime:{}", remainingDistance, waitTime);
      SPDLOG_WARN("timer_wait.hasStarted():{},isPlanning:{}", timer_wait.hasStarted(), isPlanning);

      if (!timer_wait.hasStarted() && (waitTime > 0) && (!isPlanning))
      {
        SPDLOG_WARN("Trigger road blocked waiting timer!");
        timer_wait.setPeriod(ros::Duration(waitTime));
        timer_wait.start();
      }
      break;
    case 0:
      if (task_status_ != mpac_generic::TaskStatus::TASK_CANCEL_GOAL)
      {
        task_status_ = mpac_generic::TaskStatus::TASK_RUNNING;
      }

      if (timer_wait.hasStarted())
      {
        SPDLOG_WARN("Stop road blocked waiting timer!");
        timer_wait.stop();
      }
      // ROS_INFO("[MPAC_MANAGER_NODE] local control feedback - TASK_RUNNING");
      break;
    case 1:
      task_status_ = mpac_generic::TaskStatus::TASK_REACHED_GOAL;
      SPDLOG_INFO("Local control feedback - TASK_REACHED_GOAL");
      break;

    default:
      break;
    }
  }

  void robotPoseCB(const sineva_nav::pose2D msg)
  {

    nav_msgs::Odometry msg_odom;
    msg_odom.header = msg.header;
    msg_odom.pose.pose.position.x = msg.pose.x;
    msg_odom.pose.pose.position.y = msg.pose.y;
    msg_odom.pose.pose.orientation.z = sin(msg.pose.theta / 2);
    msg_odom.pose.pose.orientation.w = cos(msg.pose.theta / 2);

    current_state_ = msg_odom;
  }

  void pointcloud2CB(sensor_msgs::PointCloud2ConstPtr msg)
  {
    points_mutex_.lock();
    dynamicPointsMsg = msg;
    points_mutex_.unlock();
  }

  bool updateDynamicObstaclesForGlobalMap()
  {
    //全局规划前更新动态障碍物
    points_mutex_.lock();
    if(dynamicPointsMsg == nullptr)
    {
      spdlog::info("未收到点云数据");
      points_mutex_.unlock();
      return true;
    }
    sensor_msgs::PointCloud pointCloud;
    sensor_msgs::convertPointCloud2ToPointCloud(*dynamicPointsMsg, pointCloud);
    points_mutex_.unlock();

    if (pointCloud.points.size() > 0)
    {
      mpac_msgs::UpdateMap updateMap_srv;
      for (size_t i = 0; i < pointCloud.points.size(); i++)
      {
        geometry_msgs::Point pt;
        pt.x = pointCloud.points[i].x;
        pt.y = pointCloud.points[i].y;
        updateMap_srv.request.dynamic_map.vertices.push_back(pt);
      }

      ros::ServiceClient client = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_global");
      updateMap_srv.request.updateDynamicMap = true;
      return client.call(updateMap_srv);
    }

    return true;
  }

  void planningTimeoutCB(const ros::TimerEvent &)
  {

    task_status_ = mpac_generic::TaskStatus::TASK_GLOBAL_FAILED;
    isPlanningTimeout = true;
  }

  void waitTimerCB(const ros::TimerEvent &)
  {

    SPDLOG_WARN("The road is blocked for longer than the set threshold！");
    goalIsCanceled = false;
    control_client_.cancelAllGoals();
    //确保前一个任务被取消
    while (!goalIsCanceled)
    {
      usleep(1000);
    }

    //当前路径是循迹线，则直接返回任务失败
    if (current_task_.PathGetMethod == 1)
    {
      task_status_ = mpac_generic::TaskStatus::TASK_GLOBAL_FAILED;
      return;
    }

    //否则进行二次规划
    this->plan_parameters_.maxDistance = maxOffsetDistance;
    if (maxOffsetDistance > 0)
    {
      this->plan_parameters_.maxDistance = maxOffsetDistance + remainingDistance;
    }
    cond_plan_.notify_one();
  }

  void pubGlobalPathTimeoutCB(const ros::TimerEvent &)
  {
    current_global_path_.header.stamp = ros::Time::now();
    global_path_pub_.publish(current_global_path_);
  }

  void pubHeartbeatTimeroutCB(const ros::TimerEvent &)
  {
    heart_beat_pub_.publish(heartBeatmsg);
  }

  // Service callbacks
  // 设置目标点的回调函数
  bool setGoalCB(sineva_nav::SetGoalSrv::Request &req, sineva_nav::SetGoalSrv::Response &res)
  {
    SPDLOG_INFO("Get new goal {}:({},{},{})", req.goal_id, req.goal.position.x, req.goal.position.y, tf::getYaw(req.goal.orientation));
    // 目标点id不能为空
    isCancelGoal = false;
    if (req.goal_id.empty())
    {
      SPDLOG_INFO("Goal id is empty!");
      res.result = -1;
      return true;
    }
    // 有可用地图
    if (!valid_map_)
    {
      SPDLOG_INFO("Map is not valid!");
      res.result = -1;
      return true;
    }
    // 赋值并激活规划线程
    current_target_.goalId = req.goal_id;
    current_target_.goal.pose = req.goal;
    current_target_.goal.steering = 0.0;
    this->plan_parameters_.maxDistance = req.maxDistance;
    cond_plan_.notify_one();

    task_status_ = mpac_generic::TaskStatus::TASK_GOT_NEW_GOAL;

    res.result = 0;
    return true;
  }

  // 取消目标点的回调函数
  bool cancelGoalCB(sineva_nav::CancelGoalSrv::Request &req, sineva_nav::CancelGoalSrv::Response &res)
  {
    SPDLOG_WARN("Cancel goal!!!!!!!!!!!!");
    isCancelGoal = true;
    control_client_.cancelAllGoals();
    timer_pub_global_path_.stop();
    // wait global plan finished
    while (task_status_ == mpac_generic::TaskStatus::TASK_PLANNING)
    {
      SPDLOG_WARN("Wait plan task canceled!");
      usleep(100 * 1000);
    }

    task_status_ = mpac_generic::TaskStatus::TASK_CANCEL_GOAL;
    res.result = 0;
    return true;
  }
  bool getStatusCB(sineva_nav::GetStateSrv::Request &req, sineva_nav::GetStateSrv::Response &res)
  {

    res.status_code = task_status_;
    res.goal_id = current_target_.goalId;
    return true;
  }
  // 设置规划器参数的回调函数
  bool setPlannerCB(sineva_nav::JsonCommSrv::Request &req, sineva_nav::JsonCommSrv::Response &res)
  {
    bool isCarModelChanged = false;
    rapidjson::Document json_object;
    SPDLOG_INFO("planner_setting get data: {}", req.data.data());
    if (json_object.Parse(req.data.data()).HasParseError())
    {
      SPDLOG_WARN("Failed to parse Json string");
      res.result = -1;
      return true;
    }
    //最大前进速度
    if (json_object.HasMember("linearAhead") && json_object["linearAhead"].IsDouble())
    {
      double linear = json_object["linearAhead"].GetDouble();
      if (linear >= 0.1 && linear <= 2.0)
      {
        this->control_parameters_.max_linearVelocity = linear;
      }
      else
      {
        this->control_parameters_.max_linearVelocity = 0.8;
        SPDLOG_ERROR("the linear ahead is over limit:{}, using default value 0.8!", linear);
      }
    }
    //最大后退速度
    if (json_object.HasMember("linearBack") && json_object["linearBack"].IsDouble())
    {
      double linear = json_object["linearBack"].GetDouble();
      // double angular = json_object["maxangular"].GetDouble();
      if (linear >= 0.1 && linear <= 2.0)
      {
        this->control_parameters_.min_linearVelocity = -1.0 * linear;
      }
      else
      {
        this->control_parameters_.min_linearVelocity = -0.3;
        SPDLOG_ERROR("the linear back is over limit:{},using default value 0.3", linear);
      }
    }

    //最大角速度
    if (json_object.HasMember("maxAngular") && json_object["maxAngular"].IsDouble())
    {
      double angular = json_object["maxAngular"].GetDouble();
      if (angular >= 0.1 && angular <= 2.0)
      {
        this->control_parameters_.max_angularVelocity = angular;
        this->control_parameters_.min_angularVelocity = -1.0 * angular;
      }
      else
      {
        this->control_parameters_.max_angularVelocity = 0.8;
        SPDLOG_ERROR("the angular is over limit:{},using default value 0.8", angular);
      }
    }

    //最大加速度
    if (json_object.HasMember("acceleration") && json_object["acceleration"].IsDouble())
    {
      double acceleration = json_object["acceleration"].GetDouble();
      if (acceleration >= 0.1 && acceleration <= 2.0)
      {
        this->control_parameters_.max_linearAcceleration = acceleration;
        this->control_parameters_.min_linearAcceleration = -1.0 * acceleration;
      }
      else
      {
        this->control_parameters_.max_linearAcceleration = 1.0;
        SPDLOG_ERROR("the angular is over limit:{}, using default value 1.0", acceleration);
      }
    }

    //最大规划时间
    if (json_object.HasMember("planTime") && json_object["planTime"].IsInt())
    {
      this->plan_parameters_.planTime = json_object["planTime"].GetInt();
    }

    //二次规划偏移距离
    if (json_object.HasMember("distance") && json_object["distance"].IsDouble())
    {
      this->control_parameters_.extraDistance = json_object["distance"].GetDouble();
      maxOffsetDistance = json_object["distance"].GetDouble();
    }
    //机器人高度
    if (json_object.HasMember("height") && json_object["height"].IsDouble())
    {
      this->robot_configs_.carHeight = json_object["height"].GetDouble();
    }

    //机器人前长
    if (json_object.HasMember("frontLength") && json_object["frontLength"].IsDouble())
    {
      double value = json_object["frontLength"].GetDouble();
      if (fabs(this->robot_configs_.carFrontLength - value) > 0.01)
      {
        isCarModelChanged = true;
      }
      this->robot_configs_.carFrontLength = value;
    }

    //机器人后长
    if (json_object.HasMember("backLength") && json_object["backLength"].IsDouble())
    {
      double value = json_object["backLength"].GetDouble();
      if (fabs(this->robot_configs_.carBackLength - value) > 0.01)
      {
        isCarModelChanged = true;
      }
      this->robot_configs_.carBackLength = value;
    }

    //机器人左宽
    if (json_object.HasMember("leftWidth") && json_object["leftWidth"].IsDouble())
    {
      double value = json_object["leftWidth"].GetDouble();
      if (fabs(this->robot_configs_.carLeftWidth - value) > 0.01)
      {
        isCarModelChanged = true;
      }
      this->robot_configs_.carLeftWidth = value;
    }

    //机器人右宽
    if (json_object.HasMember("rightWidth") && json_object["rightWidth"].IsDouble())
    {
      double value = json_object["rightWidth"].GetDouble();
      if (fabs(this->robot_configs_.carRightWidth - value) > 0.01)
      {
        isCarModelChanged = true;
      }
      this->robot_configs_.carRightWidth = value;
    }

    //避障方式 0-绕行 1-等停
    if (json_object.HasMember("avoidanceType") && json_object["avoidanceType"].IsInt())
    {
      this->control_parameters_.avoidMode = json_object["avoidanceType"].GetInt();
    }

    //道路被阻等待时长
    if (json_object.HasMember("blockedTime") && json_object["blockedTime"].IsInt())
    {
      this->control_parameters_.waitTime = json_object["blockedTime"].GetInt();
    }

    //是否开启循迹
    if (json_object.HasMember("isenableTrack") && json_object["isenableTrack"].IsInt())
    {
      this->plan_parameters_.planMode = json_object["isenableTrack"].GetInt();
    }

    this->robot_configs_.carWidth = this->robot_configs_.carLeftWidth + this->robot_configs_.carRightWidth;
    this->robot_configs_.carLength = this->robot_configs_.carFrontLength + this->robot_configs_.carBackLength;

    if (isCarModelChanged)
    {
      mpac_msgs::UpdateCarModel updateCarModel_srv;
      updateCarModel_srv.request.Configs = this->robot_configs_;
      ros::ServiceClient client_updateCarModel = nh_.serviceClient<mpac_msgs::UpdateCarModel>("update_car_model");
      if (client_updateCarModel.call(updateCarModel_srv))
      {
        SPDLOG_INFO("车体模型参数更新成功！");
      }
      else
      {
        SPDLOG_ERROR("车体模型参数更新失败！");
        res.result = -3;
        return false;
      }
    }
    valid_planner_ = true;
    res.result = 0;
    return true;
  }
  // 更新静态栅格地图的服务
  bool updataGridMapCB(sineva_nav::UpdateMapSrv::Request &req, sineva_nav::UpdateMapSrv::Response &res)
  {

    SPDLOG_INFO("Update grid map and set current map invalid");
    valid_map_ = false;
    if (req.mapDate.data.empty())
    {
      SPDLOG_ERROR("The grid map data is empty!");
      res.result = -1;
      return true;
    }

    res.result = updataGridMap(req.mapDate) ? 0 : (-1);
    return true;
  }

  bool updataGridMap(const nav_msgs::OccupancyGrid &mapData)
  {

    map_mutex_.lock();
    current_map_ = mapData;
    mpac_msgs::UpdateMap updateMap_srv;
    updateMap_srv.request.map = current_map_;
    updateMap_srv.request.updateGridMap = true;

    ros::ServiceClient client1_updateMap = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_global");

    int count = 0;
    bool updateMapGlobalSucess = false;
    while (count < 10)
    {
      if (client1_updateMap.call(updateMap_srv))
      {
        updateMapGlobalSucess = true;
        break;
      }
      else
      {
        usleep(100 * 1000);
        count++;
      }
    }
    count = 0;
    bool updateMapLocalSucess = false;
    ros::ServiceClient client2_updateMap = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_local");
    while (count < 10)
    {
      if (client2_updateMap.call(updateMap_srv))
      {
        updateMapLocalSucess = true;
        break;
      }
      else
      {
        usleep(100 * 1000);
        count++;
      }
    }
    map_mutex_.unlock();

    if (updateMapGlobalSucess && updateMapLocalSucess)
    {
      valid_map_ = true;
      return true;
    }
    else
    {
      SPDLOG_ERROR("Failed to update grid map!");
      return false;
    }
  }

  // 更新特殊区域的回调函数
  bool updateVectorMapCB(sineva_nav::JsonCommSrv::Request &req, sineva_nav::JsonCommSrv::Response &res)
  {

    SPDLOG_INFO("update VectorMap");
    if (!valid_map_)
    {
      SPDLOG_WARN("Grid map is not valid!");
      res.result = -1;
      return true;
    }

    rapidjson::Document json_doc;
    json_doc.Parse(req.data.data());
    if (json_doc.HasParseError())
    {
      SPDLOG_WARN("Failed to parse Json string");
      res.result = -1;
      return true;
    }
    if (!json_doc.HasMember("area") || !json_doc["area"].IsObject())
    {
      SPDLOG_WARN("Can not parse area");
      res.result = -2;
      return true;
    }

    mpac_msgs::UpdateMap updateMap_srv;
    rapidjson::Value &json_object = json_doc["area"];
    //禁行区
    if (json_object.HasMember("forbidRegionList") && json_object["forbidRegionList"].IsArray())
    {
      rapidjson::Value &jsonArray = json_object["forbidRegionList"];
      try
      {
        mpac_msgs::VectorMap vector_map;
        for (int i = 0; i < jsonArray.Size(); i++)
        {
          mpac_msgs::Shape shape;
          shape.type = shape.POLYGON;
          for (auto &pose : jsonArray[i]["poses"].GetArray())
          {
            geometry_msgs::Point point;
            point.x = pose["x"].GetDouble();
            point.y = pose["y"].GetDouble();
            shape.points.push_back(point);
          }
          vector_map.objects.push_back(shape);
        }
        updateMap_srv.request.prohibition_map = vector_map;
      }
      catch (std::exception ex)
      {
        SPDLOG_ERROR("ERROR:{}", ex.what());
        res.result = -2;
        return true;
      }
    }
    //单行区域
    if (json_object.HasMember("directionalList") && json_object["directionalList"].IsArray())
    {
      rapidjson::Value &jsonArray = json_object["directionalList"];
      try
      {
        mpac_msgs::VectorMap vector_map;
        for (int i = 0; i < jsonArray.Size(); i++)
        {
          mpac_msgs::Shape shape;
          shape.type = shape.POLYGON;
          shape.parameter = jsonArray[i]["direction"].GetInt();
          for (auto &pose : jsonArray[i]["poses"].GetArray())
          {
            geometry_msgs::Point point;
            point.x = pose["x"].GetDouble();
            point.y = pose["y"].GetDouble();
            shape.points.push_back(point);
          }
          vector_map.objects.push_back(shape);
        }
        updateMap_srv.request.direction_map = vector_map;
      }
      catch (std::exception ex)
      {
        res.result = -3;
        return true;
      }
    }

    //限速区域
    if (json_object.HasMember("speedLimitRegionList") && json_object["speedLimitRegionList"].IsArray())
    {
      rapidjson::Value &jsonArray = json_object["speedLimitRegionList"];
      try
      {
        mpac_msgs::VectorMap vector_map;
        for (int i = 0; i < jsonArray.Size(); i++)
        {

          mpac_msgs::Shape shape;
          shape.type = shape.POLYGON;
          shape.parameter = (int)(jsonArray[i]["speed"].GetDouble() * 100);

          for (auto &pose : jsonArray[i]["poses"].GetArray())
          {
            geometry_msgs::Point point;
            point.x = pose["x"].GetDouble();
            point.y = pose["y"].GetDouble();
            shape.points.push_back(point);
          }
          vector_map.objects.push_back(shape);
        }
        updateMap_srv.request.speed_map = vector_map;
      }
      catch (std::exception ex)
      {
        res.result = -5;
        return true;
      }
    }
    // 非穿行区
    if (json_object.HasMember("nonCrossingArea") && json_object["nonCrossingArea"].IsArray())
    {
      rapidjson::Value &jsonArray = json_object["nonCrossingArea"];
      try
      {
        mpac_msgs::VectorMap vector_map;

        for (int i = 0; i < jsonArray.Size(); i++)
        {
          mpac_msgs::Shape shape;
          shape.type = shape.POLYGON;
          for (auto &pose : jsonArray[i]["poses"].GetArray())
          {
            geometry_msgs::Point point;
            point.x = pose["x"].GetDouble();
            point.y = pose["y"].GetDouble();
            shape.points.push_back(point);
          }
          vector_map.objects.push_back(shape);
        }
        updateMap_srv.request.noCrossing_map = vector_map;
      }
      catch (std::exception ex)
      {
        SPDLOG_ERROR("ERROR:{}", ex.what());
        res.result = -2;
        return true;
      }
    }

    // 窄通道区
    if (json_object.HasMember("narrowChannelArea") && json_object["narrowChannelArea"].IsArray())
    {
      rapidjson::Value &jsonArray = json_object["narrowChannelArea"];
      try
      {
        mpac_msgs::VectorMap vector_map;

        for (int i = 0; i < jsonArray.Size(); i++)
        {
          mpac_msgs::Shape shape;
          shape.type = shape.POLYGON;
          shape.parameter = (int)(jsonArray[i]["channelWidth"].GetDouble() * 100);
          for (auto &pose : jsonArray[i]["poses"].GetArray())
          {
            geometry_msgs::Point point;
            point.x = pose["x"].GetDouble();
            point.y = pose["y"].GetDouble();
            shape.points.push_back(point);
          }
          vector_map.objects.push_back(shape);
        }
        updateMap_srv.request.channel_map = vector_map;
      }
      catch (std::exception ex)
      {
        SPDLOG_ERROR("ERROR:{}", ex.what());
        res.result = -2;
        return true;
      }
    }

    ros::ServiceClient client1 = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_global");
    updateMap_srv.request.updateDirectionMap = true;
    updateMap_srv.request.updateProhibitionMap = true;
    updateMap_srv.request.updateNoCrossingMap = true;
    updateMap_srv.request.updateSpeedMap = false;
    updateMap_srv.request.updateDynamicMap = false;
    // updateMap_srv.request.updatecrossingMap = true;
    if (client1.call(updateMap_srv))
    {
      SPDLOG_INFO("global updata special areas:success!");
    }
    else
    {
      SPDLOG_WARN("global updata special areas:failed！");
      res.result = -6;
      return true;
    }
    ros::ServiceClient client2 = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_local");
    updateMap_srv.request.updateDirectionMap = false;
    updateMap_srv.request.updateProhibitionMap = true;
    updateMap_srv.request.updateSpeedMap = true;
    updateMap_srv.request.updateNarrowChannelMap = true;
    updateMap_srv.request.updateDynamicMap = false;

    if (client2.call(updateMap_srv))
    {
      SPDLOG_INFO("local updata special areas:success!");
    }
    else
    {
      SPDLOG_WARN("local updata special areas:failed！");
      res.result = -6;
      return true;
    }
    res.result = 0;
    return true;
  }

  // 更新路网图的回调函数
  bool updateRoadNetMapCB(sineva_nav::JsonCommSrv::Request &req, sineva_nav::JsonCommSrv::Response &res)
  {

    return true;
  }

  bool checkGoalStatus(geometry_msgs::Pose goal)
  {
    // 检查目标点是否可达
    sineva_nav::CheckGoalStatusSrv srv_CheckGoalStatus;
    srv_CheckGoalStatus.request.x = goal.position.x;
    srv_CheckGoalStatus.request.y = goal.position.y;
    srv_CheckGoalStatus.request.yaw = tf::getYaw(goal.orientation);

    ros::ServiceClient client = nh_.serviceClient<sineva_nav::CheckGoalStatusSrv>("nav_mpac/goal_status");
    if (client.call(srv_CheckGoalStatus) && (srv_CheckGoalStatus.response.result))
    {
      return true;
    }

    return false;
  }
  // Processing callbacks from subscriptions
  void process_map(const nav_msgs::OccupancyGrid::ConstPtr &msg)
  {
    if (valid_map_)
    {
      return;
    }
    map_mutex_.lock();
    current_map_ = *msg;
    valid_map_ = true;
    map_mutex_.unlock();

    mpac_msgs::UpdateMap updateMap_srv;
    updateMap_srv.request.map = current_map_;

    { //特殊区域测试
      mpac_msgs::Shape shape;
      shape.parameter = 1;
      geometry_msgs::Point point;
      point.x = 20.2;
      point.y = 22.9;
      shape.points.push_back(point);

      point.x = 20.3;
      point.y = 20.8;
      shape.points.push_back(point);

      point.x = 22.8;
      point.y = 20.8;
      shape.points.push_back(point);

      point.x = 22.8;
      point.y = 22.9;
      shape.points.push_back(point);

      updateMap_srv.request.direction_map.objects.push_back(shape);
    }

    ros::ServiceClient client1_updateMap = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_global");

    while (!client1_updateMap.call(updateMap_srv))
    {
      sleep(1);
    }

    ros::ServiceClient client2_updateMap = nh_.serviceClient<mpac_msgs::UpdateMap>("update_map_local");
    while (!client2_updateMap.call(updateMap_srv))
    {
      sleep(1);
    }
  }
};

void FailureSignalHandler(int signal_number, siginfo_t *signal_info, void *ucontext)
{
  static const int kStackLength = 64;
  void *stack[kStackLength];

  int size = backtrace(stack, kStackLength);
  backtrace_symbols_fd(stack, size, STDOUT_FILENO);

  exit(0);
}

void installFailureSignalHandler()
{
  struct sigaction sig_action;
  memset(&sig_action, 0, sizeof(sig_action));
  sigemptyset(&sig_action.sa_mask);
  sig_action.sa_flags |= SA_SIGINFO;
  sig_action.sa_sigaction = &FailureSignalHandler;

  sigaction(SIGILL, &sig_action, NULL);
  sigaction(SIGFPE, &sig_action, NULL);
  sigaction(SIGSEGV, &sig_action, NULL);
  sigaction(SIGABRT, &sig_action, NULL);
  sigaction(SIGTERM, &sig_action, NULL);
}

int main(int argc, char **argv)
{

  // log
  std::vector<spdlog::sink_ptr> spdlog_sinks;
  spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());
  // spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>("/home/nuc/tmp/mpac/mpac_manager.log", true));
  spdlog_sinks[0]->set_level(spdlog::level::info);
  // spdlog_sinks[1]->set_level(spdlog::level::debug);
  spdlog::set_default_logger(std::make_shared<spdlog::logger>("mpacManager", spdlog_sinks.begin(), spdlog_sinks.end()));
  spdlog::set_level(spdlog::level::debug);
  SPDLOG_INFO("mpac manager launched!");
  // log

  installFailureSignalHandler();

  ros::init(argc, argv, "mpac_vehicle_execution_node");
  ros::NodeHandle params("~");

  KMOVehicleExecutionNode ve(params);
  ve.waitForGridMap();
  SPDLOG_INFO("grid map has been load!");

  ros::spin();
}
