#include "mpac_global_planner/WorldRoadNetMap.h"
#include "rapidjson/document.h"
#include "rapidjson/prettywriter.h"
#include "rapidjson/stringbuffer.h"
// spdlog files
#include <cstdio>
#include "spdlog/spdlog.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/stdout_sinks.h"
#include "spdlog/sinks/rotating_file_sink.h"
#include "spdlog/sinks/daily_file_sink.h"

#include "mpac_generic/path_utils.h"

#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include<algorithm>

using namespace rapidjson;

WorldRoadNetMap::WorldRoadNetMap(string positons, string roads)
{
    updatePositons(positons);
    updateRoads(roads);
}

WorldRoadNetMap::WorldRoadNetMap()
{
}

WorldRoadNetMap::~WorldRoadNetMap()
{
}

// 更新位置信息
bool WorldRoadNetMap::updatePositons(string positons)
{
    Document doc;
    doc.Parse(positons.c_str());
    if (doc.HasParseError())
    {
        spdlog::error("has some error when parse string:{}", positons);
        return false;
    }
    index_positions.clear();
    positons_actual.clear();
    int index = 0;
    if (doc.HasMember("positionlist") && doc["positionlist"].IsArray())
    {
        for (size_t i = 0; i < doc["positionlist"].Size(); i++)
        {
            Position tem_position;
            tem_position.index = i;
            tem_position.positionId = doc["positionlist"][i]["positionid"].GetString();
            if (doc["positionlist"][i]["type"].GetInt() == 0 || doc["positionlist"][i]["type"].GetInt() == 3 || doc["positionlist"][i]["type"].GetInt() == 6) //普通点
            {
                tem_position.pose(0) = doc["positionlist"][i]["x"].GetFloat();
                tem_position.pose(1) = doc["positionlist"][i]["y"].GetFloat();
                tem_position.pose(2) = doc["positionlist"][i]["orientation"].GetFloat();
            }
            else
            {
                tem_position.pose(0) = doc["positionlist"][i]["preparationx"].GetFloat();
                tem_position.pose(1) = doc["positionlist"][i]["preparationy"].GetFloat();
                tem_position.pose(2) = doc["positionlist"][i]["preparationorientation"].GetFloat();
            }

            positons_actual.push_back(tem_position);
        }
        index_positions.clear();
        id_index.clear();

        int size_actual_positions = positons_actual.size();

        for(size_t i = 0; i < size_actual_positions; i++)
        {
            index_positions[i] = positons_actual[i];
            id_index[positons_actual[i].positionId] = i;
        }

        for(size_t j = 0; j < positons_virtual.size(); j++)
        {
            index_positions[j+size_actual_positions] = positons_virtual[j];
            id_index[positons_virtual[j].positionId] = j+size_actual_positions;
        }
        return true;
    }
    else
    {
        spdlog::error("not have list of position");
        return false;
    }
}

// 更新路网
bool WorldRoadNetMap::updateRoads(string roads)
{
    Document doc;
    doc.Parse(roads.c_str());
    if (doc.HasParseError())
    {
        spdlog::error("has some error when parse string:{}", roads);
        return false;
    }
    
    roads_.clear();
    index_positions.clear();
    id_index.clear();
    positons_virtual.clear();

    std::map<std::pair<string,string>,RoadLine> road_map;
    if (doc.HasMember("track") && doc["track"].IsArray())
    {
        for (size_t i = 0; i < doc["track"].Size(); i++)
        {
            RoadLine road;
            string start_postion = doc["track"][i]["startPosition"].GetString();
            string end_postion = doc["track"][i]["endPosition"].GetString();
            float fdic = doc["track"][i]["runDirection"].GetFloat();
            int direciton = 1;
            int priority = doc["track"][i]["priority"].GetInt();

            if(fabs(fdic)>1.57)
            {
                direciton = 0;
            }
            
            mpac_generic::Path path_positive; //正向路径　从起点到终点

            mpac_generic::Pose2d point;
            mpac_generic::PointType type;
            type.max_speed_ = doc["track"][i]["maxSpeed"].GetFloat();
            type.offset_ = doc["track"][i]["maxOffset"].GetFloat();
            type.fixed_ = true;

            //judge the direction of car move: forward or back
            if (direciton == 1)
            {
                type.forward_ = true;
            }else
            {
                type.forward_ = false;
                type.max_speed_ = 0-type.max_speed_;
            }
            
            int size_points = doc["track"][i]["middlePoint"].Size();

            for (size_t j = 0; j < size_points; j++)
            {
                point.x() = doc["track"][i]["middlePoint"][j]["x"].GetFloat();
                point.y() = doc["track"][i]["middlePoint"][j]["y"].GetFloat();
                point.z() = doc["track"][i]["middlePoint"][j]["orientation"].GetFloat();
                path_positive.addPathPointType(point, 0, type);
            }

            double length = mpac_generic::getTotalDistance(path_positive);

            road.start_postion = start_postion;
            road.end_postion = end_postion;
            road.direciton = direciton;
            road.length = length;
            road.path = path_positive;
            road.level = priority;
            road.segmented = false;
            road_map[std::make_pair(road.start_postion,road.end_postion)] = road; 
            printf("%s  %s\n",road.start_postion.c_str(),road.end_postion.c_str());
        }

        //路径分割
        //对所有路线进行配对                
        for (auto itr=road_map.begin();itr!=road_map.end();itr++)
        {

            if (itr->second.segmented)
            {
                continue;
            }
            itr->second.segmented = true;

            std::map<std::pair<string,string>,RoadLine>::iterator iter_partner;

            iter_partner = road_map.find(std::make_pair(itr->first.second,itr->first.first));

            if(iter_partner!=road_map.end()) //路线是双向的，进一步考虑同节点问题
            {
                if (fabs(itr->second.length - iter_partner->second.length) < 0.05) //两条路线长度一致，共用节点
                {
                    //itr为第一段路径  iter_partner为第二段路径
                    std::map<std::pair<string,string>,RoadLine> temporary_roads_1;
                    std::map<std::pair<string,string>,RoadLine> temporary_roads_2;
                    map<string, map<string, RoadLine>> no_use_road;
                    RoadLine road_p;
                    mpac_generic::Path path_p;
                    mpac_generic::Pose2d point_p;
                    mpac_generic::Pose2dVec point_l;

                    //创建节点及路径
                    segmented(itr->second, no_use_road, temporary_roads_1, positons_virtual);  

                    // 第一段路径的各小段加载到rosds_
                    for (auto itr1=temporary_roads_1.begin();itr1!=temporary_roads_1.end();itr1++)
                    {
                        road_p = itr1->second;
                        roads_[road_p.start_postion][road_p.end_postion] = road_p;//装载路径
                    }
                    // 提取线路的其他共有参数
                    mpac_generic::PointType type_l = iter_partner->second.path.pointTypes[0];

                    // 将第一段路径的各小段翻转路径  生成反向路径
                    for (auto itr1=temporary_roads_1.begin();itr1!=temporary_roads_1.end();itr1++)
                    {
                        point_l = itr1->second.path.poses;
                        reverse(point_l.begin(),point_l.end());     // 翻转
                        for(int i = 0;i < point_l.size();i++)       //遍历路径点
                        {
                            point_p.x() = point_l[i].x();
                            point_p.y() = point_l[i].y();
                            point_p.z() = point_l[i].z();
                            path_p.addPathPointType(point_p, 0, type_l);//生成新的路径
                        }
                        road_p.start_postion = itr1->second.end_postion;//新路径的 起点 是翻转路径的 终点 
                        road_p.end_postion = itr1->second.start_postion;//新路径的 终点 是翻转路径的 起点 
                        road_p.length = itr1->second.length;
                        road_p.direciton = iter_partner->second.direciton;//新路径的 方向 与第二段一致
                        road_p.level = iter_partner->second.level;
                        road_p.path = path_p;
                        temporary_roads_2[std::make_pair(road_p.start_postion,road_p.end_postion)] = road_p;//装载翻转路径
                        point_l.clear();
                        path_p.clear();
                    }
                    path_p.clear();

                    // 赋翻转后路径的角度
                    for (auto itr1=temporary_roads_2.begin();itr1!=temporary_roads_2.end();itr1++)
                    {
                        point_l = itr1->second.path.poses;// 获取翻转后各小段路径的角度

                        for(int i = 0;i < point_l.size();i++)  
                        {
                            point_p.x() = point_l[i].x();             
                            point_p.y() = point_l[i].y(); 
                            double yaw  = point_l[i].z()+M_PI;                  
                            point_p.z() = atan2(sin(yaw), cos(yaw));    
                  
                            path_p.addPathPointType(point_p, 0, itr1->second.path.pointTypes[i]);
                        }
                        road_p.start_postion = itr1->second.start_postion;
                        road_p.end_postion = itr1->second.end_postion;
                        road_p.length = itr1->second.length;
                        road_p.direciton = itr1->second.direciton;
                        road_p.level = itr1->second.level;
                        road_p.path = path_p;
                        roads_[road_p.start_postion][road_p.end_postion] = road_p;// 装载替换角度后的翻转路径

                        point_l.clear();
                        path_p.clear();
                    }
                    // printf("=======================================================================================================\n");
                    // printf("                                              roads message                                            \n");
                    // printf("=======================================================================================================\n");
                    // printf(" 方向  类型     点数    长度                   起点                           终点                    \n");
                    // printf("  正   all     %zd    %.3f  %s      %s \n",itr->second.path.poses.sizePose2d(),itr->second.length, itr->second.start_postion.c_str(), itr->second.end_postion.c_str());      
                    // printf("  反   all     %zd    %.3f  %s      %s \n",iter_partner->second.path.poses.sizePose2d(),iter_partner->second.length, iter_partner->second.start_postion.c_str(), iter_partner->second.end_postion.c_str());      
 
                }else // 两条路线长度不一致，独立节点
                {
                    for(size_t i = 0;i < 2;i++)
                    {
                        if(i == 0)
                        {
                            std::map<std::pair<string,string>,RoadLine> temporary_roads;
                            segmented(itr->second, roads_, temporary_roads, positons_virtual); 
                        }
                        else
                        {
                            std::map<std::pair<string,string>,RoadLine> temporary_roads;
                            segmented(iter_partner->second, roads_, temporary_roads, positons_virtual); 
                        }
                    }
                }
                iter_partner->second.segmented = true;
            }else // 路线是单向的
            {
                std::map<std::pair<string,string>,RoadLine> temporary_roads;
                segmented(itr->second, roads_, temporary_roads, positons_virtual); 
            }
        }
        //如果没有这一下程序，当先更新点信息时，index_positions 和 id_index 中不会在更新到新值
        index_positions.clear();
        id_index.clear();
        int size_actual_positions = positons_actual.size();

        for(size_t i = 0; i < size_actual_positions; i++)
        {
            index_positions[i] = positons_actual[i];
            id_index[positons_actual[i].positionId] = i;

            spdlog::info("{},{}",positons_actual[i].positionId,i);
        }
        for(size_t j = 0; j < positons_virtual.size(); j++)
        {
            index_positions[j+size_actual_positions] = positons_virtual[j];
            id_index[positons_virtual[j].positionId] = j+size_actual_positions;
            spdlog::info("{},{}",positons_virtual[j].positionId,j+size_actual_positions);
        }
        return true;
    }
    else
    {
        spdlog::error("not have list of track");
        return false;
    }
}
void WorldRoadNetMap::segmented(RoadLine road, map<string, map<string, RoadLine>> &results_road_front, std::map<std::pair<string,string>,RoadLine> &results_road_after, vector<Position> &positons_vir)
// void WorldRoadNetMap::segmented(RoadLine road, std::map<std::pair<string,string>,RoadLine> &results_road, vector<Position> &positons_vir)
{
    int size_points_path = road.path.poses.sizePose2d();

    // 使用曲线的总长进行分割
    mpac_generic::Pose2d used_dis;
    used_dis = road.path.poses[0];
    double  dis_path;
    for(size_t i = 0;i < size_points_path;i++)
    {
        dis_path += hypot((road.path.poses[i].x() -used_dis.x()), (road.path.poses[i].y() - used_dis.y()));//计算距离 
        used_dis = road.path.poses[i]; 
    }
    double uniform_distance = dis_path / ceil(dis_path);

    // 使用两点之间的距离进行分割
    // double dis_path = road.length;
    // double uniform_distance = dis_path / floor(dis_path);

    string start_postion = road.start_postion;
    string end_postion = road.end_postion;

    mpac_generic::Pose2d point_used_segmented, used_point_calc;
    mpac_generic::Path path_segmented; 
    RoadLine road_segmented;
    bool start_point_flag = false;
    string ID, last_ID;
    Position add_positons;

    for (size_t j = 0; j < size_points_path; j++)
    {
        point_used_segmented.x() = road.path.poses[j].x();
        point_used_segmented.y() = road.path.poses[j].y();
        point_used_segmented.z() = road.path.poses[j].z();

        if(j == 0)//判断第一个点
        {
            used_point_calc.x() = point_used_segmented.x();//仅用于第一次计算距离
            used_point_calc.y() = point_used_segmented.y();
            path_segmented.addPathPointType(point_used_segmented, 0, road.path.pointTypes[j]);//放入第一条路径的起始点
            start_point_flag = true;
        }
        else if(j == size_points_path - 1)//判断最后一个点
        {
            if(last_ID == "")
            {
                road_segmented.start_postion = start_postion;
            }else
            {
                road_segmented.start_postion = last_ID;
            }
            road_segmented.end_postion = end_postion;
            road_segmented.length = mpac_generic::getTotalDistance(path_segmented);
            road_segmented.path = path_segmented;
            road_segmented.direciton = road.direciton;
            results_road_front[road_segmented.start_postion][road_segmented.end_postion] = road_segmented;//单向路线使用
            results_road_after[std::make_pair(road_segmented.start_postion,road_segmented.end_postion)] = road_segmented;//涉及双向路线使用
            // results_road[std::make_pair(road_segmented.start_postion,road_segmented.end_postion)] = road_segmented;
            path_segmented.clear();
        }
        else
        {
            double  dis = hypot((point_used_segmented.x() -used_point_calc.x()), (point_used_segmented.y() - used_point_calc.y()));//计算距离
            if(dis >= uniform_distance )
            {

                used_point_calc.x() = point_used_segmented.x();//生成节点
                used_point_calc.y() = point_used_segmented.y();
                used_point_calc.z() = point_used_segmented.z();
                path_segmented.addPathPointType(point_used_segmented, 0, road.path.pointTypes[j]);//本条路径的终点

                boost::uuids::uuid uid = boost::uuids::random_generator()();
                const string uid_str = boost::uuids::to_string(uid);
                ID = uid_str;
                if(start_point_flag)//第一次起点为固定ID。终点为设置ID
                {
                    road_segmented.start_postion = start_postion;
                    road_segmented.end_postion = ID;
                    add_positons.positionId = ID;
                    start_point_flag = false;
                }
                else//中间点，起点为设置ID。终点为设置ID
                {
                    road_segmented.start_postion = last_ID;
                    road_segmented.end_postion = ID;
                    add_positons.positionId = ID;
                }

                add_positons.pose(0) = point_used_segmented.x();
                add_positons.pose(1) = point_used_segmented.y();
                add_positons.pose(2) = point_used_segmented.z();
                positons_vir.push_back(add_positons);      //增加虚拟节点
                spdlog::info("vir position:{}",add_positons.positionId);
  
                road_segmented.length = mpac_generic::getTotalDistance(path_segmented);
                road_segmented.path = path_segmented;
                road_segmented.direciton = road.direciton;
                road_segmented.level = road.level;
                results_road_front[road_segmented.start_postion][road_segmented.end_postion] = road_segmented;//单向路线使用
                results_road_after[std::make_pair(road_segmented.start_postion,road_segmented.end_postion)] = road_segmented;//涉及双向路线使用
                // results_road[std::make_pair(road_segmented.start_postion,road_segmented.end_postion)] = road_segmented;
                path_segmented.clear();
                path_segmented.addPathPointType(point_used_segmented, 0, road.path.pointTypes[j]);//下一条路径的起点
                last_ID = ID;//记录ID
            }
            else
            {
                path_segmented.addPathPointType(point_used_segmented, 0, road.path.pointTypes[j]);
            }
        } 
    }
}

// 通过位置点索引获取位置点详细信息
Position WorldRoadNetMap::getPosition(int index)
{
    map<int, Position>::iterator it;
    it = index_positions.find(index);
    if (it != index_positions.end())
    {
        return it->second;
    }
}
// 通过位置点索引获取位置点坐标信息
mpac_generic::Pose2d WorldRoadNetMap::getPositonValue(int index)
{
    map<int, Position>::iterator it;
    it = index_positions.find(index);
    if (it != index_positions.end())
    {
        return it->second.pose;
    }
}

mpac_generic::Pose2d WorldRoadNetMap::getPositonValue(string positionId)
{
    int index = getPositionIndex(positionId);
    return getPositonValue(index);
}

// 获取两个位置点之间的路径信息
RoadLine WorldRoadNetMap::getRoadLine(string positionId_start, string positionId_end)
{
    map<string, map<string, RoadLine>>::iterator its;
    its = roads_.find(positionId_start);
    if (its != roads_.end())
    {
        map<string, RoadLine>::iterator it;

        it = its->second.find(positionId_start);
        if (it != its->second.end())
        {
            return it->second;
        }
    }
}
// 通过位置点的ID获取位置点索引值
int WorldRoadNetMap::getPositionIndex(string positionId)
{
    map<string, int>::iterator it;
    it = id_index.find(positionId);
    if (it != id_index.end())
    {
        return it->second;
    }else
    {
        spdlog::error("can not get id of position {}!",positionId);
    }
}
// 通过位置点的索引值获取位置点ID
string WorldRoadNetMap::getPositionID(int index)
{
    map<int, Position>::iterator it;
    it = index_positions.find(index);
    if (it != index_positions.end())
    {
        return it->second.positionId;
    }
}

// 通过位置点的坐标获取位置点ID
string WorldRoadNetMap::getPositionID(mpac_generic::Pose2d pose)
{
    double dis_min = 1.0;
    string closest_position = "";
    map<int, Position>::iterator itr;
    for (itr = index_positions.begin(); itr != index_positions.end(); itr++)
    {
        double dis_tmp = hypot(pose.x() - itr->second.pose.x(), pose.y() - itr->second.pose.y());
        if (dis_tmp < dis_min)
        {
            dis_min = dis_tmp;
            closest_position = itr->second.positionId;
        }
    }
    return closest_position;
}