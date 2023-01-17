/**
 * @file WorldOccupancyMap.cpp
 * @author Marcello Cirillo
 *
 *  Created on: Apr 6, 2011
 *      Author: marcello
 */

#include "mpac_global_planner/WorldOccupancyMap.h"
#include "mpac_generic/timer.h"
#include <spdlog/spdlog.h>

WorldOccupancyMap::WorldOccupancyMap(std::string filename)
{

	std::string log = std::string("Loading Map from file ");
	if (WP::LOG_LEVEL >= 1)
	{
		log.append(filename);
		writeLogLine(log, "WorldOccupancyMap", WP::LOG_FILE);
	}

	std::string line;
	std::ifstream map(filename.c_str(), std::ifstream::in);
	static const boost::regex header("^# (\\w+)\\s(.*)$");
	// static const boost::regex data("^(\\d(.+?)\\s)+$");
	static const boost::regex data("^\\d(.+)$");
	boost::smatch what;

	// init all the private variables
	xcells_ = 0;
	ycells_ = 0;
	originalxcells_ = 0;
	originalycells_ = 0;
	originalOccupancyMap_.clear();

	// two copies of the map are loaded: one copy (originalOccupancyMap)
	// will not change through the lifetime of the object, while
	// the other (occupancyMap) can be modified
	if (map.is_open())
	{
		while (map.good())
		{
			getline(map, line);

			boost::regex_match(line, what, header, boost::match_extra);
			if (what[0].matched)
			{
				if (what[1].str().compare("GRID_SIZE") == 0)
				{
					granularity_ = atof(what[2].str().c_str());
					originalGranularity_ = granularity_;
				}
				if (what[1].str().compare("WIDTH") == 0)
				{
					xcells_ = atoi(what[2].str().c_str());
				}
				if (what[1].str().compare("HEIGHT") == 0)
				{
					ycells_ = atoi(what[2].str().c_str());
				}
			}
			// data line
			boost::regex_match(line, what, data, boost::match_extra);
			if (what[0].matched)
			{
				std::vector<double> x_line = splitMapLine(line, " ");
				occupancyMap_.push_back(x_line);
			}
		}
		map.close();
		// invert the y axis
		reverse(occupancyMap_.begin(), occupancyMap_.end());
	}
	else
	{
		if (WP::LOG_LEVEL >= 1)
		{
			log = std::string("Unable to open file!");
			writeLogLine(log, "WorldOccupancyMap", WP::LOG_FILE);
		}
	}
	if (xcells_ == 0 || ycells_ == 0)
	{
		if (WP::LOG_LEVEL >= 1)
		{
			log = std::string("Missing information from file!");
			writeLogLine(log, "WorldOccupancyMap", WP::LOG_FILE);
		}
	}
	// fill in the originalObstacles_ map
	originalObstacles_.resize(ycells_);
	for (unsigned int y = 0; y < originalObstacles_.size(); y++)
	{
		originalObstacles_[y].resize(xcells_);
		for (unsigned int x = 0; x < originalObstacles_[y].size(); x++)
		{
			originalObstacles_[y][x] = occupancyMap_[y][x];
		}
	}
	// the map contains obstacles
	containsObstacles_ = true;
}

WorldOccupancyMap::WorldOccupancyMap(unsigned short int xcells, unsigned short int ycells, double mapGranularity)
{

	// init all the private variables
	xcells_ = xcells;
	ycells_ = ycells;
	originalxcells_ = 0;
	originalycells_ = 0;
	originalOccupancyMap_.clear();
	originalGranularity_ = mapGranularity;
	granularity_ = mapGranularity;

	// fill in the originalObstacles_ map and the occupancyMap_
	occupancyMap_.resize(ycells_);
	originalObstacles_.resize(ycells_);
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].resize(xcells_);
		originalObstacles_[y].resize(xcells_);
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			occupancyMap_[y][x] = 0;
			originalObstacles_[y][x] = 0;
		}
	}

	// the map does not contain obstacles
	containsObstacles_ = false;
}

WorldOccupancyMap::~WorldOccupancyMap()
{
}

double WorldOccupancyMap::getXSize()
{
	return xcells_ * granularity_;
}

double WorldOccupancyMap::getYSize()
{
	return ycells_ * granularity_;
}

unsigned short int WorldOccupancyMap::getXCells()
{
	return xcells_;
}

unsigned short int WorldOccupancyMap::getYCells()
{
	return ycells_;
}

double WorldOccupancyMap::getGranularity()
{
	return granularity_;
}

std::vector<double> WorldOccupancyMap::splitMapLine(const std::string &s, const std::string &f)
{
	std::vector<double> temp;
	if (f.empty())
	{
		temp.push_back(atof(s.c_str()));
		return temp;
	}
	typedef std::string::const_iterator iter;
	const iter::difference_type f_size(distance(f.begin(), f.end()));
	iter i(s.begin());
	int count = 0;
	for (iter pos; (pos = search(i, s.end(), f.begin(), f.end())) != s.end();)
	{
		temp.push_back(atof(std::string(i, pos).c_str()));
		advance(pos, f_size);
		i = pos;
		count++;
	}
	return temp;
}

void WorldOccupancyMap::scaleGranularity(double newGran)
{

	// save the original map, if not already done
	if (originalOccupancyMap_.size() == 0)
	{
		originalOccupancyMap_.resize(occupancyMap_.size());
		for (unsigned int y = 0; y < occupancyMap_.size(); y++)
		{
			originalOccupancyMap_[y].resize(occupancyMap_[y].size());
			for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
			{
				originalOccupancyMap_[y][x] = occupancyMap_[y][x];
			}
		}
		originalxcells_ = xcells_;
		originalycells_ = ycells_;
	}

	double initialGran = granularity_;
	if (fabs(initialGran - newGran) <= WP::CALCULATION_APPROXIMATION_ERROR)
	{
		return;
	}
	if (initialGran > newGran)
	{
		this->decreaseGranularity(ceil(initialGran / newGran));
	}
	else
	{
		this->increaseGranularity(ceil(newGran / initialGran));
	}

	// clear the current originalObstacles_ map and resize it
	for (unsigned int y = 0; y < originalObstacles_.size(); y++)
	{
		originalObstacles_[y].clear();
	}
	originalObstacles_.clear();
	// fill in the originalObstacles_ map
	originalObstacles_.resize(ycells_);
	for (unsigned int y = 0; y < originalObstacles_.size(); y++)
	{
		originalObstacles_[y].resize(xcells_);
		for (unsigned int x = 0; x < originalObstacles_[y].size(); x++)
		{
			originalObstacles_[y][x] = occupancyMap_[y][x];
		}
	}
}

void WorldOccupancyMap::decreaseGranularity(int times)
{
	// copy the current granularity map to a temporary one
	std::vector<std::vector<double>> temp;
	temp.resize(occupancyMap_.size());
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		temp[y].resize(occupancyMap_[y].size());
	}
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			temp[y][x] = occupancyMap_[y][x];
		}
	}
	// clear the current occupancy map and resize it
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].clear();
	}
	occupancyMap_.clear();
	occupancyMap_.resize(temp.size() * times);
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].resize(temp[0].size() * times);
	}
	// fill the values using the originalOccupancyMap
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			occupancyMap_[y][x] = temp[y / times][x / times];
		}
	}
	// update resolution and number of cells
	ycells_ = occupancyMap_.size();
	xcells_ = occupancyMap_[0].size();
	granularity_ = granularity_ / times;
}

void WorldOccupancyMap::increaseGranularity(int times)
{
	// copy the current granularity map to a temporary one
	std::vector<std::vector<double>> temp;
	temp.resize(occupancyMap_.size());
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		temp[y].resize(occupancyMap_[y].size());
	}
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			temp[y][x] = occupancyMap_[y][x];
		}
	}
	// clear the current occupancy map and resize it (twice the size)
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].clear();
	}
	occupancyMap_.clear();
	// we may have to approximate the new size
	occupancyMap_.resize(temp.size() / times);
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].resize(temp[0].size() / times);
	}
	// fill the values using the originalOccupancyMap
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			double val = 0;
			for (unsigned int yo = y * times; yo < y * times + times; yo++)
			{
				for (unsigned int xo = x * times; xo < x * times + times; xo++)
				{
					if (yo < temp.size() && xo < temp[yo].size())
					{
						val = val > temp[yo][xo] ? val : temp[yo][xo];
					}
				}
			}
			// put the highest value of the corresponding cells in the original
			// occupancy map
			occupancyMap_[y][x] = val;
		}
	}
	// update the resolution
	granularity_ = granularity_ * times;
	xcells_ = occupancyMap_[0].size();
	ycells_ = occupancyMap_.size();
}

std::vector<std::vector<double>> WorldOccupancyMap::getMap()
{
	return occupancyMap_;
}

void WorldOccupancyMap::restoreOriginalMap()
{
	// clear the current occupancy map and resize it, but only if there is an original map
	if (originalOccupancyMap_.size() > 0)
	{
		for (unsigned int y = 0; y < occupancyMap_.size(); y++)
		{
			occupancyMap_[y].clear();
		}
		// resize the occupancyMap_ and fill the values using the originalOccupancyMap_
		occupancyMap_.clear();
		occupancyMap_.resize(originalOccupancyMap_.size());
		for (unsigned int y = 0; y < occupancyMap_.size(); y++)
		{
			occupancyMap_[y].resize(originalOccupancyMap_[0].size());
			for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
			{
				occupancyMap_[y][x] = originalOccupancyMap_[y][x];
			}
		}
		// update the resolution -- no need to change the xSize and ySize
		granularity_ = originalGranularity_;
		xcells_ = originalxcells_;
		ycells_ = originalycells_;

		// clear the current originalObstacles_ map and resize it
		for (unsigned int y = 0; y < originalObstacles_.size(); y++)
		{
			originalObstacles_[y].clear();
		}
		originalObstacles_.clear();
		// fill in the originalObstacles_ map
		originalObstacles_.resize(ycells_);
		for (unsigned int y = 0; y < originalObstacles_.size(); y++)
		{
			originalObstacles_[y].resize(xcells_);
			for (unsigned int x = 0; x < originalObstacles_[y].size(); x++)
			{
				originalObstacles_[y][x] = occupancyMap_[y][x];
			}
		}
	}
}

void WorldOccupancyMap::selectSubMap(double xfrom, double yfrom, double xto, double yto)
{

	// save the original map, if not already done
	if (originalOccupancyMap_.size() == 0)
	{
		originalOccupancyMap_.resize(occupancyMap_.size());
		for (unsigned int y = 0; y < occupancyMap_.size(); y++)
		{
			originalOccupancyMap_[y].resize(occupancyMap_[y].size());
			for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
			{
				originalOccupancyMap_[y][x] = occupancyMap_[y][x];
			}
		}
		originalxcells_ = xcells_;
		originalycells_ = ycells_;
	}

	// copy the current granularity map to a temporary one
	std::vector<std::vector<double>> temp;
	temp.resize(occupancyMap_.size());
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		temp[y].resize(occupancyMap_[y].size());
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			temp[y][x] = occupancyMap_[y][x];
		}
	}
	// check the coordinates of the submap and make sure to get whole cells
	xfrom = floor((double)(xfrom / granularity_ + WP::CALCULATION_APPROXIMATION_ERROR)) * granularity_;
	xto = ceil(xto / granularity_) * granularity_;
	yfrom = floor((double)(yfrom / granularity_ + WP::CALCULATION_APPROXIMATION_ERROR)) * granularity_;
	yto = ceil(yto / granularity_) * granularity_;

	xfrom = xfrom < 0 ? 0 : xfrom;
	yfrom = yfrom < 0 ? 0 : yfrom;
	xto = xto > this->getXSize() ? this->getXSize() : xto;
	yto = yto > this->getYSize() ? this->getYSize() : yto;
	// clear the current occupancy map and resize it (twice the size)
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].clear();
	}
	occupancyMap_.clear();
	// we may have to approximate the new size
	occupancyMap_.resize((yto - yfrom) / granularity_);

	std::cout.precision(20);

	unsigned int xcells = (unsigned int)((xto - xfrom) / granularity_ + WP::CALCULATION_APPROXIMATION_ERROR);
	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		occupancyMap_[y].resize(xcells);
	}
	//fill the values
	unsigned int ybase = (unsigned int)(yfrom / granularity_ + WP::CALCULATION_APPROXIMATION_ERROR);
	unsigned int xbase = (unsigned int)(xfrom / granularity_ + WP::CALCULATION_APPROXIMATION_ERROR);

	for (unsigned int y = 0; y < occupancyMap_.size(); y++)
	{
		for (unsigned int x = 0; x < occupancyMap_[y].size(); x++)
		{
			occupancyMap_[y][x] = temp[y + ybase][x + xbase];
		}
	}
	// restore the right number of cells
	xcells_ = occupancyMap_[0].size();
	ycells_ = occupancyMap_.size();

	// clear the current originalObstacles_ map and resize it
	for (unsigned int y = 0; y < originalObstacles_.size(); y++)
	{
		originalObstacles_[y].clear();
	}
	originalObstacles_.clear();
	// fill in the originalObstacles_ map
	originalObstacles_.resize(ycells_);
	for (unsigned int y = 0; y < originalObstacles_.size(); y++)
	{
		originalObstacles_[y].resize(xcells_);
		for (unsigned int x = 0; x < originalObstacles_[y].size(); x++)
		{
			originalObstacles_[y][x] = occupancyMap_[y][x];
		}
	}
}

double WorldOccupancyMap::getOccupancyValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < occupancyMap_.size() && x_cell < occupancyMap_[y_cell].size())
	{
		return occupancyMap_[y_cell][x_cell];
	}
	return INFINITY;
}

double WorldOccupancyMap::getShortestDistanceFromObstacles(unsigned short int x_cell, unsigned short int y_cell)
{
	if (onGrid(x_cell, y_cell))
	{
		double dis_global = voronoi_.getDistance(x_cell, y_cell) * this->granularity_;
		if(localMap_.size()>0)
		{
			double wx,wy;
			map2world(x_cell,y_cell,wx,wy);
			int mx, my;
			mx = static_cast<int>((wx - this->originX_local_) / this->granularity_);
	    	my = static_cast<int>((wy - this->originY_local_) / this->granularity_);

			if(mx>=0 && mx<localMap_.size() && my >=0 && my < localMap_.size())
			{
				double dis_local = voronoi_local_.getDistance(mx, my) * this->granularity_;
				return std::min(dis_global,dis_local);
			}
		}
		return dis_global;
	}
	return -1;
}

double WorldOccupancyMap::getShortestDistanceFromObstacles(mpac_generic::Pose2d pose)
{
	int x_cell, y_cell;
	world2map(pose(0), pose(1), x_cell, y_cell);

	if (onGrid(x_cell, y_cell))
	{
		double dis_global = voronoi_.getDistance(x_cell, y_cell) * this->granularity_;
		if(localMap_.size()>0)
		{
			int mx, my;

			mx = static_cast<int>((pose(0) - this->originX_local_) / this->granularity_);
	    	my = static_cast<int>((pose(1) - this->originY_local_) / this->granularity_);
			if(mx>=0 && mx<localMap_.size() && my >=0 && my < localMap_.size())
			{
				double dis_local = voronoi_local_.getDistance(mx, my) * this->granularity_;
				return std::min(dis_global,dis_local);
			}
		}
		return dis_global;
	}
	return -1;
}

int WorldOccupancyMap::getDirectionValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < directionMap_.size() && x_cell < directionMap_[y_cell].size())
	{
		return static_cast<int>(directionMap_[y_cell][x_cell]);
	}
	return -1;
}
int WorldOccupancyMap::getProhibitedValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < prohibitedMap_.size() && x_cell < prohibitedMap_[y_cell].size())
	{
		return static_cast<int>(prohibitedMap_[y_cell][x_cell]);
	}
	return -1;
}
int WorldOccupancyMap::getSpeedValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < speedMap_.size() && x_cell < speedMap_[y_cell].size())
	{
		return static_cast<int>(speedMap_[y_cell][x_cell]);
	}
	return -1;
}

int WorldOccupancyMap::getNoCrossingValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < noCrossingMap_.size() && x_cell < noCrossingMap_[y_cell].size())
	{
		return static_cast<int>(noCrossingMap_[y_cell][x_cell]);
	}
	return -1;
}

int WorldOccupancyMap::getChannelValueInCell(unsigned short int x_cell, unsigned short int y_cell)
{
	if (y_cell < channelMap_.size() && x_cell < channelMap_[y_cell].size())
	{
		return static_cast<int>(channelMap_[y_cell][x_cell]);
	}
	return -1;
}

void WorldOccupancyMap::addObstacles(std::vector<cellPosition> obstacles)
{
	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{
		occupancyMap_[(*it).y_cell][(*it).x_cell] = 1;
	}
}

void WorldOccupancyMap::addObstacles(mpac_generic::Point2dVec obstacles)
{

	dynamicObstacles.clear();

	for (size_t i = 0; i < obstacles.size(); i++)
	{
		int x, y;
		world2map(obstacles[i](0), obstacles[i](1), x, y);

		if (onGrid(x, y))
		{
			occupancyMap_[y][x] = 1.0;
			Vec2i gridPoint;
			gridPoint.set_x(x);
			gridPoint.set_y(y);
			dynamicObstacles.push_back(gridPoint);
		}
	}
	voronoi_.exchangeObstacles(dynamicObstacles);
	voronoi_.update();
	voronoi_.prune();
}

void WorldOccupancyMap::initProhibitedMap(uint8_t value)
{

	prohibitedMap_.clear();
	prohibitedMap_.resize(occupancyMap_.size());
	for (size_t i = 0; i < prohibitedMap_.size(); i++)
	{
		prohibitedMap_[i].resize(occupancyMap_[i].size(), 0);
	}
}
void WorldOccupancyMap::initDirectionMap(uint8_t value)
{
	directionMap_.clear();
	directionMap_.resize(occupancyMap_.size());
	for (size_t i = 0; i < directionMap_.size(); i++)
	{
		directionMap_[i].resize(occupancyMap_[i].size(), value);
	}
}
void WorldOccupancyMap::initSpeedMap(uint8_t value)
{
	speedMap_.clear();
	speedMap_.resize(occupancyMap_.size());
	for (size_t i = 0; i < speedMap_.size(); i++)
	{
		speedMap_[i].resize(occupancyMap_[i].size(), value);
	}
}

void WorldOccupancyMap::initNoCrossingMap(uint8_t value)
{
	for (size_t i = 0; i < noCrossingMap_.size(); i++)
	{
		noCrossingMap_[i].clear();
	}
	noCrossingMap_.clear();
	noCrossingMap_.resize(occupancyMap_.size());
	for (size_t i = 0; i < noCrossingMap_.size(); i++)
	{
		noCrossingMap_[i].resize(occupancyMap_[i].size(), value);
	}
}

void WorldOccupancyMap::initDynamicPoints(uint8_t value)
{
	//TODO
}

void WorldOccupancyMap::initChannelMap(uint8_t value)
{
	channelMap_.clear();
	channelMap_.resize(occupancyMap_.size());
	for (size_t i = 0; i < channelMap_.size(); i++)
	{
		channelMap_[i].resize(occupancyMap_[i].size(), value);
	}
}

void WorldOccupancyMap::updateValue(std::vector<cellPosition> &obstacles, uint8_t value, mpac_generic::VectorMapType type)
{
	switch (type)
	{
	case mpac_generic::VectorMapType::ProhibitedMap:
		SPDLOG_INFO("Update Prohibited Area!");
		updateProhibitedMap(obstacles, value);
		break;
	case mpac_generic::VectorMapType::DirectionMap:
		SPDLOG_INFO("Update Diretion Area!");
		updateDirectionMap(obstacles, value);
		break;
	case mpac_generic::VectorMapType::SpeedMap:
		SPDLOG_INFO("Update Speed AREA!");
		updateSpeedMap(obstacles, value);
		break;
	case mpac_generic::VectorMapType::NoCrossingMap:
		SPDLOG_INFO("Update NonCrossing AREA!");
		updateNoCrossingMap(obstacles, value);
		break;
	case mpac_generic::VectorMapType::ChannelMap:
		SPDLOG_INFO("Update Channel AREA!");
		updateChannelMap(obstacles, value);
		break;
	default:
		break;
	}
}

void WorldOccupancyMap::updateProhibitedMap(std::vector<cellPosition> &obstacles, uint8_t value)
{

	//特殊区域为空，则以静态地图尺寸进行初始化
	if (prohibitedMap_.size() < 1)
	{
		prohibitedMap_.resize(occupancyMap_.size());
		for (size_t i = 0; i < prohibitedMap_.size(); i++)
		{
			prohibitedMap_[i].resize(occupancyMap_[i].size(), 0);
		}
	}

	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{
		// printf("更新禁行区！33333333333\n");
		prohibitedMap_[(*it).y_cell][(*it).x_cell] = 1;
	}
}
void WorldOccupancyMap::updateDirectionMap(std::vector<cellPosition> &obstacles, uint8_t value)
{
	//特殊区域为空，则以静态地图尺寸进行初始化
	if (directionMap_.size() < 1)
	{
		directionMap_.resize(occupancyMap_.size());
		for (size_t i = 0; i < directionMap_.size(); i++)
		{
			directionMap_[i].resize(occupancyMap_[i].size(), 0);
		}
	}

	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{

		directionMap_[(*it).y_cell][(*it).x_cell] = value;
	}
}
void WorldOccupancyMap::updateSpeedMap(std::vector<cellPosition> &obstacles, uint8_t value)
{
	//特殊区域为空，则以静态地图尺寸进行初始化
	if (speedMap_.size() < 1)
	{
		speedMap_.resize(occupancyMap_.size());
		for (size_t i = 0; i < speedMap_.size(); i++)
		{
			speedMap_[i].resize(occupancyMap_[i].size(), 0);
		}
	}

	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{

		speedMap_[(*it).y_cell][(*it).x_cell] = value;
	}
}

void WorldOccupancyMap::updateNoCrossingMap(std::vector<cellPosition> &obstacles, uint8_t value)
{
	if (noCrossingMap_.size() < 1)
	{
		noCrossingMap_.resize(occupancyMap_.size());
		for (size_t i = 0; i < noCrossingMap_.size(); i++)
		{
			noCrossingMap_[i].resize(occupancyMap_[i].size(), 0);
		}
	}

	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{

		noCrossingMap_[(*it).y_cell][(*it).x_cell] = value;
	}
}

void WorldOccupancyMap::updateChannelMap(std::vector<cellPosition> &obstacles, uint8_t value)
{
	//特殊区域为空，则以静态地图尺寸进行初始化
	if (channelMap_.size() < 1)
	{
		channelMap_.resize(occupancyMap_.size());
		for (size_t i = 0; i < channelMap_.size(); i++)
		{
			channelMap_[i].resize(occupancyMap_[i].size(), 0);
		}
	}

	for (std::vector<cellPosition>::iterator it = obstacles.begin(); it != obstacles.end(); it++)
	{

		channelMap_[(*it).y_cell][(*it).x_cell] = value;
	}
}
void WorldOccupancyMap::updateLocalMap(mpac_generic::Point2dVec obstacles,mpac_generic::Pose2d locallPose)
{
	this->originX_local_ = locallPose.x()-4.0;
	this->originY_local_ = locallPose.y()-4.0;

	int map_size =160;

	localMap_.resize(map_size);
	for(size_t i = 0; i < map_size; i++){
		localMap_[i].clear();
		localMap_[i].resize(map_size,0);
	}

	for (size_t i = 0; i < obstacles.size(); i++)
	{
		int mx, my;
		mx = static_cast<int>((obstacles[i].x() - this->originX_local_) / this->granularity_);
	    my = static_cast<int>((obstacles[i].y() - this->originY_local_) / this->granularity_);

		if(mx>=0 && mx<map_size && my >=0 && my<map_size)
		{
			localMap_[my][mx] = 1;
		}
	}

	voronoi_local_.buildVoronoiFromMap(localMap_);

}

void WorldOccupancyMap::removeObstacles(std::vector<cellPosition> freecells)
{
	for (std::vector<cellPosition>::iterator it = freecells.begin(); it != freecells.end(); it++)
	{
		occupancyMap_[(*it).y_cell][(*it).x_cell] = originalObstacles_[(*it).y_cell][(*it).x_cell];
	}
}
void WorldOccupancyMap::removeObstacles(mpac_generic::Point2dVec freecells)
{

	for (size_t i = 0; i < freecells.size(); i++)
	{
		int x, y;
		world2map(freecells[i].x(), freecells[i].y(), x, y);

		if (onGrid(x, y))
		{
			occupancyMap_[y][x] = originalOccupancyMap_[y][x];
		}

		// for (int j = -13; j < 13; j++)
		// {
		// 	for (int k = -13; k < 13; k++)
		// 	{
		// 		if (onGrid(x + k, y + j))
		// 		{
		// 			occupancyMap_[y + j][x + k] = originalOccupancyMap_[y + j][x + k];
		// 		}
		// 	}
		// }
	}
	std::vector<Vec2i> pts;
	pts.clear();
	voronoi_.exchangeObstacles(pts);
	voronoi_.update();
	voronoi_.prune();
}

bool WorldOccupancyMap::containsObstacles()
{
	return containsObstacles_;
}

void WorldOccupancyMap::initialize(int xcells, int ycells, double granularity, const std::vector<std::vector<double>> &occupancyMap)
{

	//原始静态地图及其大小
	originalOccupancyMap_ = occupancyMap;
	originalxcells_ = xcells;
	originalycells_ = ycells;
	originalGranularity_ = granularity;

	//实际使用的规划地图（可能会对地图进行合并和更改分辨率）
	xcells_ = xcells;
	ycells_ = ycells;
	granularity_ = granularity;
	occupancyMap_ = originalOccupancyMap_;

	// the map contains obstacles
	containsObstacles_ = true;
	prohibitedMap_.clear();
	directionMap_.clear();
	speedMap_.clear();
	noCrossingMap_.clear();
	localMap_.clear();

}

void WorldOccupancyMap::mapMerge()
{
	occupancyMap_ = originalOccupancyMap_;
	for (size_t i = 0; i < occupancyMap_.size(); i++)
	{
		for (size_t j = 0; j < occupancyMap_[0].size(); j++)
		{
			if (prohibitedMap_.size() > 0 && prohibitedMap_[i][j] > 0)
			{
				occupancyMap_[i][j] = 1.0;
			}
		}
	}
	voronoi_.buildVoronoiFromMap(occupancyMap_);
}

void WorldOccupancyMap::setOrigin(double x, double y, double yaw)
{
	originX_ = x;
	originY_ = y;
	originYaw_ = yaw;
}

void WorldOccupancyMap::getOrigin(double &x, double &y, double &yaw)
{
	x = originX_;
	y = originY_;
	yaw = originYaw_;
}

void WorldOccupancyMap::map2world(int mx, int my, double &wx, double &wy)
{
	wx = this->originX_ + mx * this->granularity_;
	wy = this->originY_ + my * this->granularity_;
}

void WorldOccupancyMap::world2map(double wx, double wy, int &mx, int &my)
{

	mx = static_cast<int>((wx - this->originX_) / this->granularity_);
	my = static_cast<int>((wy - this->originY_) / this->granularity_);

	//printf("wx:%f wy:%f mx:%d my:%d\n",wx,wy,mx,my);
}
bool WorldOccupancyMap::onGrid(int x, int y)
{
	if ((x < 0) || (y < 0) || !(x < xcells_) || !(y < ycells_))
	{
		return false;
	}
	else
	{
		return true;
	}
}