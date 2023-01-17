#include <mpac_geometry/pallet_model_2d.h>
#include <mpac_generic/path_utils.h>

using namespace mpac_geometry;

PalletModel2dWithState::PalletModel2dWithState(const PalletModel2dInterface &m) {
  
  const Polygon& poly = m.getBoundingRegion();
  posePolygon_orig = Polygon(poly); // Overwrite the poly with the current model configuration...
  pickupPoses_orig = m.getPickupPoses();
  pickupPosesClose_orig = m.getPickupPosesClose();
  pickupPoseOffset_orig = m.getPickupPoseOffset();
  
}

void
PalletModel2dWithState::update(const mpac_generic::Pose2d &p)
{
  posePolygon = posePolygon_orig;
  movePoint2dContainer(posePolygon, p); // ... and move it to the right pose.

  pickupPoses = pickupPoses_orig;
  mpac_generic::moveToOrigin(pickupPoses, p);

  pickupPosesClose = pickupPosesClose_orig;
  mpac_generic::moveToOrigin(pickupPosesClose, p);

  mpac_generic::Pose2d offset = pickupPoseOffset_orig;
  pickupPoseOffset = mpac_generic::addPose2d(p, offset);
}

