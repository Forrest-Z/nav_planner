#pragma once

#include <mpac_msgs/RobotTarget.h>
#include <mpac_msgs/Path.h>
#include <mpac_geometry/geometry.h>
#include <mpac_geometry/pallet_model_2d.h>


// TODO fix this
inline mpac_geometry::PalletModel2dWithState getPalletModelFromRobotTarget(const mpac_msgs::RobotTarget &msg, bool start = false) {
    // Get the type of load - todo a factory - need to add some cleaning 
    mpac_geometry::PalletModel2dInterface* model = 0x0;
    mpac_geometry::PalletModel2dEUR EUR;
    mpac_geometry::PalletModel2dHalf half;
    unsigned int load = msg.goal_load.status;
    if (start)
      load = msg.current_load.status;
    switch (load) {
    case 1:
        model = &EUR;
        break;
    case 2:
        model = &half;
        break;
    default:
        ROS_WARN("Don't know what to LOAD/UNLOAD - will assume a EUR pallet for now.");
        model = &EUR;
        break;
    }
    
    mpac_geometry::PalletModel2dWithState pm(*model);
    
    // Move the load to the specified pick up location...
    if (start)
        pm.update(mpac_conversions::createPose2dFromMsg(msg.start.pose));
    else
        pm.update(mpac_conversions::createPose2dFromMsg(msg.goal.pose));
    return pm;
}
