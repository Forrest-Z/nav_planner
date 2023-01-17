#pragma once

#include <mpac_generic/types.h>
#include <mpac_generic/path_utils.h>

namespace constraint_extract {

  class ConstraintPath : public mpac_generic::PathInterface  {
  public:
    ConstraintPath(const mpac_generic::PathInterface &p);
    //! Computes a sumbsampled path.
    const mpac_generic::Path& extractPath(double minDist, double maxDist, double maxRotation);
    const mpac_generic::Path& getOrigPath() const { return orig_path; }
    const std::vector<unsigned int> getSubsampledIdx() const { return subsampled_idx; }
    bool addStep(const mpac_generic::Pose2d &p1, const mpac_generic::Pose2d &p2, double maxDist, double maxRotation) const;

  private:
    mpac_generic::Path orig_path;
    mpac_generic::Path path;
    std::vector<unsigned int> subsampled_idx;
  };
  
} // namespace
