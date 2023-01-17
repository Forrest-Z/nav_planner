#include <mpac_geometry/polygon.h>
#include <mpac_geometry/mpac_boost_geometry.h>
#include <mpac_generic/types.h>
#include <mpac_geometry/line.h>
#include <spdlog/logger.h>
using namespace mpac_geometry;

Polygon::Polygon()
{
}

Polygon::Polygon(const Point2dContainerInterface &pts) : points(pts)
{
}

Polygon::Polygon(const Point2dContainerInterface &pts, double safeDis)
{
  mpac_generic::Point2dVec pts_expanded;
  pts_expanded = expandPolygon(pts, safeDis);

  this->points = pts_expanded;
}

bool Polygon::collisionPoint2d(const Eigen::Vector2d &pos) const
{

  polygon poly = getBoostPolygon(this->points);

  return boost::geometry::within(boost::geometry::make<point>(pos(0), pos(1)), poly);
}

bool Polygon::addPolygon(const Polygon &p)
{
  // If the "this" polygon is empty, simpy copy the provided polygon directly
  if (this->points.size() == 0)
  {
    this->points = p.points;
    return true;
  }

  if (p.points.size() == 0)
  {
    return false;
  }

  // Computes the union. Note that the polygons have to overlap in order to add them.
  polygon p1 = getBoostPolygon(this->points);
  polygon p2 = getBoostPolygon(p);

  if (boost::geometry::disjoint(p1, p2))
    return false;

  // The union will return all intersecting polygons. Here we assume that the one we're intressted in is the larges one. - TODO check this.
  std::vector<polygon> polys;

  try
  { // Since we know that the sets is not disjoint this union call should really work but sometimes doesn't... (a 'Boost.Geometry Overlay invalid input exception' is thrown)
    boost::geometry::union_(p1, p2, polys);
  }
  catch (...)
  {
    return false;
  }

  double area = -1.;
  for (std::vector<polygon>::size_type i = 0; i < polys.size(); ++i)
  {
    boost::geometry::correct(polys[i]);
    double tmp = boost::geometry::area(polys[i]);
    if (area < tmp)
    {
      area = tmp;
      this->points = getPoint2dVec(polys[i]);
    }
  }
  return true;
}

void Polygon::convexHull()
{
  polygon poly = getBoostPolygon(this->points);
  polygon hull;
  boost::geometry::convex_hull(poly, hull);
  this->points = getPoint2dVec(hull);
}

double
Polygon::getArea() const
{
  polygon poly = getBoostPolygon(this->points);
  return boost::geometry::area(poly);
}

void Polygon::getMatrixForm(Eigen::MatrixXd &A, Eigen::VectorXd &b) const
{
  calculateMatrixForm(*this, A, b);
}

void Polygon::getMatrixFormAsVectors(std::vector<double> &A0, std::vector<double> &A1, std::vector<double> &b) const
{
  Eigen::MatrixXd A_;
  Eigen::VectorXd b_;
  this->getMatrixForm(A_, b_);

  double *dt;
  dt = A_.col(0).data();
  A0 = std::vector<double>(dt, dt + A_.rows());
  dt = A_.col(1).data();
  A1 = std::vector<double>(dt, dt + A_.rows());
  dt = b_.data();
  b = std::vector<double>(dt, dt + b_.rows());
}

bool Polygon::intersection(const Polygon &p) const
{
  polygon poly = getBoostPolygon(this->points);
  polygon poly2 = getBoostPolygon(p.points);

  return boost::geometry::within(poly, poly2);
}

bool Polygon::isWithinPolygon(const mpac_generic::Pose2d &pose)
{
  int polySizes = points.size();
  int i;
  int j = polySizes - 1;

  bool oddNodes = false;
  for (size_t i = 0; i < polySizes; i++)
  {
    std::cout << " " << points[i].x() << " " << points[i].y() << std::endl;
  }
  for (size_t i = 0; i < polySizes; i++)
  {
    if ((points[i].y() < pose.y() && points[j].y() >= pose.y() || points[j].y() < pose.y() && points[i].y() >= pose.y()) && (points[i].x() <= pose.x() || points[j].x() <= pose.x()))
    {
      oddNodes ^= (points[i].x() + (pose.y() - points[i].y()) / (points[j].y() - points[i].y()) * (points[j].x() - points[i].x()) < pose.x());
    }
    j = i;
  }

  return oddNodes;
}

void Polygon::clear()
{
  points.clear();
}

mpac_generic::Point2dVec Polygon::discretizePolygon(double resolution, bool fill)
{

  mpac_generic::Point2dVec fill_points;
  std::vector<mpac_generic::Grid> polygon_grids;

  int mx0, my0, mx1, my1;
  for (size_t i = 0; i < this->points.size(); i++)
  {
    mx0 = static_cast<int>(points[i](0) / resolution + 0.5);
    my0 = static_cast<int>(points[i](1) / resolution + 0.5);
    int index = (i + 1) % this->points.size();
    mx1 = static_cast<int>(points[index](0) / resolution + 0.5);
    my1 = static_cast<int>(points[index](1) / resolution + 0.5);
    getLineGrids(mx0, my0, mx1, my1, polygon_grids);

    // fill_points.push_back(points[i]);
  }

  if (fill)
  {

    std::sort(polygon_grids.begin(), polygon_grids.end(), [](mpac_generic::Grid a, mpac_generic::Grid b)
              { return a.x < b.x; });

    int min_y, max_y;
    int min_x = polygon_grids.front().x;
    int max_x = polygon_grids.back().x;

    size_t i = 0;
    for (int x = min_x; x <= max_x && i < polygon_grids.size(); x++)
    {
      min_y = max_y = polygon_grids[i++].y;

      while (i < polygon_grids.size() && polygon_grids[i].x == x)
      {
        if (polygon_grids[i].y < min_y)
        {
          min_y = polygon_grids[i].y;
        }
        else if (polygon_grids[i].y > max_y)
        {
          max_y = polygon_grids[i].y;
        }
        i++;
      }

      for (int y = min_y + 1; y < max_y; y++)
      {
        // printf("(%d,%d) ",x,y);
        Eigen::Vector2d point(x * resolution, y * resolution);

        fill_points.push_back(point);
      }
    }

    return fill_points;
  }

  for (size_t i = 0; i < polygon_grids.size(); i++)
  {
    Eigen::Vector2d point;

    point(0) = polygon_grids[i].x * resolution;
    point(1) = polygon_grids[i].y * resolution;

    fill_points.push_back(point);
  }

  return fill_points;
}

mpac_generic::Point2dVec Polygon::expandPolygon(mpac_generic::Point2dVec pList, float safeDis)
{ // already ordered by anticlockwise
  // clockwiseSortPoints(pList);
  // if (polygonArea(pList) < 0) {
  //   std::reverse(pList.begin(), pList.end());
  // }
  // pList.pop_back();
  // // 1. vertex set
  // // pList

  // 2. edge set and normalize it

  //judge the direction of points
  mpac_generic::Point2dVec tmp_points;
  tmp_points = pList;
  tmp_points.push_back(pList.front());
  double area = 0.0;
  for (size_t i = 0; i < pList.size(); i++)
  {
    area = (tmp_points[i].x() + tmp_points[i + 1].x()) * (tmp_points[i + 1].y() - tmp_points[i].y()) + area;
  }
  if (area < 0.0)
  {
    safeDis = -safeDis;
  }

  mpac_generic::Point2dVec out;
  mpac_generic::Point2dVec dpList, ndpList;
  int count = pList.size();
  for (int i = 0; i < count; i++)
  {
    int next = (i == (count - 1) ? 0 : (i + 1));
    dpList.push_back(pList[next] - pList[i]);
    float unitLen = 1.0f / sqrt(dpList[i].dot(dpList[i]));
    ndpList.push_back(dpList[i] * unitLen);
    // spdlog::info("i={},pList:{},{},dpList:{},ndpList:{}", i, pList.at(next), pList.at(i), dpList.at(i), ndpList.at(i));
  }

  // 3. compute Line
  //负数为内缩， 正数为外扩。 需要注意算法本身并没有检测内缩多少后折线会自相交，那不是本代码的示范意图
  for (int i = 0; i < count; i++)
  {
    int startIndex = (i == 0 ? (count - 1) : (i - 1));
    int endIndex = i;
    float sinTheta = ndpList[startIndex].x() * ndpList[endIndex].y() - ndpList[startIndex].y() * ndpList[endIndex].x();

    Eigen::Vector2d orientVector = ndpList[endIndex] - ndpList[startIndex]; //i.e. PV2-V1P=PV2+PV1
    Eigen::Vector2d temp_out;
    temp_out.x() = pList[i].x() - safeDis / sinTheta * orientVector.x();
    temp_out.y() = pList[i].y() - safeDis / sinTheta * orientVector.y();
    out.push_back(temp_out);
  }
  return out;
}
