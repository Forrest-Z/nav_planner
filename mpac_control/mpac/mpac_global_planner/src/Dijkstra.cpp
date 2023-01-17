#include "mpac_global_planner/Dijkstra.h"
#include <boost/heap/binomial_heap.hpp>

//构造函数
struct CompareNodes
{
    /// Sorting 3D nodes by increasing C value - the total estimated cost
    bool operator()(const PositionNode *lhs, const PositionNode *rhs) const
    {
        return lhs->c > rhs->c;
    }
};

Graph_DG::Graph_DG(WorldRoadNetMap *map_data)
{
    // 初始化路网图
    this->map_data_ = map_data;
    this->vexnum = map_data->getPositionsSize();

    //初始化节点和邻接矩阵并赋值
    graph.resize(this->vexnum);
    for (size_t i = 0; i < this->vexnum; i++)
    {
        graph[i].resize(this->vexnum);
        for (size_t j = 0; j < this->vexnum; j++)
        {
            graph[i][j] = INFINITY;
        }
    }
}

//析构函数
Graph_DG::~Graph_DG()
{
}

void Graph_DG::createGraph()
{

    map<string, map<string, RoadLine>>::iterator multitr;
    map<string, RoadLine>::iterator intertr;
    for (multitr = map_data_->roads_.begin(); multitr != map_data_->roads_.end(); multitr++)
    {
        string start_id = multitr->first;
        int start_index = map_data_->getPositionIndex(start_id);
        for (intertr = multitr->second.begin(); intertr != multitr->second.end(); intertr++)
        {
            string end_id = intertr->first;
            int end_index = map_data_->getPositionIndex(end_id);
            RoadLine roadline = intertr->second;
            double distance = roadline.length * roadline.level;
            if (roadline.direciton == 0) //双向
            {
                graph[start_index][end_index] = distance;
                graph[end_index][start_index] = distance;
            }
            else if (roadline.direciton == 1) //正向
            {
                graph[start_index][end_index] = distance;
            }
            else
            {
                graph[end_index][start_index] = distance;
            }
        }
    }
}

void Graph_DG::print()
{
    cout << "图的邻接矩阵为：" << endl;
    int count_row = 0; //打印行的标签
    int count_col = 0; //打印列的标签
                       //开始打印
    while (count_row != this->vexnum)
    {
        count_col = 0;
        while (count_col != this->vexnum)
        {
            if (graph[count_row][count_col] == INT32_MAX)
                cout << "∞"
                     << " ";
            else
                cout << graph[count_row][count_col] << " ";
            ++count_col;
        }
        cout << endl;
        ++count_row;
    }
}

vector<string> Graph_DG::solve(string startPosition, string goalPositon)
{
    int start_index = map_data_->getPositionIndex(startPosition);
    int goal_index = map_data_->getPositionIndex(goalPositon);

    typedef boost::heap::binomial_heap<PositionNode *,
                                       boost::heap::compare<CompareNodes>>
        priorityQueue;
    priorityQueue O; //open集

    int ipred;

    vector<PositionNode> nodes2D(vexnum);
    // Node* nodes2D = new Node[vexnum]();

    PositionNode start;
    start.index = map_data_->getPositionIndex(startPosition);
    start.h = 0;
    start.c = 0;
    start.isVisit = false;
    O.push(&start);
    ipred = start.index;
    nodes2D[ipred] = start;
    PositionNode nPred;
    PositionNode nSucc;
    while (!O.empty())
    {
        nPred = *O.top();
        ipred = nPred.index;
        // if (nodes2D[ipred].isVisit)
        // {
        //     printf("4-1-1-1-\n");
        //     O.pop();
        //     continue;
        // }
        // else
        {
            nodes2D[ipred].isVisit = true;
            O.pop();
            if (ipred == goal_index)
            {
                printf("finished\n");
                continue;
            }
            else
            {
            
                string idPred = map_data_->getPositionID(nPred.index);

                map<string, map<string, RoadLine>>::iterator iter;
                iter = map_data_->roads_.find(idPred);

                if (iter != map_data_->roads_.end())
                {

                    for (auto const &it : iter->second)
                    {
                        nSucc.id = it.first;
                        nSucc.index = map_data_->getPositionIndex(nSucc.id);
                        if (!nodes2D[nSucc.index].isVisit || (nodes2D[nSucc.index].c > (it.second.length * it.second.level + nPred.c)))
                        {
                            nSucc.c = it.second.length * it.second.level + nPred.c;
                            nSucc.isVisit = true;
                            nSucc.preIndex = ipred;
                            nodes2D[nSucc.index] = nSucc;
                            O.push(&nodes2D[nSucc.index]);
                        }
                    }
                }
            }
        }
    }

    vector<string> positions_id;
    positions_id.clear();

    if (!(nodes2D[goal_index].preIndex < 0))
    {

        vector<int> positions_index;
        positions_index.push_back(goal_index);

        while (nodes2D[positions_index.back()].preIndex != start_index)
        {
            positions_index.push_back(nodes2D[positions_index.back()].preIndex);
        }
        positions_index.push_back(start_index);

        int positionsNum = positions_index.size();
        for (size_t i = 0; i < positionsNum; i++)
        {
            positions_id.push_back(map_data_->getPositionID(positions_index[positionsNum - i - 1]));
        }
    }
    return positions_id;
}
