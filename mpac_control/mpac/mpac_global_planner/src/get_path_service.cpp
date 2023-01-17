#include <ros/ros.h>
#include <std_msgs/Int8.h>

#include <algorithm>

#include <mpac_generic/path_utils.h>
#include <mpac_generic/io.h>

#include <mpac_msgs/GetPath.h>
#include <mpac_msgs/UpdateMap.h>

#include <mpac_global_planner/PathFinder.h>
#include <mpac_global_planner/VehicleMission.h>

#include <mpac_global_planner/smoother.h>

#include <iostream>
#include <string>

#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/binary_iarchive.hpp>
#include <boost/archive/binary_oarchive.hpp>
#include <boost/serialization/vector.hpp>

#include <visualization_msgs/Marker.h>
#include <mpac_rviz/mpac_rviz.h>

#include <mpac_global_planner/nav_msgs_occupancy_grid_to_planner_map.h>

#include <nav_msgs/Path.h>
#include <sineva_nav/JsonCommSrv.h>
#include "mpac_global_planner/Dijkstra.h"
#include "mpac_msgs/UpdateCarModel.h"

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>

/**
 * Responds to GetPath requests
 */
class GetPathService
{

private:
  std::string motion_prim_dir_;
  std::string lookup_tables_dir_;
  std::string maps_dir_;
  CarModel *car_model_;

  bool visualize_;
  bool smooth_;

  ros::Publisher marker_pub_;
  ros::Publisher map_pub_;
  ros::Publisher path_pub_;
  ros::Publisher paths_pub_;
  ros::Publisher heart_beat_pub_;

  double min_incr_path_dist_;
  bool save_paths_;

  ros::NodeHandle nh_;
  ros::ServiceServer service_getPath;
  ros::ServiceServer service_updateMap;
  ros::ServiceServer service_updateSpecialArea;
  ros::ServiceServer service_updateRoadLines;
  ros::ServiceServer service_updatePositions;
  ros::ServiceServer service_updataCarModel;

  ros::Timer timer_heartbeat;

  WorldOccupancyMap planner_map;
  WorldRoadNetMap road_net_map;

  Graph_DG *graph_dg_;

  Smoother *path_smoother_;
  PathFinder *path_finder_;
  CollisionDetector *cd_;
  VehicleMission *vm_;

  mpac_generic::Point2dVec dynamicObstacles_;

  std_msgs::Int8 heartBeatmsg;

  boost::thread stateMonitorThread;

  std::vector<mpac_geometry::Polygon> noCrossingAreas_;

public:
  GetPathService(ros::NodeHandle param_nh, std::string name)
  {
    // read parameters
    param_nh.param<std::string>("motion_primitives_directory", motion_prim_dir_, "./Primitives/");
    param_nh.param<std::string>("lookup_tables_directory", lookup_tables_dir_, "./LookupTables/");
    param_nh.param<std::string>("maps_directory", maps_dir_, "./");
    std::string model;
    param_nh.param<std::string>("model", model, "");
    param_nh.param<double>("min_incr_path_dist", min_incr_path_dist_, 0.001);
    param_nh.param<bool>("save_paths", save_paths_, false);
    param_nh.param<bool>("use_grid_distance", WP::USE_GRID_DISTANCE, true);
    param_nh.param<bool>("use_fast_plan_mode", WP::USE_FAST_PLAN_MODE, true);

    WP::setPrimitivesDir(motion_prim_dir_);
    WP::setTablesDir(lookup_tables_dir_);
    WP::setMapsDir(maps_dir_);
    ros::Time start = ros::Time::now();
    car_model_ = new CarModel(model);
    ros::Time end = ros::Time::now();

    SPDLOG_INFO("Load the model {} in {} seconds", model, (end - start).toSec());
    vm_ = 0;
    WP::RADIUS_CAR_INSCRIBED = car_model_->getWidth() / 2;
    WP::RADIUS_CAR_EXTERNAL = 0.48;

    param_nh.param<bool>("visualize", visualize_, true);
    smooth_ = true;
    if (visualize_)
    {
      ROS_INFO("[GetPathService] -  The output is visualized using /visualization_markers (in rviz).");
      marker_pub_ = nh_.advertise<visualization_msgs::Marker>("visualization_marker_plan", 10000, true);
    }

    service_getPath = nh_.advertiseService("get_path", &GetPathService::getPathCB, this);
    service_updateMap = nh_.advertiseService("update_map_global", &GetPathService::updateMapCB, this);
    service_updataCarModel = nh_.advertiseService("update_car_model", &GetPathService::updateCarModelCB, this);
    service_updatePositions = nh_.advertiseService("nav_mpac/update_postitios", &GetPathService::updatePositionsCB, this);
    service_updateRoadLines = nh_.advertiseService("nav_mpac/update_tracklines", &GetPathService::updateRoadLinesCB, this);

    map_pub_ = nh_.advertise<nav_msgs::OccupancyGrid>("plan_map", 1, true);
    path_pub_ = nh_.advertise<nav_msgs::Path>("global/path_raw", 1);
    paths_pub_ = nh_.advertise<mpac_msgs::Paths>("pathsmoother/paths", 1);
    heart_beat_pub_ = nh_.advertise<std_msgs::Int8>("heartBeat", 1);

    // timer_heartbeat = nh_.createTimer(ros::Duration(1), &GetPathService::pubHeartbeatTimeroutCB, this, false, true);
    stateMonitorThread = boost::thread(boost::bind(&GetPathService::stateMonitor, this));

    heartBeatmsg.data = 5; //5-global planner node
  }

  ~GetPathService()
  {
    delete car_model_;
    delete path_finder_;
    delete path_smoother_;
    delete cd_;
    SPDLOG_WARN("Shut Down");
  }

  bool updateMapCB(mpac_msgs::UpdateMap::Request &req,
                   mpac_msgs::UpdateMap::Response &res)
  {
    SPDLOG_INFO("Start updating global map!");
    if (req.updateGridMap)
    {
      convertNavMsgsOccupancyGridToWorldOccupancyMapRef(req.map, planner_map, -1 /* car_model_->getWidth() / 2 */);
    }

    if (req.updateProhibitionMap)
    {
      SPDLOG_INFO("Start updating prohibition map!");
      convertVectorMapToWorldOccupancyMapData(req.prohibition_map, planner_map, mpac_generic::VectorMapType::ProhibitedMap);
      SPDLOG_INFO("Finish updating prohibition map!");
    }
    if (req.updateDirectionMap)
    {
      SPDLOG_INFO("Start updating direction map!");
      convertVectorMapToWorldOccupancyMapData(req.direction_map, planner_map, mpac_generic::VectorMapType::DirectionMap);
      SPDLOG_INFO("Finish updating direction map!");
    }
    if (req.updateSpeedMap)
    {
      SPDLOG_INFO("Start updating speed map!");
      convertVectorMapToWorldOccupancyMapData(req.speed_map, planner_map, mpac_generic::VectorMapType::SpeedMap);
      SPDLOG_INFO("Finish updating speed map!");
    }
    if (req.updateNoCrossingMap)
    {
      noCrossingAreas_.clear();
      int size_shapes = req.noCrossing_map.objects.size();
      for (size_t i = 0; i < size_shapes; i++)
      {
        mpac_msgs::Shape shape = req.noCrossing_map.objects[i];
        mpac_generic::Point2dVec pts;
        for (size_t j = 0; j < shape.points.size() - 1; j++)
        {
          Eigen::Vector2d point(shape.points[j].x, shape.points[j].y);
          pts.push_back(point);
        }
        mpac_geometry::Polygon polygon(pts, WP::RADIUS_CAR_INSCRIBED);
        noCrossingAreas_.push_back(polygon);
      }
    }

    //合并地图并更新Voronoi
    SPDLOG_INFO("Merge map and Update voronoi!");
    planner_map.mapMerge();

    //更新动态障碍物
    if (req.updateDynamicMap)
    {
      SPDLOG_INFO("Start updating dynamic map!");
      if (!dynamicObstacles_.empty())
      {
        planner_map.removeObstacles(dynamicObstacles_);
        dynamicObstacles_.clear();
      }
      for (size_t i = 0; i < req.dynamic_map.vertices.size(); i++)
      {
        Eigen::Vector2d pt(req.dynamic_map.vertices[i].x, req.dynamic_map.vertices[i].y);
        dynamicObstacles_.push_back(pt);
      }
      planner_map.addObstacles(dynamicObstacles_);
      SPDLOG_INFO("Finish updating dynamic map!");
    }

    //DEBUG: 发布规划用的地图
    {
      nav_msgs::OccupancyGrid map_plan;
      convertNavMsgsOccupancyGridFromWorldOccupancyMapRef(map_plan, planner_map);
      map_plan.header.stamp = ros::Time::now();
      map_plan.header.frame_id = "map";
      map_pub_.publish(map_plan);
    }

    path_smoother_ = new Smoother(&planner_map);
    path_finder_ = new PathFinder(&planner_map);
    cd_ = new CollisionDetector(&planner_map);
    res.result = true;

    SPDLOG_INFO("Finish updating global map!");
    return true;
  }

  bool updateRoadLinesCB(sineva_nav::JsonCommSrv::Request &req,
                         sineva_nav::JsonCommSrv::Response &res)
  {
    SPDLOG_INFO("Start updating road lines:{}", req.data);
    road_net_map.updateRoads(req.data);
    graph_dg_ = new Graph_DG(&road_net_map);
    res.result = 0;
    SPDLOG_INFO("Finish update road lines!");
    return true;
  }

  bool updatePositionsCB(sineva_nav::JsonCommSrv::Request &req,
                         sineva_nav::JsonCommSrv::Response &res)
  {
    SPDLOG_INFO("Start updating positions:{}", req.data);
    road_net_map.updatePositons(req.data);
    graph_dg_ = new Graph_DG(&road_net_map);
    res.result = 0;
    SPDLOG_INFO("Finish updating positions!");
    return true;
  }

  bool updateCarModelCB(mpac_msgs::UpdateCarModel::Request &req,
                        mpac_msgs::UpdateCarModel::Response &res)
  {
    WP::RADIUS_CAR_INSCRIBED = std::min({req.Configs.carLeftWidth, req.Configs.carRightWidth, req.Configs.carFrontLength, req.Configs.carBackLength});
    WP::RADIUS_CAR_EXTERNAL = std::max({req.Configs.carLeftWidth, req.Configs.carRightWidth, req.Configs.carFrontLength, req.Configs.carBackLength});
    car_model_ = new CarModel(req.Configs.carModel, req.Configs.carLeftWidth, req.Configs.carRightWidth, req.Configs.carFrontLength, req.Configs.carBackLength);
    res.result = 0;
    return true;
  }

  bool getPathCB(mpac_msgs::GetPath::Request &req,
                 mpac_msgs::GetPath::Response &res)
  {

    SPDLOG_INFO("Get path callback whih plan mode:{}", req.plan_parameters.planMode);
    mpac_msgs::RobotTarget tgt = req.target;
    std::vector<mpac_generic::Path> paths;
    mpac_generic::Path path;
    res.valid = false;
    res.PathGetMethod = static_cast<int>(mpac_generic::PlanMode::FREE);
    smooth_ = true;
    // save_paths_ = true;

    double start_orientation = tf::getYaw(tgt.start.pose.orientation);
    double goal_orientation = tf::getYaw(tgt.goal.pose.orientation);

    mpac_generic::State2d state_start(mpac_generic::Pose2d(tgt.start.pose.position.x,
                                                           tgt.start.pose.position.y,
                                                           start_orientation),
                                      tgt.start.steering);
    mpac_generic::State2d state_goal(mpac_generic::Pose2d(tgt.goal.pose.position.x,
                                                          tgt.goal.pose.position.y,
                                                          goal_orientation),
                                     tgt.goal.steering);

    string start_position = road_net_map.getPositionID(state_start.pose);
    string goal_position = road_net_map.getPositionID(state_goal.pose);

    SPDLOG_INFO("start {}: ({} {} {})({})",start_position.c_str(), tgt.start.pose.position.x, tgt.start.pose.position.y, start_orientation, tgt.start.steering);
    SPDLOG_INFO(" goal {}: ({} {} {})({})",goal_position.c_str(), tgt.goal.pose.position.x, tgt.goal.pose.position.y, goal_orientation, tgt.goal.steering);

    //检查目标点是否被占用
    double max_width = std::max({car_model_->getCarLeftWidth(), car_model_->getCarRightWidth()});
    double max_length = std::max({car_model_->getCarFrontLength(), car_model_->getCarBackLength()});
    if (!cd_->isCollisionFree(state_goal.pose, max_width, max_width, max_length, max_length))
    {
      SPDLOG_WARN("Target Point Is Occupied!");
      return false;
    }
    else
    {
      SPDLOG_INFO("Target Point Is not Occupied!");
    }

    double distance_diff = hypot((tgt.start.pose.position.x - tgt.goal.pose.position.x), (tgt.start.pose.position.y - tgt.goal.pose.position.y));

    //检查目标点和起点是否为同一点，如果为同一点，无需规划
    if (fabs(distance_diff) < planner_map.getGranularity())
    {
      path.addPathPoint(state_start.pose, state_start.steeringAngle);
      path.addPathPoint(state_goal.pose, state_goal.steeringAngle);

      mpac_msgs::Path msgpath = mpac_conversions::createPathMsgFromPathWithType(path);
      res.paths.paths.push_back(msgpath);

      nav_msgs::Path pathmsg;
      pathmsg.header.frame_id = "map";
      pathmsg.header.stamp = ros::Time::now();
      geometry_msgs::PoseStamped pose;
      pose.header.frame_id = "map";
      pose.header.stamp = pathmsg.header.stamp;
      for (size_t j = 0; j < path.sizePath(); j++)
      {
        pose.pose.position.x = path.poses[j](0);
        pose.pose.position.y = path.poses[j](1);
        pathmsg.poses.push_back(pose);
      }
      res.path_pub = pathmsg;
      res.valid = true;
      return true;
    }

    // // 检查路线是否已经存在
    // {
    //   if (goal_position != "" && start_position != "")
    //   {
    //     std::string pathName ="/var/sinevaAGV/paths/"+start_position + "_"+ goal_position + ".txt";
    //     spdlog::info("path name:{}",pathName);
    //     std::ifstream f(pathName.c_str()); 
    //     if (f.is_open())
    //     {

    //       spdlog::info("Extract historical lines!");

    //       mpac_generic::Pose2dVec poses;//路径点，用于验证历史线路是否可用

    //       nav_msgs::Path pathmsg;
    //       pathmsg.header.frame_id = "map";
    //       pathmsg.header.stamp = ros::Time::now();
    //       geometry_msgs::PoseStamped pose;
    //       pose.header.frame_id = "map";
    //       pose.header.stamp = pathmsg.header.stamp;

    //       std::string strLine;
    //       mpac_msgs::Path msgpath;

    //       mpac_msgs::Path sub_path;
    //       sub_path.path.clear();
    //       sub_path.point_types.clear();

    //       while (getline(f,strLine))
    //       {
    //         if (strLine == "----")
    //         {
    //           if (sub_path.path.size()>0)
    //           {
    //             res.paths.paths.push_back(sub_path);
    //             sub_path.path.clear();
    //             sub_path.point_types.clear();
    //           }else
    //           {
    //             continue;
    //           }

    //         }else{

    //             mpac_msgs::PoseSteering ps;
    //             mpac_msgs::PointType pt;

    //             int i_forbid, i_limit,i_fixed,i_forward;

    //             std::stringstream ss(strLine);
    //             ss >> ps.pose.position.x >> ps.pose.position.y >> ps.pose.position.z 
    //                >> ps.pose.orientation.x >> ps.pose.orientation.y >> ps.pose.orientation.z >> ps.pose.orientation.w
    //                >> pt.direction >> pt.maxSpeed >> pt.offset >> i_forbid >> i_limit >> i_fixed >> i_forward;

    //             pt.forbid = (bool)i_forbid;
    //             pt.limit = (bool)i_limit;
    //             pt.fixed = (bool)i_fixed;
    //             pt.forward = (bool)i_forward;

    //             spdlog::info("pt.direction:{}  pt.maxSpeed:{}  pt.offset:{}  pt.forbid:{}   pt.limit:{}  pt.fixed:{}  pt.forward:{}",pt.direction,pt.maxSpeed , pt.offset, pt.forbid , pt.limit, pt.fixed , pt.forward);
    //             sub_path.path.push_back(ps);
    //             sub_path.point_types.push_back(pt);

    //             pose.pose.position.x = ps.pose.position.x;
    //             pose.pose.position.y = ps.pose.position.y;
    //             pathmsg.poses.push_back(pose);

    //             mpac_generic::Pose2d wayPoint(ps.pose.position.x,ps.pose.position.y,tf::getYaw(ps.pose.orientation));
    //             poses.push_back(wayPoint);
    //         }
            
    //       }
    //       res.paths.paths.push_back(sub_path);

    //       f.close();

    //       //判断历史路径点是否需要更新（此时不考虑动态障碍物）
    //       if (!cd_->isCollisionFree(poses,max_width))
    //       {
    //         //历史轨迹存在静态障碍物（eg.禁行区、擦除地板、单行区、限制区）
    //       }
          

    //       res.valid = true;
    //       res.PathGetMethod = static_cast<int>(mpac_generic::PlanMode::FREE);
    //       res.path_pub = pathmsg;
    //       return true;
          
    //     }

    //   }
    // }

    //是否在路网图内寻找可通行路径
    if (req.plan_parameters.planMode == mpac_msgs::PlanParameters::ROADNET)
    {
      //判断终点是否在路网图内
      if (goal_position != "" && start_position != "")
      {

          vector<string> positions_id = graph_dg_->solve(start_position, goal_position);

          if (positions_id.size() > 0) //已在路网图中找到可通行路径
          {

            { //打印路径点
              string path_str = "";
              for (size_t i = 0; i < positions_id.size() - 1; i++)
              {
                path_str = path_str + positions_id[i] + "=>";
              }
              path_str = path_str + positions_id.back();

              SPDLOG_INFO("The road lines: {}", path_str.c_str());
            }

            assert(start_position == positions_id.front() && goal_position == positions_id.back());
            int last_path_direction = 0;
            double last_yaw = 0.0;
            for (size_t i = 0; i < positions_id.size() - 1; i++)
            {
              mpac_generic::Path local_path;
              local_path = road_net_map.roads_[positions_id[i]][positions_id[i + 1]].path;
              mpac_generic::PointType pointType = local_path.pointTypes[0];

              SPDLOG_INFO("The start position {} To end position {} with speed:{}、direction:{}、offset:{}", positions_id[i].c_str(), positions_id[i + 1].c_str(), pointType.max_speed_, pointType.forward_, pointType.offset_);
              int cur_path_direction = road_net_map.roads_[positions_id[i]][positions_id[i + 1]].direciton;

              mpac_generic::Path path_min_dist = mpac_generic::minIncrementalDistancePath(local_path, planner_map.getGranularity());
              for (size_t j = 0; j < path_min_dist.sizePath(); j++)
              {
                path_min_dist.setPathPointType(j, pointType);
              }

              double cur_yaw = path_min_dist.poses.front().z();
              double yaw_change = cur_yaw - last_yaw;
              yaw_change = atan2(sin(yaw_change),cos(yaw_change));
              spdlog::info("last_yaw:{}  cur_yaw:{}  yaw_change:{}",last_yaw,cur_yaw,yaw_change);
              last_yaw = path_min_dist.poses.back().z();

              // mpac_generic::Pose2d last_Pose = road_net_map.getPositonValue(positions_id[i + 1]);
              // path_min_dist.poses.back() = last_Pose;

              if (paths.empty() || (last_path_direction != cur_path_direction) || fabs(yaw_change)>0.785)
              {
                paths.push_back(path_min_dist);
                // ROS_INFO("[GetPathService]:track line parameters:%f %d", path_min_dist.pointTypes[0].max_speed_, path_min_dist.pointTypes[0].forward_);
              }
              else
              {
                for (size_t j = 0; j < path_min_dist.sizePath(); j++)
                {
                  paths.back().addPathPointType(path_min_dist.poses[j], path_min_dist.steeringAngles[j], path_min_dist.pointTypes[j]);
                  // ROS_INFO("[GetPathService]:track line parameters:%f %d", path_min_dist.pointTypes[j].max_speed_, path_min_dist.pointTypes[j].forward_);
                }
              }
              last_path_direction = cur_path_direction;
            }
            for (size_t i = 0; i < paths.size(); i++)
            {
              std::vector<int> idx_need_smooth;
              std::vector<mpac_generic::PointType> pointsType = paths[i].pointTypes;
              mpac_generic::Pose2dVec poses = paths[i].poses;

              for (size_t j = 1; j < pointsType.size(); j++)
              {
                if (fabs(pointsType[j].max_speed_) < fabs(pointsType[j - 1].max_speed_))
                {
                  idx_need_smooth.push_back(j);
                }
              }

              SPDLOG_INFO("{} points need to be smoothed!", idx_need_smooth.size());

              for (size_t j = 0; j < idx_need_smooth.size(); j++)
              {

                int idx_start = idx_need_smooth[j];

                double v_diff = pointsType[idx_start - 1].max_speed_ - pointsType[idx_start].max_speed_;
                double t_slow_down = fabs(v_diff) / 0.3;
                double d_slow_down = (pointsType[idx_start].max_speed_ * pointsType[idx_start].max_speed_ + pointsType[idx_start - 1].max_speed_ * pointsType[idx_start - 1].max_speed_) * t_slow_down * 0.5;
                double dis_tmp = 0.0;
                int idx = idx_start;
                while (dis_tmp < d_slow_down && idx > 0)
                {
                  idx--;
                  dis_tmp = hypot(poses[idx].x() - poses[idx_start].x(), poses[idx].y() - poses[idx_start].y());
                  paths[i].pointTypes[idx].max_speed_ = dis_tmp / d_slow_down * v_diff + pointsType[idx_start].max_speed_;
                }
              }
            }

            res.valid = true;
            res.PathGetMethod = static_cast<int>(mpac_generic::PlanMode::ROADNET);
            smooth_ = false;
          }
          else
          {
            res.valid = false;
            smooth_ = true;
          }
        
      
      } 
      else
      {
        SPDLOG_WARN("the start or goal is not in road net!");
      }
    }

    if (!res.valid)
    {
      // convertNavMsgsOccupancyGridToWorldOccupancyMapRef(req.map, planner_map, car_model_->getWidth() / 2);

      //更新非穿行区
      planner_map.initNoCrossingMap(0);
      std::vector<mpac_geometry::Polygon> noCrossingAreasValid;
      noCrossingAreasValid.clear();
      for (size_t i = 0; i < noCrossingAreas_.size(); i++)
      {
        //todo 判断起点和终点是否在非穿行区内
        bool goalInPoly = false;
        bool startInPoly = false;
        goalInPoly = noCrossingAreas_[i].isWithinPolygon(state_goal.pose);
        startInPoly = noCrossingAreas_[i].isWithinPolygon(state_start.pose);

        SPDLOG_WARN("在非穿行区！{} {}", goalInPoly, startInPoly);
        if (noCrossingAreas_[i].isWithinPolygon(state_start.pose) || noCrossingAreas_[i].isWithinPolygon(state_goal.pose))
        {
          continue;
        }
        else
        {
          noCrossingAreasValid.push_back(noCrossingAreas_[i]);
        }
      }

      if (noCrossingAreasValid.size() > 0)
      {
        for (size_t i = 0; i < noCrossingAreasValid.size(); i++)
        {
          mpac_generic::Point2dVec points;

          points = noCrossingAreasValid[i].discretizePolygon(planner_map.getGranularity(), true);

          std::vector<cellPosition> changepoints;

          for (size_t j = 0; j < points.size(); j++)
          {
            cellPosition cp;
            planner_map.world2map(points[j].x(), points[j].y(), cp.x_cell, cp.y_cell);
            changepoints.push_back(cp);
          }
          planner_map.updateValue(changepoints, static_cast<uint8_t>(1), mpac_generic::VectorMapType::NoCrossingMap);
        }
      }

      double map_offset_x, map_offset_y, map_offset_yaw;
      planner_map.getOrigin(map_offset_x, map_offset_y, map_offset_yaw);

      SPDLOG_INFO("map_offset: [{},{}]", map_offset_x, map_offset_y);

      if (planner_map.getMap().empty())
      {
        SPDLOG_ERROR("error in the provided map;");
        return false;
      }

      if (req.plan_parameters.planTime > 0.)
        path_finder_->setTimeBound(req.plan_parameters.planTime);

      if (vm_ == NULL)
      {
        SPDLOG_INFO("New Mission");
        vm_ = new VehicleMission(car_model_,
                                 tgt.start.pose.position.x - map_offset_x, tgt.start.pose.position.y - map_offset_y, start_orientation, tgt.start.steering,
                                 tgt.goal.pose.position.x - map_offset_x, tgt.goal.pose.position.y - map_offset_y, goal_orientation, tgt.goal.steering);
      }
      else
      {
        SPDLOG_INFO("Update Mission");
        vm_->updateMission(tgt.start.pose.position.x - map_offset_x, tgt.start.pose.position.y - map_offset_y, start_orientation, tgt.start.steering,
                           tgt.goal.pose.position.x - map_offset_x, tgt.goal.pose.position.y - map_offset_y, goal_orientation, tgt.goal.steering);
      }

      path_finder_->addMission(vm_);

      if (WP::USE_FAST_PLAN_MODE)
      {
        SPDLOG_INFO("Start planning by fast plan mode");
        ros::Time start_time = ros::Time::now();
        std::vector<mpac_generic::Pose2d> solution = path_finder_->solve();
        ros::Time stop_time = ros::Time::now();
        SPDLOG_INFO("Finish Planing with time :{} s", (stop_time - start_time).toSec());
        if (!(solution.size() > 0))
        {
          SPDLOG_WARN("Global path plan failed!");
          res.valid = false;
          return false;
        }
        else
        {
          for (size_t i = 0; i < solution.size(); i++)
          {
            mpac_generic::State2d state(mpac_generic::Pose2d(solution[i].x(),
                                                             solution[i].y(),
                                                             solution[i].z()),
                                        0.0);
            path.addState2dInterface(state);
          }

          mpac_generic::State2d state_goal(mpac_generic::Pose2d(tgt.goal.pose.position.x,
                                                                tgt.goal.pose.position.y,
                                                                solution.back().z()),
                                           0.0);
          path.addState2dInterface(state_goal);

          res.valid = true;
        }
      }
      else
      {
       
        SPDLOG_INFO("Start Planning............");
        ros::Time start_time = ros::Time::now();
        std::vector<std::vector<Configuration *>> solution = path_finder_->solve(false);
        ros::Time stop_time = ros::Time::now();
        SPDLOG_INFO("Finish Planing with time :{} s", (stop_time - start_time).toSec());

        if (!(solution[0].size() > 0))
        {
          SPDLOG_WARN("Global path plan failed!");
          res.valid = false;
          return false;
        }

        double orientation;
        for (std::vector<std::vector<Configuration *>>::iterator it = solution.begin(); it != solution.end(); it++)
        {
          for (std::vector<Configuration *>::iterator confit = (*it).begin(); confit != (*it).end(); confit++)
          {
            std::vector<vehicleSimplePoint> path_local = (*confit)->getTrajectory();

            for (std::vector<vehicleSimplePoint>::iterator it2 = path_local.begin(); it2 != path_local.end(); it2++)
            {
              orientation = it2->orient;

              mpac_generic::State2d state(mpac_generic::Pose2d(it2->x + map_offset_x,
                                                               it2->y + map_offset_y,
                                                               orientation),
                                          it2->steering);
              path.addState2dInterface(state);
            }
          }
        }

        mpac_generic::State2d state_goal(mpac_generic::Pose2d(tgt.goal.pose.position.x,
                                                              tgt.goal.pose.position.y,
                                                              orientation),
                                         tgt.goal.steering);
        path.addState2dInterface(state_goal);

        // Cleanup
        for (std::vector<std::vector<Configuration *>>::iterator it = solution.begin(); it != solution.end(); it++)
        {
          std::vector<Configuration *> confs = (*it);
          for (std::vector<Configuration *>::iterator confit = confs.begin(); confit != confs.end(); confit++)
          {
            delete *confit;
          }
          confs.clear();
        }

        res.valid = true;
      }

      // First requirement (that the points are separated by a minimum distance).
      mpac_generic::Path path_min_dist = mpac_generic::minIncrementalDistancePath(path, planner_map.getGranularity());
      // Second requirment (path states are not allowed to change direction of motion without any intermediate points).
      mpac_generic::Path path_dir_change = mpac_generic::minIntermediateDirPathPoints(path_min_dist);

      //根据运动方向对路径进行分段
      SPDLOG_INFO("Maximum path length:{}", req.plan_parameters.maxDistance);
      SPDLOG_INFO("Current path length:{}", mpac_generic::getTotalDistance(path_dir_change));

      if (req.plan_parameters.maxDistance > 0)
      {
        double dis_path = mpac_generic::getTotalDistance(path_dir_change);
        SPDLOG_INFO("Current path length:{}", dis_path);
        if (dis_path > req.plan_parameters.maxDistance)
        {
          SPDLOG_WARN("Path offset is longer than threshold");
          res.valid = false;
          return false;
        }
      }

      paths = mpac_generic::splitToDirectionalPaths(path_dir_change);
   
      //确定路径点的属性
      for (size_t i = 0; i < paths.size(); i++)
      {
        for (size_t j = 0; j < paths[i].poses.size(); j++)
        {
          mpac_generic::Pose2d pose = paths[i].poses[j];
          mpac_generic::PointType pointType /* = paths[i].pointTypes[j] */;
          int x_cell, y_cell;
          planner_map.world2map(pose(0), pose(1), x_cell, y_cell);
          pointType.direction_ = planner_map.getDirectionValueInCell(x_cell, y_cell);
          pointType.max_speed_ = 2.0;
          pointType.offset_ = 2.0;
          paths[i].setPathPointType(j, pointType);
        }
      }
    }

    SPDLOG_INFO(" Nb of paths: {}", paths.size());

    nav_msgs::Path pathmsg;
    pathmsg.header.frame_id = "map";
    pathmsg.header.stamp = ros::Time::now();
    geometry_msgs::PoseStamped pose;
    pose.header.frame_id = "map";
    pose.header.stamp = pathmsg.header.stamp;

    nav_msgs::Path pathmsg_raw;
    pathmsg_raw.header.frame_id = "map";
    pathmsg_raw.header.stamp = ros::Time::now();
    geometry_msgs::PoseStamped pose_raw;
    pose_raw.header.frame_id = "map";
    pose_raw.header.stamp = pathmsg_raw.header.stamp;

    for (size_t i = 0; i < paths.size(); i++)
    {
      for (size_t j = 0; j < paths[i].poses.size(); j++)
      {
        pose_raw.pose.position.x = paths[i].poses[j](0);
        pose_raw.pose.position.y = paths[i].poses[j](1);
        pathmsg_raw.poses.push_back(pose_raw);
      }

      if (smooth_)
      {
        path_smoother_->setOriginalPath(paths[i]);
        SmootherOptions op;
        op.max_iterations = 1000;
        op.obsDMax = (car_model_->getLength() / 2 + 0.1) / planner_map.getGranularity();
        op.vorObsDMax = (car_model_->getLength() / 2 + 0.3) / planner_map.getGranularity();
        op.wSmoothness = 0.4;
        op.wObstacle = 0.3;
        op.wVoronoi = 0.3;
        op.wCurvature = 0.0;
        op.alpha = 0.5;
        path_smoother_->smoothPath(op);
        mpac_generic::Path path_smoothed;
        path_smoothed = path_smoother_->getSmoothedPath();

        mpac_generic::Path path_temp = mpac_generic::minIncrementalDistancePath(path_smoothed, planner_map.getGranularity());

        path_temp.pointTypes.clear();
        for (size_t j = 0; j < path_temp.sizePath(); j++)
        {
          path_temp.pointTypes.push_back(paths[i].pointTypes[0]);
        }

        mpac_msgs::Path msgpath = mpac_conversions::createPathMsgFromPathWithType(path_temp);

        for (size_t j = 0; j < path_temp.sizePath(); j++)
        {
          pose.pose.position.x = path_temp.poses[j](0);
          pose.pose.position.y = path_temp.poses[j](1);
          pathmsg.poses.push_back(pose);
        }
        res.paths.paths.push_back(msgpath);
      }
      else
      {
        mpac_msgs::Path msgpath = mpac_conversions::createPathMsgFromPathWithType(paths[i]);
        for (size_t j = 0; j < paths[i].sizePath(); j++)
        {
          pose.pose.position.x = paths[i].poses[j](0);
          pose.pose.position.y = paths[i].poses[j](1);
          pathmsg.poses.push_back(pose);
        }
        res.paths.paths.push_back(msgpath);
      }
    }
    res.path_pub = pathmsg;
    path_pub_.publish(pathmsg_raw);

    if (visualize_)
    {
      mpac_generic::Pose2d start_pose(tgt.start.pose.position.x,
                                      tgt.start.pose.position.y,
                                      tf::getYaw(tgt.start.pose.orientation));
      mpac_generic::Pose2d goal_pose(tgt.goal.pose.position.x,
                                     tgt.goal.pose.position.y,
                                     tf::getYaw(tgt.goal.pose.orientation));
      ROS_INFO_STREAM("[GetPathService] - Path visualize");
      mpac_rviz::drawPose2d(start_pose, 0, 0, 2., "start_pose2d", marker_pub_);
      mpac_rviz::drawPose2d(goal_pose, 0, 2, 2., "goal_pose2d", marker_pub_);
      //mpac_rviz::drawPose2dContainer(mpac_generic::minIncrementalDistancePath(path, 0.2), "path_all", 1, marker_pub_);
    }

    // if (save_paths_)
    // {

    //   std::string pathName ="/var/sinevaAGV/paths/"+start_position + "_"+ goal_position + ".txt";
    //   std::ofstream f; 
    //   f.open(pathName.c_str());

    //   for (size_t i = 0; i < res.paths.paths.size(); i++)
    //   {
    //     f<<"----"<<std::endl;
    //     mpac_msgs::Path msgpath = res.paths.paths[i];
    //     for (size_t j = 0; j < msgpath.path.size(); j++)
    //     {
    //       f<< msgpath.path[j].pose.position.x << " " << msgpath.path[j].pose.position.y << " " << msgpath.path[j].pose.position.z << " "
    //        << msgpath.path[j].pose.orientation.x << " "<< msgpath.path[j].pose.orientation.y << " "<< msgpath.path[j].pose.orientation.z << " "<< msgpath.path[j].pose.orientation.w <<" "
    //        << msgpath.point_types[j].direction << " " << msgpath.point_types[j].maxSpeed << " " << msgpath.point_types[j].offset << " " << (int)msgpath.point_types[j].forbid << " " 
    //        << (int)msgpath.point_types[j].limit << " " << (int)msgpath.point_types[j].fixed << " " << (int)msgpath.point_types[j].forward << std::endl;
    //     }
        
    //   }
      
    //   f.close();
  
    // }
    return true;
  }

  void stateMonitor()
  {
    while (ros::ok())
    {
      heart_beat_pub_.publish(heartBeatmsg);
      // ros::spinOnce();
      usleep(1000 * 1000);
    }
  }

  void pubHeartbeatTimeroutCB(const ros::TimerEvent &)
  {
    heart_beat_pub_.publish(heartBeatmsg);
  }
};

int main(int argc, char **argv)
{

  //log
  std::vector<spdlog::sink_ptr> spdlog_sinks;
  spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());
  // spdlog_sinks.emplace_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>("/home/nuc/tmp/mpac/mpac_global_planner.log", true));
  spdlog_sinks[0]->set_level(spdlog::level::info);
  // spdlog_sinks[1]->set_level(spdlog::level::debug);
  spdlog::set_default_logger(std::make_shared<spdlog::logger>("globalPlanner", spdlog_sinks.begin(), spdlog_sinks.end()));
  spdlog::set_level(spdlog::level::debug);
  //log

  ros::init(argc, argv, "get_path_service");
  ros::NodeHandle parameters("~");
  GetPathService gps(parameters, ros::this_node::getName());

  ros::spin();
}
