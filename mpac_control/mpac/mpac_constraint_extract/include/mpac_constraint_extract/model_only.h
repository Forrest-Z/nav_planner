#pragma once

#include <mpac_constraint_extract/constraints.h>
#include <mpac_generic/subsample_path.h>
#include <mpac_geometry/robot_model_2d.h>

namespace constraint_extract {


//! Provides a method to extract contraint only relying on the provided path and the model - ant NOT any map. The provided path is instead assumed to be collision free.
class ConstraintExtractorModelOnly : public ConstraintExtractorInterface {
 public:
  class Params {
  public:
    Params() { 
      minDist = 0.1; 
      maxDist = 0.2; 
      maxRotation = 0.7; 
      forceOuterConvex = false;
      forceConstraintsPerPathPoint = false; // Currently needed in the scheduling?
      innerOffset = mpac_generic::Pose2d(0.1, 0.1, 0.1);
      forceParkingPolygons = true;
    }

    double minDist;
    double maxDist;
    double maxRotation;
    bool forceOuterConvex;
    bool forceConstraintsPerPathPoint;
    mpac_generic::Pose2d innerOffset;
    bool forceParkingPolygons;
  };

  ConstraintExtractorModelOnly(const mpac_generic::PathInterface &p, const mpac_geometry::RobotModel2dInterface &m, mpac_generic::RobotInternalState2d::LoadType loadType);
  
  void compute();

  const std::vector<size_t>& getSubSampledIdx() const;
  const mpac_geometry::Polygons& getOuterConstraints() const;
  const mpac_geometry::Polygons& getInnerConstraints() const;
  
  Params params;
  mpac_geometry::Polygons outerConstraints;
  mpac_geometry::Polygons innerConstraints;
  std::vector<size_t> sub_idx;
  
  const mpac_generic::PathInterface &path;
  const mpac_geometry::RobotModel2dInterface &model;
  
  private:
  mpac_geometry::Polygons upSample(const mpac_geometry::Polygons &polygons, const std::vector<size_t>& subsample_idx);
  
  bool computed_;
  mpac_generic::RobotInternalState2d::LoadType loadType_;
};
  
} // namespace
