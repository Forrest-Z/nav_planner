#pragma once

#include <mpac_generic/interfaces.h>
#include <mpac_generic/path_utils.h>
#include <mpac_geometry/geometry.h>
#include <ros/ros.h>
#include "spline2d.h"
#include "sl.h"
#include <map>

#include <mpac_global_planner/WorldOccupancyMap.h>
#include <mpac_global_planner/CollisionDetector.h>
#include "controlParameters.h"

enum sampleMode
{
    CRUISING = 0,
    STOPPING
};

class LatticePlanner
{


public:

    LatticePlanner(std::shared_ptr<WorldOccupancyMap> local_map);
    ~LatticePlanner();

    /**
     * @brief Set global reference route
     * 
     * @param path 
     * @return true 
     * @return false 
     */
    bool setRefLine(mpac_generic::Path path);

    /**
     * @brief Get the Local Trajecoty object
     * 
     * @param current_state Current vehicle state,incluing pose and velocity
     * @param traj the best passable trajectory
     * @param mode sample mode: CRUISING or STOPPING
     * @return true 
     * @return false 
     */
    bool getLocalTrajecoty(mpac_generic::State2dControl current_state, mpac_generic::Trajectory& traj,sampleMode mode);
    
    /**
     * @brief Find the path point closest to the current position in the reference path
     * 
     * @param current_pose 
     * @return mpac_generic::Pose2d closest way point
     */
    mpac_generic::Pose2d getRefPoint(mpac_generic::Pose2d current_pose);

    /**
     * @brief Get the remaining distance from current state to goal point
     * 
     * @param current_state 
     * @return double 
     */
    double getResidualDistance(mpac_generic::State2dControl current_state);

    

private:
    
    /**
	 * Sample candidate stop paths
	 * @param  current_state Current status of vehicle，including pose and velocity 
     * @param  out  candidate cruise paths
	 */
    std::vector<SLPath> samplePathsForStopping(mpac_generic::State2dControl current_state); //停止

    /**
	 * Sample candidate cruise paths
	 * @param  current_state Current status of vehicle，including pose and velocity 
     * @param  out  candidate cruise paths
	 */
    std::vector<SLPath> samplePathsForCruising(mpac_generic::State2dControl current_state); //正常寻迹
    
    /**
     * @brief Coordinate transformation: from Frenet to Cartesian coordinates
     * 
     * @param sl_state Vehicle state in Frenet Coordinates
     * @return mpac_generic::State2dControl Vehicle state in Cartesian coordinates
     */
    mpac_generic::State2dControl SL2XY(SLPose sl_state);

    /**
     * @brief Coordinate transformation: from Cartesian to Frenet coordinates
     * 
     * @param currrent_state  Vehicle state in Cartesian coordinates
     * @return SLPose Vehicle state in Frenet Coordinates
     */
    SLPose XY2SL(mpac_generic::State2dControl currrent_state);
 
    /**
     * @brief Judge whether the path is passable
     * 
     * @param path way points in Frenet coordinates
     * @return true if the path is pass free
     * @return false if the path is at risk of collision
     */
    bool travelFree(SLPath& path);


    void calcYawCurvDs(std::vector<double>& x,std::vector<double>& y,std::vector<double>& yaw,std::vector<double>& curv,std::vector<double>& ds);

    mpac_generic::Path origin_path;
    Spline2d spline_;
    double last_ref_point_; //记录上一时刻参考点，用于快速确定当前时刻参考点
    mpac_generic::State2dControl last_state;

    std::shared_ptr<WorldOccupancyMap> local_map_;
    CollisionDetector* cd_;


    bool forward_;

};
