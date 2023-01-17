
#include "mpac_global_planner/smoother.h"
#include <spdlog/spdlog.h>

Smoother::Smoother(WorldOccupancyMap *map)
{

  worldMap_ = map;
  cd_ = new CollisionDetector(worldMap_);

  map_height_ = worldMap_->getYCells();
  map_width_ = worldMap_->getXCells();

  worldMap_->getOrigin(origin_x_, origin_y_, origin_theta_);
  resolution_ = worldMap_->getGranularity();

  // int xcells = map->getXCells();
  // int ycells = map->getYCells();

  // std::vector<std::vector<int>> occupancyMap;
  // occupancyMap.resize(ycells);

  // unsigned int k = 0;
  // for (unsigned int i = 0; i < ycells; i++)
  // {
  //   occupancyMap[i].resize(xcells);
  //   for (unsigned int j = 0; j < xcells; j++)
  //   {
  //     if (map->getOccupancyValueInCell(j, i) > 0.5 || map->getProhibitedValueInCell(j, i) > 0)
  //     {
  //       occupancyMap[i][j] = 1;
  //     }
  //     else
  //     {
  //       occupancyMap[i][j] = 0;
  //     }
  //     k++;
  //   }
  // }

  // //地图信息　原点及分辨率
  // double x, y, yaw, resolution;
  // map->getOrigin(x, y, yaw);
  // resolution = map->getGranularity();

  // setOriginalMap(x, y, yaw, resolution, occupancyMap);
}

Smoother::~Smoother()
{
  delete cd_;
}

// void Smoother::setOriginalMap(double origin_x, double origin_y, double origin_yaw, double resolution, std::vector<std::vector<int>> map_data)
// {
//   map_height_ = map_data.size();
//   map_width_ = map_data[0].size();
//   voronoi_.buildVoronoiFromMap(map_data);
//   origin_x_ = origin_x;
//   origin_y_ = origin_y;
//   origin_theta_ = origin_yaw;
//   resolution_ = resolution;
// }

//设置初始路径，保持空间尺度一致
void Smoother::setOriginalPath(mpac_generic::Path path)
{
  original_path_.clear();

  if (fabs(resolution_ - 1) > 0.001)
  {
    for (size_t i = 0; i < path.sizePath(); i++)
    {

      mpac_generic::State2d state = path.getState2d(i);

      state.pose(0) = ((state.pose(0) - origin_x_)) / resolution_;
      state.pose(1) = ((state.pose(1) - origin_y_)) / resolution_;

      original_path_.addState2dInterface(state);
    }
  }
  original_path_.pointTypes = path.pointTypes;
}

mpac_generic::Path Smoother::getSmoothedPath()
{
  mpac_generic::Path ret;

  for (size_t i = 0; i < smoothed_path_.sizePath(); i++)
  {
    mpac_generic::State2d state;
    state.pose(0) = origin_x_ + smoothed_path_.poses[i](0) * resolution_;
    state.pose(1) = origin_y_ + smoothed_path_.poses[i](1) * resolution_;

    ret.addState2dInterface(state);
  }
  return ret;
}
void Smoother::smoothPath(SmootherOptions op)
{
  this->options_ = op;
  int iterations = 0;
  smoothed_path_ = original_path_;
  float totalWeight = options_.wSmoothness + options_.wCurvature + options_.wVoronoi + options_.wObstacle;

  //Todo:make sure the cycle end condition
  SPDLOG_INFO("SmoothPath.............");
  while (iterations < options_.max_iterations)
  {


    int iterations_left = options_.max_iterations - iterations;
    if (iterations_left<50)
    {
      options_.alpha = 0.1;
    }
    
    for (int i = 1; i < smoothed_path_.poses.size() - 1; ++i)
    {
      if (smoothed_path_.pointTypes[i].direction_ > 0)
      {
        continue;
      }

      // Vec2d xim2(smoothed_path_.poses[i - 2].x(), smoothed_path_.poses[i - 2].y());
      Vec2d xim1(smoothed_path_.poses[i - 1].x(), smoothed_path_.poses[i - 1].y());
      Vec2d xi(smoothed_path_.poses[i].x(), smoothed_path_.poses[i].y());
      Vec2d xip1(smoothed_path_.poses[i + 1].x(), smoothed_path_.poses[i + 1].y());
      // Vec2d xip2(smoothed_path_.poses[i + 2].x(), smoothed_path_.poses[i + 2].y());
      Vec2d correction;
      Vec2d gradient;

      if (this->options_.wObstacle > 0)
      {

        gradient = obstacleTerm(xi);
        correction = correction - gradient;
        if (!isOnGrid(xi + correction))
        {
          SPDLOG_WARN("obstacle gradient:({},{})",gradient.x(),gradient.y());
          SPDLOG_WARN("point({},{}) is not on Grid",(xi + correction).x(),(xi + correction).y());
          continue;
        }
      }

      if (this->options_.wVoronoi > 0)
      {
        gradient = voronoiTerm(xi);
        correction = correction - gradient;
        if (!isOnGrid(xi + correction))
        {
          SPDLOG_WARN("voronoi gradient:({},{})",gradient.x(),gradient.y());
          SPDLOG_WARN("point({},{}) is not on Grid",(xi + correction).x(),(xi + correction).y());
          continue;
        }
      }

      if (this->options_.wCurvature > 0)
      {

        gradient = curvatureTerm(xim1, xi, xip1);
        correction = correction - gradient;
        if (!isOnGrid(xi + correction))
        {
          SPDLOG_WARN("curvature gradient:({},{})",gradient.x(),gradient.y());
          SPDLOG_WARN("point({},{}) is not on Grid",(xi + correction).x(),(xi + correction).y());
          continue;
        }
      }

      if (this->options_.wSmoothness > 0)
      {

        gradient = smoothnessTerm(xim1, xi, xip1);
        correction = correction - gradient;
        if (!isOnGrid(xi + correction))
        {
          SPDLOG_WARN("smooth gradient:({},{})",gradient.x(),gradient.y());
          SPDLOG_WARN("point({},{}) is not on Grid",(xi + correction).x(),(xi + correction).y());
          continue;
        }
      }

      xi = xi + options_.alpha * correction / totalWeight;
      if (!cd_->isPassable((int)(xim1.x()+0.5), (int)(xim1.y()+0.5),(int)(xi.x()+0.5), (int)(xi.y()+0.5)))
      {
        // SPDLOG_WARN("point({},{}) is not passable",xi.x(), xi.y());
        continue;
      }

      Vec2d Dxi = xi - xim1;
      // 判断是否是单行区，且方向是否被允许
      mpac_generic::Pose2d pose(xi.x(), xi.y(), smoothed_path_.poses[i].z());

      smoothed_path_.poses[i][0] = xi.x();
      smoothed_path_.poses[i][1] = xi.y();

      smoothed_path_.poses[i - 1][2] = std::atan2(Dxi.y(), Dxi.x());
    }
    mpac_generic::Path path_temp = mpac_generic::minIncrementalDistancePath(smoothed_path_, resolution_);
    smoothed_path_ = path_temp;
    iterations++;
  }
}

Vec2d Smoother::obstacleTerm(Vec2d xi)
{
  Vec2d gradient;
  // the distance to the closest obstacle from the current node

  float obsDst = worldMap_->voronoi_.getDistance(xi.x(), xi.y());
  // SPDLOG_INFO("obsDst:{}",obsDst*0.05);
  if ((obsDst*0.05)<0.5)
  {
    // SPDLOG_WARN("x:{}  y:{} obsDst:{}",origin_x_ + xi.x() * resolution_,origin_y_ + xi.y() * resolution_,obsDst);
  }
  
  // the vector determining where the obstacle is
  int x = (int)xi.x();
  int y = (int)xi.y();
  // if the node is within the map
  if (x < map_width_ && x >= 0 && y < map_height_ && y >= 0)
  {
    Vec2d obsVct(xi.x() - worldMap_->voronoi_.GetClosetObstacleCoor(xi).x(),
                 xi.y() - worldMap_->voronoi_.GetClosetObstacleCoor(xi).y());
    //obsDst should be equal to the length of obsVct. However, their difference may be larger than 1m.
    //    std::cout << "(==) dis to closest obs = " << obsDst << ", Vector Mod = " << obsVct.length() << std::endl;
    // the closest obstacle is closer than desired correct the path for that
    // obsDMax = 2m
    if (obsDst < options_.obsDMax && obsDst > 1e-6)
    {
      gradient = options_.wObstacle * 2 * (obsDst - options_.obsDMax) * obsVct / obsDst;
    }
    // else if (obsDst < options_.vorObsDMax && obsDst > 1e-6)
    // {
    //   gradient = options_.wVoronoi * 2 * (obsDst - options_.vorObsDMax) * obsVct / obsDst;
      
    //   Vec2d xi_temp = xi-gradient;
    //   Vec2d obsVct_temp(xi.x() - worldMap_->voronoi_.GetClosetObstacleCoor(xi_temp).x(),
    //                     xi.y() - worldMap_->voronoi_.GetClosetObstacleCoor(xi_temp).y());

    //   Vec2d obsVct_sum = (obsVct + obsVct_temp)*0.5;
    //   gradient = -options_.wVoronoi * obsVct_sum;     

      // float obsDst_temp = worldMap_->voronoi_.getDistance(xi.x(), xi.y());
    // }
  }
  return gradient;
}

Vec2d Smoother::voronoiTerm(Vec2d xi)
{
  Vec2d gradient;

  float obsDst = worldMap_->voronoi_.getDistance(xi.x(), xi.y());
  Vec2d obsVct(xi.x() - worldMap_->voronoi_.GetClosetObstacleCoor(xi).x(),
               xi.y() - worldMap_->voronoi_.GetClosetObstacleCoor(xi).y());

  double edgDst = 0.0;
  Vec2i closest_edge_pt = worldMap_->voronoi_.GetClosestVoronoiEdgePoint(xi, edgDst);
  Vec2d edgVct(xi.x() - closest_edge_pt.x(), xi.y() - closest_edge_pt.y());

  if (obsDst < options_.vorObsDMax && obsDst > 1e-6)
  {
    if (edgDst > 0)
    {
      Vec2d PobsDst_Pxi = obsVct / obsDst;
      Vec2d PedgDst_Pxi = edgVct / edgDst;
      //      float PvorPtn_PedgDst = alpha * obsDst * std::pow(obsDst - vorObsDMax, 2) /
      //                              (std::pow(vorObsDMax, 2) * (obsDst + alpha) * std::pow(edgDst + obsDst, 2));
      float PvorPtn_PedgDst = (options_.alpha / (options_.alpha + obsDst)) *
                              (pow(obsDst - options_.vorObsDMax, 2) / pow(options_.vorObsDMax, 2)) * (obsDst / pow(obsDst + edgDst, 2));

      //      float PvorPtn_PobsDst = (alpha * edgDst * (obsDst - vorObsDMax) * ((edgDst + 2 * vorObsDMax + alpha)
      //                                                                         * obsDst + (vorObsDMax + 2 * alpha) * edgDst + alpha * vorObsDMax))
      //                              / (std::pow(vorObsDMax, 2) * std::pow(obsDst + alpha, 2) * std::pow(obsDst + edgDst, 2));
      float PvorPtn_PobsDst = (options_.alpha / (options_.alpha + obsDst)) *
                              (edgDst / (edgDst + obsDst)) * ((obsDst - options_.vorObsDMax) / pow(options_.vorObsDMax, 2)) * (-(obsDst - options_.vorObsDMax) / (options_.alpha + obsDst) - (obsDst - options_.vorObsDMax) / (obsDst + edgDst) + 2);
      gradient = options_.wVoronoi * (PvorPtn_PobsDst * PobsDst_Pxi + PvorPtn_PedgDst * PedgDst_Pxi) * 1000;
      // printf("voronoiTerm  obsDst:%f  edgDst:%f  gradient.x:%f  gradient.y:%f\n",obsDst,edgDst,gradient.x(),gradient.y());
      return gradient;
    }
    return gradient;
  }
  return gradient;
}

Vec2d Smoother::curvatureTerm(Vec2d xim1, Vec2d xi, Vec2d xip1)
{
  Vec2d gradient;
  // the vectors between the nodes
  Vec2d Dxi = xi - xim1;
  Vec2d Dxip1 = xip1 - xi;
  // orthogonal complements vector
  Vec2d p1, p2;

  float absDxi = Dxi.Length();
  float absDxip1 = Dxip1.Length();

  // ensure that the absolute values are not null
  if (absDxi > 0 && absDxip1 > 0)
  {
    float Dphi = std::acos(Clamp<float>(Dxi.InnerProd(Dxip1) / (absDxi * absDxip1), -1, 1));
    float kappa = Dphi / absDxi;

    if (kappa <= options_.kappaMax)
    {
      Vec2d zeros;
      //std::cout << "curvatureTerm is 0 because kappa(" << kappa << ") < kappamax(" << kappaMax_ << ")" << std::endl;
      return zeros;
    }
    else
    {
      //代入原文公式(2)与(3)之间的公式. 参考：
      // Dolgov D, Thrun S, Montemerlo M, et al. Practical search techniques in path planning for
      //  autonomous driving[J]. Ann Arbor, 2008, 1001(48105): 18-80.
      float absDxi1Inv = 1 / absDxi;
      float PDphi_PcosDphi = -1 / std::sqrt(1 - std::pow(std::cos(Dphi), 2));
      float u = -absDxi1Inv * PDphi_PcosDphi;
      p1 = xi.ort(-xip1) / (absDxi * absDxip1); //公式(4)
      p2 = -xip1.ort(xi) / (absDxi * absDxip1);
      float s = Dphi / (absDxi * absDxi);
      Vec2d ones(1, 1);
      Vec2d ki = u * (-p1 - p2) - (s * ones);
      Vec2d kim1 = u * p2 - (s * ones);
      Vec2d kip1 = u * p1;
      gradient = options_.wCurvature * (0.25 * kim1 + 0.5 * ki + 0.25 * kip1);

      if (std::isnan(gradient.x()) || std::isnan(gradient.y()))
      {
        //        std::cout << "nan values in curvature term" << std::endl;
        Vec2d zeros;
        //      std::cout << "curvatureTerm is 0 because gradient is non" << std::endl;
        return zeros;
      }
      else
      {
        //        std::cout << "curvatureTerm is (" << gradient.x() << ", " << gradient.y() << ")" << std::endl;
        return gradient;
      }
    }
  }
  else
  {
    std::cout << "abs values not larger than 0" << std::endl;
    std::cout << absDxi << absDxip1 << std::endl;
    Vec2d zeros;
    std::cout << "curvatureTerm is 0 because abs values not larger than 0" << std::endl;
    return zeros;
  }
}

Vec2d Smoother::smoothnessTerm(Vec2d xim, Vec2d xi, Vec2d xip)
{
  // according to paper "Practical search techniques in path planning for autonomous driving"
  Vec2d gradient;
  gradient = options_.wSmoothness * (-4) * (xip - 2 * xi + xim);
  float obsDst_before = worldMap_->voronoi_.getDistance(xi.x(), xi.y());
  float obsDst_after = worldMap_->voronoi_.getDistance(xi.x()-gradient.x(), xi.y()-gradient.y());

  if(obsDst_before<options_.obsDMax && (obsDst_after-obsDst_before)<0)
  {
    gradient.set_x(0.0);
    gradient.set_y(0.0);
  }
  return gradient;
}

Vec2d Smoother::smoothnessTerm(Vec2d xim2, Vec2d xim1, Vec2d xi, Vec2d xip1, Vec2d xip2)
{
  Vec2d gradient;

  
  gradient = options_.wSmoothness * (-4) * (xip1 - 2 * xi + xim1);
  float obsDst_before = worldMap_->voronoi_.getDistance(xi.x(), xi.y());
  float obsDst_after = worldMap_->voronoi_.getDistance(xi.x()-gradient.x(), xi.y()-gradient.y());

  if(obsDst_before<options_.obsDMax && (obsDst_after-obsDst_before)<0)
  {
    gradient.set_x(0.0);
    gradient.set_y(0.0);
    return gradient;
  }
  // return options_.wSmoothness * (xim2 - 4 * xim1 + 6 * xi - 4 * xip1 + xip2);
  return gradient;
}

bool Smoother::isOnGrid(Vec2d vec)
{
  if (vec.x() >= 0 && vec.x() < map_width_ &&
      vec.y() >= 0 && vec.y() < map_height_)
  {
    return true;
  }
  return false;
}
