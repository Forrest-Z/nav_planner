#pragma once

#include <string>
#include <vector>
#include <map>
#include "mpac_generic/generic.h"
using namespace std;

// 位置点信息
struct Position
{
    int index;
    string positionId;
    mpac_generic::Pose2d pose;
};

// 路径信息
struct RoadLine
{
    string start_postion;
    string end_postion;
    mpac_generic::Path path;

    float length; //欧氏距离
    int level;       //优先级越高，代价值越小
    int direciton;   //0 双向；  1 正向；  2 逆向
    int carDirection; //0-forward  1-back
    bool segmented;
    RoadLine()
    {
        length = 0.;
        level = 1;
        direciton = 0;
    }
};

class WorldRoadNetMap
{
private:



public:

    map<string, map<string, RoadLine>> roads_;
    map<int, Position> index_positions;
    map<string, int> id_index;
//------------------- lxf ---------------------------//
    vector<Position> positons_actual;
    vector<Position> positons_virtual;
//------------------- lxf ---------------------------//
    WorldRoadNetMap(/* args */);
    WorldRoadNetMap(string positons, string roads);
    ~WorldRoadNetMap();
    bool updatePositons(string positons);
    bool updateRoads(string roads);
//------------------- lxf ---------------------------//
    // void segmented(RoadLine road,std::map<std::pair<string,string>,RoadLine> &results_road,vector<Position> &positons_vir);
    // void segmentedRoadLine(RoadLine road,std::map<std::pair<string,string>,RoadLine> &results_road,vector<Position> &positons_vir);
    void segmented(RoadLine road, map<string, map<string, RoadLine>> &results_road_front, std::map<std::pair<string,string>,RoadLine> &results_road_after, vector<Position> &positons_vir);
//------------------- lxf ---------------------------//
    Position getPosition(int index);
    mpac_generic::Pose2d getPositonValue(int index);
    mpac_generic::Pose2d getPositonValue(string positionId);
    RoadLine getRoadLine(string positionId_start, string positionId_end);
    int getPositionsSize() { return index_positions.size(); };
    int getRoadsSize() { return roads_.size(); };
    int getPositionIndex(string positionId);
    string getPositionID(int index);
    string getPositionID(mpac_generic::Pose2d pose);
};


