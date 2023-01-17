#pragma once

#include <mpac_global_planner/PathFinder.h>
#include <nav_msgs/OccupancyGrid.h>
#include <mpac_generic/types.h>
#include <mpac_conversions/conversions.h>
#include <mpac_msgs/VectorMap.h>
#include <mpac_msgs/Shape.h>
#include <mpac_geometry/polygon.h>
#include <spdlog/spdlog.h>

using namespace mpac_generic;
mpac_generic::Pose2d getNavMsgsOccupancyGridOffset(const nav_msgs::OccupancyGridConstPtr &msg)
{
  return mpac_conversions::createPose2dFromMsg(msg->info.origin);
}

mpac_generic::Pose2d getNavMsgsOccupancyGridOffsetRef(const nav_msgs::OccupancyGrid &msg)
{
  return mpac_conversions::createPose2dFromMsg(msg.info.origin);
}

// void convertNavMsgsOccupancyGridToWorldOccupancyMap(const nav_msgs::OccupancyGridConstPtr& msg, WorldOccupancyMap &map)
// {
//   double granularity = msg->info.resolution;
//   int xcells = msg->info.width;
//   int ycells = msg->info.height;

//   std::vector<std::vector<double> > occupancyMap;
//   occupancyMap.resize(msg->info.height);

//   unsigned int k = 0;
//   for (unsigned int i = 0; i < msg->info.height; i++)
//     {
//       occupancyMap[i].resize(msg->info.width);
//       for (unsigned int j = 0; j < msg->info.width; j++)
// 	{
// 	  occupancyMap[i][j] = msg->data[k]*0.01;
// 	  k++;
// 	}
//     }
//   map.initialize(xcells, ycells, granularity, occupancyMap);
// }

void convertNavMsgsOccupancyGridToWorldOccupancyMapRef(const nav_msgs::OccupancyGrid &msg, WorldOccupancyMap &map, double expansion_radius)
{
  double granularity = msg.info.resolution;

  int xcells = msg.info.width;
  int ycells = msg.info.height;

  std::vector<std::vector<double>> occupancyMap;
  occupancyMap.resize(msg.info.height);

  unsigned int k = 0;
  for (unsigned int i = 0; i < msg.info.height; i++)
  {
    occupancyMap[i].resize(msg.info.width);
    for (unsigned int j = 0; j < msg.info.width; j++)
    {
      occupancyMap[i][j] = msg.data[k] * 0.01;
      if (occupancyMap[i][j] < 0)
      {
        if (!WP::PASSABLE_UNKNOWN_SPACE)
        {
          occupancyMap[i][j] = 1;
        }
        else
        {
          occupancyMap[i][j] = 0;
        }
      }
      k++;
    }
  }
  //如果膨胀半径大约0，则对静态地图进行膨胀
  if (expansion_radius > 0)
  {
    int expansion_grids = ceil(expansion_radius / granularity);

    std::vector<std::vector<double>> occupancyMapExpande;
    occupancyMapExpande = occupancyMap;
    for (unsigned int i = 0; i < msg.info.height; i++)
    {
      for (unsigned int j = 0; j < msg.info.width; j++)
      {
        if (occupancyMapExpande[i][j] > WP::OCCUPANCY_THRESHOLD)
        {
          for (int m = -expansion_grids; m < expansion_grids; m++)
          {
            for (int n = -expansion_grids; n < expansion_grids; n++)
            {
              if ((m + i >= 0) && (m + i < ycells) && (n + j >= 0) && (n + j < xcells))
              {
                if (occupancyMap[i + m][j + n] <= WP::OCCUPANCY_THRESHOLD)
                {
                  occupancyMap[i + m][j + n] = -0.01;
                }
              }
            }
          }
        }
      }
    }
  }
  map.initialize(xcells, ycells, granularity, occupancyMap);

  mpac_generic::Pose2d origin = getNavMsgsOccupancyGridOffsetRef(msg);
  map.setOrigin(origin(0), origin(1), origin(2));
}

void convertNavMsgsOccupancyGridFromWorldOccupancyMapRef(nav_msgs::OccupancyGrid &msg, WorldOccupancyMap &map)
{
  msg.info.resolution = map.getGranularity();
  msg.info.width = map.getXCells();
  msg.info.height = map.getYCells();
  double x, y, yaw;
  map.getOrigin(x, y, yaw);
  msg.info.origin.position.x = x;
  msg.info.origin.position.y = y;
  msg.info.origin.orientation = tf::createQuaternionMsgFromYaw(yaw);
  int xcells = msg.info.width;
  int ycells = msg.info.height;
  std::vector<std::vector<double>> occupancyMap;

  occupancyMap = map.getMap();
  for (unsigned int i = 0; i < msg.info.height; i++)
  {
    for (unsigned int j = 0; j < msg.info.width; j++)
    {

      double value = std::max(map.getProhibitedValueInCell(j, i) * 100.0, occupancyMap[i][j] * 100);
      if (map.getDirectionValueInCell(j, i) > 0)
      {
        value = map.getDirectionValueInCell(j, i) * 10;
      }

      msg.data.push_back(value);
    }
  }
}

void convertVectorMapToWorldOccupancyMapData(const mpac_msgs::VectorMap &msg, WorldOccupancyMap &map, mpac_generic::VectorMapType type)
{

  int size_shapes = msg.objects.size();
  double safeDis = 0.0;

  if ((map.getXCells() <= 0) || (map.getYCells() <= 0))
  {
    return;
  }

  switch (type)
  {
  case VectorMapType::ProhibitedMap:
    map.initProhibitedMap(0);
    safeDis = 0.0;
    break;
  case VectorMapType::DirectionMap:
    map.initDirectionMap(0);
    safeDis = 0.1;
    break;
  case VectorMapType::SpeedMap:
    map.initSpeedMap(0);
    safeDis = 0.1;
    break;
  case VectorMapType::NoCrossingMap:
    map.initNoCrossingMap(0);
    safeDis = 0.35;
    break;
  case VectorMapType::ChannelMap:
    map.initChannelMap(0);
    safeDis = 0.1;
    break;
  default:
    break;
  }

  for (size_t i = 0; i < size_shapes; i++)
  {
    mpac_msgs::Shape shape = msg.objects[i];
    mpac_generic::Point2dVec pts;
    for (size_t j = 0; j < shape.points.size() - 1; j++)
    {
      Eigen::Vector2d point(shape.points[j].x, shape.points[j].y);
      pts.push_back(point);
    }
    mpac_geometry::Polygon polygon(pts, safeDis);
    mpac_generic::Point2dVec points;

    points = polygon.discretizePolygon(map.getGranularity(), true);

    std::vector<cellPosition> changepoints;

    for (size_t j = 0; j < points.size(); j++)
    {
      cellPosition cp;
      map.world2map(points[j].x(), points[j].y(), cp.x_cell, cp.y_cell);
      changepoints.push_back(cp);
    }
    map.updateValue(changepoints, static_cast<uint8_t>(shape.parameter), type);
  }
}
