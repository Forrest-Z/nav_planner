#pragma once

#include <cmath>
#include <vector>

#include "World.h"
#include "WorldOccupancyMap.h"
#include "CollisionDetector.h"

#include "pose2d.h"
#include "vec2d.h"
#include "dynamic_voronoi.h"
// #include "constants.h"

#include "mpac_generic/types.h"
#include "mpac_generic/path_utils.h"

template <typename T>
T Clamp(const T value, T bound1, T bound2)
{
  if (bound1 > bound2)
  {
    std::swap(bound1, bound2);
  }

  if (value < bound1)
  {
    return bound1;
  }
  else if (value > bound2)
  {
    return bound2;
  }
  return value;
};

struct SmootherOptions
{
  
  float obsDMax = 40;
  /// maximum distance for obstacles to influence the voronoi field
  float vorObsDMax = 50;
  //obsDMax的作用更显著，应该 vorObsDMax >= obsDMax。首先要不碰撞障碍物，在不碰的前提下，调整离障碍物的距离

  /// falloff rate for the voronoi field
  float alpha = 0.1;
  float wObstacle = 0.1;
  float wVoronoi = 0.;
  float wCurvature = 0;
  float wSmoothness = 0.1;
  int max_iterations = 100;
  float min_turn_radius = 1;
  float kappaMax = 1.f / (min_turn_radius * 1.1);
};

class Smoother
{
public:
  Smoother(WorldOccupancyMap *map);
  ~Smoother();

  
  void setOriginalMap(double origin_x, double origin_y, double origin_yaw, double resolution, std::vector<std::vector<int>> map_data);
  void setOriginalPath(mpac_generic::Path path);

  void smoothPath(SmootherOptions op);

  mpac_generic::Path getOriginalPath() { return original_path_; }

  mpac_generic::Path getSmoothedPath();
  // DynamicVoronoi voronoi_;

private:
  Vec2d obstacleTerm(Vec2d xi); //障碍物项，用于约束路径远离障碍物

  Vec2d curvatureTerm(Vec2d xi0, Vec2d xi1, Vec2d xi2); //曲率项，用于保证可转弯性及通行性

  //平滑项，用于将节点等距分布并尽量保持同一个方向
  Vec2d smoothnessTerm(Vec2d xim2, Vec2d xim1, Vec2d xi, Vec2d xip1, Vec2d xip2);
  Vec2d smoothnessTerm(Vec2d xim1, Vec2d xi, Vec2d xip1);

  Vec2d voronoiTerm(Vec2d xi);

  bool isOnGrid(Vec2d vec);

  SmootherOptions options_;

  //  cv::Mat map_img_;
  int map_width_;
  int map_height_;
  double origin_x_;
  double origin_y_;
  double origin_theta_;

  double resolution_;

  // std::vector<Pose2d> original_path_;
  // std::vector<Pose2d> smoothed_path_;
  mpac_generic::Path original_path_;
  mpac_generic::Path smoothed_path_;

  WorldOccupancyMap *worldMap_;
  CollisionDetector *cd_;
};
