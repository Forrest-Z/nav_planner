#pragma once
//保证头文件被编译一次
 
#include<iostream>
#include<string>
#include<vector>
#include<map>
#include "WorldRoadNetMap.h"
using namespace std;
 
/*本程序是使用Dijkstra算法来求解最短路径的问题
采用的邻接矩阵来存储图
*/
 
struct Edge
{
    float rawLength; //欧氏距离
    int level; //优先级越高，代价值越小
    int direciton; //0 双向；  1 正向；  2 逆向 
    Edge()
    {
        rawLength = 0.;
        level = 0;
        direciton = 0;
    }
};
struct PositionNode 
{
    int index;
    string id;
    float g;
    float h;
    float c;
    bool isVisit;
    int preIndex;
    PositionNode()
    {
        index = -1;
        preIndex = -1;
        isVisit = false;
        c = 100000.0;
    };
};
 
class Graph_DG
{
private:
	int vexnum;//图的顶点个数
	int edge;//图的边数
    vector<vector<double>> graph;//邻接矩阵
	
    map<string,int> position_index;

    WorldRoadNetMap*  map_data_;


    


public:
	//构造函数
	Graph_DG(WorldRoadNetMap*  map_data);
	//析构函数
	~Graph_DG();
	//判断我们每次输入的边的信息是否合法
	//顶点从1开始编号
	bool check_edge_value(int start, int end, int weight);
	//创建图
	void createGraph();
	//打印邻接矩阵
	void print();
	//求最短路径
    vector<string> solve(string startPosition,string endPositon);
	void Dijkstra(string startPosition,string endPositon);
	//打印最短路径
	
};