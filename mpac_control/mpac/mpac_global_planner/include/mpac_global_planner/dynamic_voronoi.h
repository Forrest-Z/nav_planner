/**
 * 原始代码：http://www2.informatik.uni-freiburg.de/~lau/dynamicvoronoi/
 * ROS版本：https://github.com/frontw/dynamicvoronoi
 * 参考文献：B. Lau, C. Sprunk and W. Burgard, Improved Updating of Euclidean Distance Maps and Voronoi Diagrams,
 *         IEEE Intl. Conf. on Intelligent Robots and Systems (IROS), Taipei, Taiwan, 2010.
 */

#ifndef PATH_SMOOTHER_DYNAMIC_VORONOI_H
#define PATH_SMOOTHER_DYNAMIC_VORONOI_H

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <queue>
#include <unordered_map>
// #include <opencv2/opencv.hpp>

#include "vec2i.h"
#include "bucketedqueue.h"
#include "vec2d.h"

#include <iostream>

class DynamicVoronoi
{
public:
    DynamicVoronoi();
    ~DynamicVoronoi();
    //  void buildVoronoiFromImage(const cv::Mat& map_img);
    void buildVoronoiFromMap(const std::vector<std::vector<int>> map_data);
    void buildVoronoiFromMap(const std::vector<std::vector<double>> map_data);

    //! returns the obstacle distance at the specified location
    float getDistance(int x, int y);
    //! returns whether the specified cell is part of the (pruned) Voronoi graph
    inline bool isVoronoi(int x, int y);
    //! checks whether the specficied location is occupied
    bool isOccupied(int x, int y);
    //! write the current distance map and voronoi diagram as ppm file
    void visualize(const char *filename = "result.ppm");

    std::vector<Vec2i> GetVoronoiEdgePoints() const
    {
        return edge_points_;
    };

    Vec2i GetClosestVoronoiEdgePoint(Vec2d xi, double &closest_dis);

    Vec2i GetClosetObstacleCoor(const Vec2d &p) const;

    //! remove old dynamic obstacles and add the new ones
    void exchangeObstacles(std::vector<Vec2i>& newObstacles);
    //! update distance map and Voronoi diagram to reflect the changes
    void update(bool updateRealDist = true);

    //! returns the horizontal size of the workspace/map
    unsigned int getSizeX() const { return sizeX; }
    //! returns the vertical size of the workspace/map
    unsigned int getSizeY() const { return sizeY; }

    void prune();

private:
    struct dataCell
    {
        float dist;
        char voronoi; //
        char queueing;
        int obstX;
        int obstY;
        bool needsRaise;
        int sqdist;
    };

    typedef enum
    {
        voronoiKeep = -4,
        freeQueued = -3,
        voronoiRetry = -2,
        voronoiPrune = -1,
        free = 0,
        occupied = 1
    } State;
    typedef enum
    {
        fwNotQueued = 1,
        fwQueued = 2,
        fwProcessed = 3,
        bwQueued = 4,
        bwProcessed = 1
    } QueueingState;
    typedef enum
    {
        invalidObstData = SHRT_MAX / 2
    } ObstDataState;
    typedef enum
    {
        pruned,
        keep,
        retry
    } markerMatchResult;

    void initializeEmpty(int _sizeX, int _sizeY, bool initGridMap = true);
    void initializeMap(int _sizeX, int _sizeY, std::vector<std::vector<bool>> _gridMap);

    //! add an obstacle at the specified cell coordinate
    inline void occupyCell(int x, int y);
    //! remove an obstacle at the specified cell coordinate
    inline void clearCell(int x, int y);

    //! prune the Voronoi diagram
    
    void CollectVoronoiEdgePoints();

    void setObstacle(int x, int y);
    void removeObstacle(int x, int y);

    inline void checkVoro(int x, int y, int nx, int ny, dataCell &c, dataCell &nc);

    void commitAndColorize(bool updateRealDist = true);
    void reviveVoroNeighbors(int &x, int &y);
    inline bool isOccupied(int &x, int &y, dataCell &c);

    markerMatchResult markerMatch(int x, int y);

    std::string ComputeIndex(const Vec2i &pi) const;
    std::string ComputeIndex(const Vec2d &pd) const;

    BucketPrioQueue<Vec2i> open;
    std::queue<Vec2i> pruneQueue;
    std::vector<Vec2i> removeList;
    std::vector<Vec2i> addList;
    std::vector<Vec2i> lastObstacles;

    int sizeY;
    int sizeX;
    // dataCell** data;
    std::vector<std::vector<dataCell>> data;
    // bool** gridMap;   //true is occupied, false is not
    std::vector<std::vector<bool>> gridMap;
    std::vector<Vec2i> edge_points_;
    std::unordered_map<std::string, std::pair<Vec2i, float>> closest_edge_points_;
};

#endif // PATH_SMOOTHER_DYNAMIC_VORONOI_H
