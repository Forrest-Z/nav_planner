#pragma once

#include <mpac_geometry/geometry.h>

namespace mpac_geometry
{

  class Polygon : public mpac_generic::Point2dContainerInterface, mpac_generic::Point2dCollisionCheckInterface
  {
  public:
    Polygon();
    Polygon(const Point2dContainerInterface &pts);
    Polygon(const Point2dContainerInterface &pts, double safeDis);

    // Interfaces
    virtual void setPoint2d(const Eigen::Vector2d &pt, size_t idx) { points.setPoint2d(pt, idx); }
    virtual Eigen::Vector2d getPoint2d(size_t idx) const { return points.getPoint2d(idx); }
    virtual size_t sizePoint2d() const { return points.sizePoint2d(); }
    virtual bool collisionPoint2d(const Eigen::Vector2d &pos) const;

    bool addPolygon(const Polygon &p);
    void convexHull();
    double getArea() const;
    void getMatrixForm(Eigen::MatrixXd &A, Eigen::VectorXd &b) const;
    void getMatrixFormAsVectors(std::vector<double> &A0,
                                std::vector<double> &A1,
                                std::vector<double> &b) const;

    // Returns true if the provided polygon fully intersect with this polygon.
    bool intersection(const mpac_geometry::Polygon &p) const;

    bool isWithinPolygon(const mpac_generic::Pose2d &pose);

    Eigen::Vector2d getCenter() const;

    void clear();

    Polygon getMovedPolygon(const mpac_generic::Pose2d &pose) const
    {
      return Polygon(getMovedPoint2dContainer(*this, pose));
    }

    mpac_generic::Point2dVec discretizePolygon(double resolution, bool fill);
    mpac_generic::Point2dVec expandPolygon(mpac_generic::Point2dVec pList, float safeDis);

    mpac_generic::Point2dVec points;
    /* private: */
    /*   friend class boost::serialization::access; */

    /*   template<typename Archive> */
    /*     void serialize(Archive& ar, const unsigned version) { */
    /*     ar & this->points; */
    /*   } */
  };

  typedef std::vector<Polygon, Eigen::aligned_allocator<Polygon> > Polygons;

  inline Polygon getPolygonFromBox(const Eigen::Vector2d &topLeft, const Eigen::Vector2d &bottomRight)
  {
    mpac_generic::Point2dVec pts;

    pts.push_back(topLeft);
    pts.push_back(Eigen::Vector2d(bottomRight(0), topLeft(1)));
    pts.push_back(bottomRight);
    pts.push_back(Eigen::Vector2d(topLeft(0), bottomRight(1)));
    return Polygon(pts);
  }

} // namespace
