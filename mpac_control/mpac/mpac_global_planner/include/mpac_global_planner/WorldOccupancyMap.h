/**
 * @file WorldOccupancyMap.h
 * @author Marcello Cirillo
 *
 *  Created on: Apr 6, 2011
 *      Author: marcello
 */

#ifndef WORLDOCCUPANCYMAP_H_
#define WORLDOCCUPANCYMAP_H_

#include <fstream>
#include <string>
#include <boost/regex.hpp>
#include <stdlib.h>
#include <algorithm>
#include <iostream>
#include <math.h>

#include "mpac_global_planner/Utils.h"
#include "mpac_global_planner/WorldParameters.h"
#include "mpac_global_planner/dynamic_voronoi.h"
#include "mpac_generic/types.h"

#include "mpac_geometry/polygon.h"

/**
 * @class WorldOccupancyMap
 * This class loads the occupancy map of the world from a file
 * and stores both data and metadata (e.g.: map resolution) in
 * a WorldOccupancyMap object
 */
class WorldOccupancyMap
{

	/** The number of cells on the X axis of the map */
	int xcells_;
	/** The number of cells on the Y axis of the map */
	int ycells_;

	/** The number of cells on the X axis of the original map */
	int originalxcells_;
	/** The number of cells on the Y axis of the original map */
	int originalycells_;

	/** Granularity of the occupancy map: meters per cell */
	double granularity_;
	/** Granularity of the original occupancy map: meters per cell */
	double originalGranularity_;

	/** Flag that indicates if the map contains obstacles or not */
	bool containsObstacles_;

	double originX_;
	double originY_;
	double originYaw_;

	double originX_local_;
	double originY_local_;

    int originX_local_cell_;
	int originY_local_cell_;	


	/** The occupancy map, whose granularity may change */
	std::vector<std::vector<double>> occupancyMap_;
	/** Same size of the occupancyMap_, keeps track of the obstacles for restoring the
	 * original values to the cells when needed */
	std::vector<std::vector<double>> originalObstacles_;
	/** The original occupancy map, as loaded from file */
	std::vector<std::vector<double>> originalOccupancyMap_;

	/**
	 * Private method to split a single line of the file into a vector of doubles
	 * @param s The line of the file
	 * @param f The value separator
	 * @return A vector of double representing a line in the map
	 */
	std::vector<double> splitMapLine(const std::string &s, const std::string &f);

	/**
	 * Decrease the Map granularity
	 * @param times Final granularity = granularity / times
	 */
	void decreaseGranularity(int times);

	/**
	 * Increase the Map granularity
	 * @param times Final granularity = granularity * times
	 */
	void increaseGranularity(int times);

public:
	/**
	 * Constructor. Load the map from a file
	 * @param filename The name of the file to load
	 */
	WorldOccupancyMap(std::string filename);

	/**
	 * Constructor. Creates an empty map given the number of x and y cells and the granularity
	 * @param xcells The number of cells on the x axis
	 * @param ycells The number of cells on the y axis
	 * @param mapGranularity The granularity of the map (meters per cell)
	 */
	WorldOccupancyMap(unsigned short int xcells, unsigned short int ycells, double mapGranularity);

	WorldOccupancyMap() {}

	void initProhibitedMap(uint8_t value);
	void initDirectionMap(uint8_t value);
	void initSpeedMap(uint8_t value);
	void initNoCrossingMap(uint8_t value);
	void initDynamicPoints(uint8_t value);
	void initChannelMap(uint8_t value);

	void updateProhibitedMap(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateDirectionMap(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateSpeedMap(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateNoCrossingMap(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateDynamicPoints(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateChannelMap(std::vector<cellPosition> &obstacles, uint8_t value);
	void updateLocalMap(mpac_generic::Point2dVec obstacles,mpac_generic::Pose2d locallPose);



	int getDirectionValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	int getProhibitedValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	int getSpeedValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	int getNoCrossingValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	int getChannelValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	double getOccupancyValueInCell(unsigned short int x_cell, unsigned short int y_cell);
	double getShortestDistanceFromObstacles(unsigned short int x_cell, unsigned short int y_cell);
	double getShortestDistanceFromObstacles(mpac_generic::Pose2d pose);

	//将禁行区和静态地图进行合并
	void mapMerge();

	virtual ~WorldOccupancyMap();

	/**
	 * Return the x size of the map, in meters
	 * @returns The x size (meters)
	 */
	double getXSize();

	/**
	 * Return the y size of the map, in meters
	 * @returns The y size (meters)
	 */
	double getYSize();

	/**
	 * Returns the number of cells on the x axis of the map
	 * @return The number of cells on the x axis of the map
	 */
	unsigned short int getXCells();

	/**
	 * Returns the number of cells on the y axis of the map
	 * @return The number of cells on the y axis of the map
	 */
	unsigned short int getYCells();

	/**
	 * Return the granularity of the occupancy map, in meters per cell
	 * @returns The granularity of the occupancy map
	 */
	double getGranularity();

	/**
	 * Change the granularity of the Map.
	 * NOTE: if newGran < currentGranularity, the final granularity will be
	 * <= newGran (newGran will be an upper bound)
	 * if newGran > currentGranularity, the final resolution will be
	 * >= newGran (newGran will be a lower bound)
	 * @param newGran The new granularity, in meters per cell
	 */
	void scaleGranularity(double newGran);

	/**
	 * Return the occupancy map
	 * @returns The occupancy map of the World
	 */
	std::vector<std::vector<double>> getMap();

	/**
	 * Restore the original occupancy map, as loaded from file
	 */
	void restoreOriginalMap();

	/**
	 * Set the occupancy map as a portion of the current one
	 * @param xfrom,yfrom Coordinates (in meters) of the point of the current
	 * occupancy map that will become the left lower corner of the submap
	 * @param xto, yto Coordinates (in meters) of the point of the current
	 * occupancy map that will become the top right corner of the submap
	 */
	void selectSubMap(double xfrom, double yfrom, double xto, double yto);



	/**
	 * Add the cells in the vector as obstacles in the occupancy map
	 * @param obstacles The vector of cells to be added as obstacles to the map
	 */
	void addObstacles(std::vector<cellPosition> obstacles);
	void addObstacles(mpac_generic::Point2dVec obstacles);
	/**
	 * 更新栅格的值
	 * type = 0 更新静态地图
	 * type = 1 更新禁行区
	 * type = 2 更新单行区
	 * type = 3 更新限速区
	 */
	void updateValue(std::vector<cellPosition> &obstacles, uint8_t value, mpac_generic::VectorMapType type);

	/**
	 * Restores the cells passed as arguments as they were in the occupancy map
	 * @param freecells The vector of cells to be restored
	 */
	void removeObstacles(std::vector<cellPosition> freecells);
	void removeObstacles(mpac_generic::Point2dVec freecells);

	/**
	 * Check if the WorldOccupancyMap contains obstacles (e.g., it has been created by a map
	 * @return True if the map contains obstacles
	 */
	bool containsObstacles();

	/**
	 * Initialize the map. Note this will assign both the map and the original map.
	 */
	void initialize(int xcells, int ycells, double granularity, const std::vector<std::vector<double>> &occupancyMap);

	void setOrigin(double x, double y, double yaw);

	void getOrigin(double &x, double &y, double &yaw);

	void map2world(int mx, int my, double &wx, double &wy);

	void world2map(double wx, double wy, int &mx, int &my);

	bool onGrid(int x, int y);

	std::vector<std::vector<uint8_t>> prohibitedMap_; //禁行区
	std::vector<std::vector<uint8_t>> directionMap_;  //单行区
	std::vector<std::vector<uint8_t>> speedMap_;	  //限速区
	std::vector<std::vector<uint8_t>> noCrossingMap_;  //限速区
	std::vector<std::vector<uint8_t>> channelMap_;  //窄通道区
	std::vector<std::vector<int>> localMap_; //局部地图

	mpac_generic::Point2dVec dynamicPoints_; //动态点云

	DynamicVoronoi voronoi_;
	DynamicVoronoi voronoi_local_;

	std::vector<Vec2i> dynamicObstacles;
};

#endif /* WORLDOCCUPANCYMAP_H_ */
