#pragma once

#include <mpac_generic/functions.h>
#include <Eigen/Core>
#include <Eigen/LU>

namespace mpac_geometry {

  //! Translates / rotates all points in the container by pose.
  inline void movePoint2dContainer(mpac_generic::Point2dContainerInterface &pts, const mpac_generic::Pose2d &pose) {
    Eigen::Vector2d offset = mpac_generic::getPosition(pose);
    Eigen::Matrix2d rot;
    rot << cos(pose(2)), -sin(pose(2)), sin(pose(2)), cos(pose(2));
    for (size_t i = 0; i < pts.sizePoint2d(); i++) {
      Eigen::Vector2d new_p = rot * pts.getPoint2d(i) + offset;
      pts.setPoint2d(new_p, i);
    }
  }
    
  inline mpac_generic::Point2dVec getMovedPoint2dContainer(const mpac_generic::Point2dContainerInterface &pts, const mpac_generic::Pose2d &pose) {
    mpac_generic::Point2dVec ret(pts);
    movePoint2dContainer(ret, pose);
    return ret;
  }

  inline double getMinDistanceFromOrigin(const mpac_generic::Point2dContainerInterface &pts) {
    double d = std::numeric_limits<double>::max();
    for (size_t i = 0; i < pts.sizePoint2d(); i++) {
      const Eigen::Vector2d &v = pts.getPoint2d(i);
      if (v.dot(v) < d)
	d=v.dot(v);
    }
    return sqrt(d);
  }
  
  inline double getMaxDistanceFromOrigin(const mpac_generic::Point2dContainerInterface &pts) {
    double d = 0;
    for (size_t i = 0; i < pts.sizePoint2d(); i++) {
      const Eigen::Vector2d &v = pts.getPoint2d(i);
      if (v.dot(v) > d)
	d=v.dot(v);
    }
    return sqrt(d);
  }
  

  inline double distSqrPoint2d(const Eigen::Vector2d &v1, const Eigen::Vector2d &v2) {
    Eigen::Vector2d t = v1 - v2;
    return t.dot(t);
  }

  inline double minDistanceSqr(const mpac_generic::Point2dContainerInterface &pts) {
    
    size_t pts_size = pts.sizePoint2d();
    double min_dist = distSqrPoint2d(pts.getPoint2d(pts_size-1), pts.getPoint2d(0));
    for(size_t i=0; i<pts_size-1; i++) {
      double tmp = distSqrPoint2d(pts.getPoint2d(i), pts.getPoint2d(i+1));
      if (min_dist < tmp)
	tmp = min_dist;
    }
    return min_dist;
  }

  inline mpac_generic::Point2dVec getMinDistanceBetweenPoint2dVec(const mpac_generic::Point2dContainerInterface &pts, double minDist) {
    mpac_generic::Point2dVec ret;
    size_t pts_size = pts.sizePoint2d();
    if (pts_size < 1)
      return ret;
    double min_dist_sqr = minDist*minDist;
    ret.push_back(pts.getPoint2d(0));
    for(size_t i=1; i<pts_size-1; i++) {
      if (distSqrPoint2d(pts.getPoint2d(i), pts.getPoint2d(i+1)) > min_dist_sqr) {
	ret.push_back(pts.getPoint2d(i));
      }
    }
    if (distSqrPoint2d(pts.getPoint2d(pts_size-1), pts.getPoint2d(0)) > min_dist_sqr) {
      ret.push_back(pts.getPoint2d(pts_size-1));
    }
    return ret;
  }

  inline void calculateMatrixForm(const mpac_generic::Point2dContainerInterface &pts_, Eigen::MatrixXd &A, Eigen::VectorXd &b) {
    
    //every two adjacent points define a line -> inequality constraint
    // Need to have some distance between the points.
    const double min_dist = 0.001;
    mpac_generic::Point2dVec pts = mpac_geometry::getMinDistanceBetweenPoint2dVec(pts_, min_dist);

    size_t pts_size = pts.sizePoint2d();

    A = Eigen::MatrixXd (pts_size,2);
    b = Eigen::VectorXd (pts_size);
    
    if (pts_size < 2)
      return;

    if (minDistanceSqr(pts) < min_dist*min_dist)
      assert(false);
    
    Eigen::Vector2d normal;
    
    for(size_t i=1; i<pts_size; i++) {
      normal(0) = pts.getPoint2d(i-1)(1) - pts.getPoint2d(i)(1);
      normal(1) = pts.getPoint2d(i)(0) - pts.getPoint2d(i-1)(0);
      normal.normalize();
      b(i-1) = pts.getPoint2d(i).dot(normal);
      A(i-1,0) = normal(0);
      A(i-1,1) = normal(1);
    }
    // The turn over case
    normal(0) = pts.getPoint2d(pts_size-1)(1) - pts.getPoint2d(0)(1);
    normal(1) = pts.getPoint2d(0)(0) - pts.getPoint2d(pts_size-1)(0);
    normal.normalize();
    b(pts_size-1) = pts.getPoint2d(0).dot(normal);
    A(pts_size-1,0) = normal(0);
    A(pts_size-1,1) = normal(1);
  }

  inline Eigen::Vector2d getCenter(const mpac_generic::Point2dContainerInterface &pts) {
    size_t pts_size = pts.sizePoint2d();
    Eigen::Vector2d center(0.,0.);
    for (size_t i = 0; i < pts_size; i++) {
      center += pts.getPoint2d(i);
    }
    double factor = 1./(1.*pts_size);
    center *= factor;
    return center;
  }

  inline Eigen::Vector2d getIntersection(double A11, double A12, double A21, double A22, double b1, double b2)
  {
    Eigen::Matrix2d A;
    A << A11, A12, A21, A22;
    Eigen::Vector2d b(b1, b2);
    return A.inverse()*b;
  }

  //! Return a rectangle containing all polygon points.
  inline void getBoundingBox2d(const mpac_generic::Point2dContainerInterface &pts, Eigen::Vector2d &bottomLeft, Eigen::Vector2d &topRight) {
    size_t pts_size = pts.sizePoint2d();
    assert(pts_size != 0);
    bottomLeft = Eigen::Vector2d(std::numeric_limits<double>::max(), std::numeric_limits<double>::max());
    topRight = Eigen::Vector2d(-std::numeric_limits<double>::max(), -std::numeric_limits<double>::max());
    
    for (size_t i = 0; i < pts_size; i++) {
      if (pts.getPoint2d(i)(0) < bottomLeft(0)) { bottomLeft(0) = pts.getPoint2d(i)(0); }
      if (pts.getPoint2d(i)(1) < bottomLeft(1)) { bottomLeft(1) = pts.getPoint2d(i)(1); }
      if (pts.getPoint2d(i)(0) > topRight(0)) { topRight(0) = pts.getPoint2d(i)(0); }
      if (pts.getPoint2d(i)(1) > topRight(1)) { topRight(1) = pts.getPoint2d(i)(1); }
    }
  }

  // 获取直线参数
inline void getLinePara(Eigen::Vector2f &dir, mpac_generic::Point2f &p1, mpac_generic::LinePara &LP)
{
  
  if (0 == dir.x())
  {
    LP.k = 10000.0;
    LP.b = p1.y - LP.k * p1.x;
  }
  else
  {
    LP.k = dir.y() / dir.x();
    LP.b = p1.y - LP.k * p1.x;
  }
}

// 获取交点
inline bool getCross(Eigen::Vector2f &dir1, mpac_generic::Point2f &p1, Eigen::Vector2f &dir2, mpac_generic::Point2f &p2, mpac_generic::Point2f &pt)
{

  mpac_generic::LinePara para1, para2;
  getLinePara(dir1, p1, para1);
  getLinePara(dir2, p2, para2);

  // 判断是否平行
  if (fabs(para1.k - para2.k) > 0.000001)
  {
    pt.x = (para2.b - para1.b) / (para1.k - para2.k);
    pt.y = para1.k * pt.x + para1.b;

    return true;
  }
  else
  {
    return false;
  }
}
  
} // namespace 
