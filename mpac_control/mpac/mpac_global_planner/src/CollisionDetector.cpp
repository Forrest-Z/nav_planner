
#include "mpac_global_planner/CollisionDetector.h"

CollisionDetector::CollisionDetector(WorldOccupancyMap *occupancyMap)
{
	map_ = occupancyMap;
	directions_ << 1, 0, //右
		1, 1,			 //右上
		0, 1,			 //上
		-1, 1,			 //左上
		-1, 0,			 //左
		-1, -1,			 //左下
		0, -1,			 //下
		1, -1;			 //右下
}

CollisionDetector::~CollisionDetector()
{
}

bool CollisionDetector::isCollisionFree(Configuration *conf)
{
	std::cout << "isCollisionFree" << std::endl;
	std::vector<cellPosition> sweptCells = conf->getCellsSwept();
	if (map_->getOccupancyValueInCell(conf->getXCell(), conf->getYCell()) >= WP::OCCUPANCY_THRESHOLD)
	{
		std::cout << "can not pass" << std::endl;
		return false;
	}

	// for (std::vector<cellPosition>::iterator it = sweptCells.begin(); it != sweptCells.end(); it++)
	// {
	// 	if ((*it).y_cell >= map_->getYCells() || (*it).x_cell >= map_->getXCells() || (*it).y_cell < 0 || (*it).x_cell < 0)
	// 	{
	// 		return false;
	// 	}
	// 	if (map_->getOccupancyValueInCell((*it).x_cell, (*it).y_cell) >= WP::OCCUPANCY_THRESHOLD)
	// 	{
	// 		return false;
	// 	}
	// }
	return true;
}

bool CollisionDetector::isBlocked(int cellXcoord, int cellYcoord)
{
	if (cellYcoord >= map_->getYCells() || cellXcoord >= map_->getXCells() || cellYcoord < 0 || cellXcoord < 0)
		return true;
	if (map_->getOccupancyValueInCell(cellXcoord, cellYcoord) > /*WP::OCCUPANCY_THRESHOLD*/ 0.6)
	{
		return true;
	}
	return false;
}

bool CollisionDetector::isPassable(int new_x, int new_y, int parent_x, int parent_y)
{

	// 判断是否越界
	if (new_y >= map_->getYCells() || new_x >= map_->getXCells() || new_y < 0 || new_y < 0)
	{
		return false;
	}

	// 判断是否是禁行区
	int value = map_->getProhibitedValueInCell(new_x, new_y);
	if (value > 0)
	{
		return false;
	}

	//判断是否是非穿行区
	if (map_->getNoCrossingValueInCell(new_x, new_y) > 0)
	{
		return false;
	}

	// 判断是否是单行区，且方向是否被允许
	value = map_->getDirectionValueInCell(new_x, new_y);
	if (value > 0)
	{
		Eigen::Vector2i direction_set = directions_.middleRows(value - 1, 1).transpose();
		Eigen::Vector2i direction_expect;
		direction_expect << parent_x - new_x, parent_y - new_y;
		if (direction_set.dot(direction_expect) <= 0)
		{
			return false;
		}
	}

	if (map_->getShortestDistanceFromObstacles(new_x, new_y) < (WP::RADIUS_CAR_INSCRIBED + 0.05))
	{
		return false;
	}

	// 可通过
	return true;
}

bool CollisionDetector::isCollisionFree(mpac_generic::Pose2d pose, double left_width, double right_width, double front_length, double back_length)
{

	double min_dis = std::min({left_width, right_width, front_length, back_length});
	double max_dis = std::max({hypot(left_width, back_length), hypot(left_width, front_length)});

	double fromObstacles = map_->getShortestDistanceFromObstacles(pose);

	if (fromObstacles < min_dis)
	{
		return false;
	}

	if (fromObstacles > max_dis)
	{
		return true;
	}

	std::vector<mpac_generic::Pose2d> car_model;
	car_model.push_back(mpac_generic::Pose2d(front_length, left_width, 0));
	car_model.push_back(mpac_generic::Pose2d(front_length, -right_width, 0));
	car_model.push_back(mpac_generic::Pose2d(-back_length, -right_width, 0));
	car_model.push_back(mpac_generic::Pose2d(-back_length, left_width, 0));

	Eigen::Matrix2d rotationMatrix;
	rotationMatrix << cos(pose(2)), -sin(pose(2)),
		sin(pose(2)), cos(pose(2));

	mpac_generic::Point2dVec pts;
	for (size_t i = 0; i < car_model.size(); i++)
	{

		pts.push_back(rotationMatrix * car_model[i].topRows(2) + pose.topRows(2));
	}
	pts.push_back(rotationMatrix * car_model[0].topRows(2) + pose.topRows(2));

	mpac_geometry::Polygon polygon(pts);
	mpac_generic::Point2dVec points;

	points = polygon.discretizePolygon(map_->getGranularity(), false);

	for (size_t i = 0; i < points.size(); i++)
	{
		int x_cell, y_cell;
		map_->world2map(points[i].x(), points[i].y(), x_cell, y_cell);

		// 判断是否是禁行区
		int value = map_->getProhibitedValueInCell(x_cell, y_cell);
		if (value > 0)
		{
			return false;
		}

		if (map_->getOccupancyValueInCell(x_cell, y_cell) > 0.6)
		{
			return false;
		}

		if (map_->getNoCrossingValueInCell(x_cell, y_cell) > 0)
		{
			return false;
		}
	}

	return true;
}

bool CollisionDetector::isPoseCollisionFree(mpac_generic::Pose2d pose, double safeDis)
{
	int x_cell, y_cell;
	map_->world2map(pose.x(), pose.y(), x_cell, y_cell);

	//障碍物距离判断
	if (map_->getShortestDistanceFromObstacles(x_cell, y_cell) < safeDis)
	{
		return false;
	}

	//单行区判断
	int dir = map_->getDirectionValueInCell(x_cell, y_cell);
	if (dir>0)
	{	
		Eigen::Vector2i direction_set = directions_.middleRows(dir - 1, 1).transpose();
		double angle_set = atan2(direction_set.y(),direction_set.x());
		double angle_diff = angle_set - pose.z();
		angle_diff = atan2(sin(angle_diff),cos(angle_diff));
		if (fabs(angle_diff)>M_PI_2)
		{
			return false;
		}			
	}
}

bool CollisionDetector::isCollisionFree(mpac_generic::Pose2dVec poses, double safeDis)
{

	for (size_t i = 0; i < poses.size(); i++)
	{
		if (!isPoseCollisionFree(poses[i],safeDis))
		{
			return false;
		}	
	}

	return true;
}