#include <vector>

class SLPath
{
private:
public:
    SLPath(/* args */){};
    ~SLPath(){};

    std::vector<double> t_;
    std::vector<double> l_;
    std::vector<double> l_v;
    std::vector<double> l_a;
    std::vector<double> l_jerk;

    std::vector<double> s_;
    std::vector<double> s_v;
    std::vector<double> s_a;
    std::vector<double> s_jerk;

    std::vector<double> x_;
    std::vector<double> y_;
    std::vector<double> yaw_;
    std::vector<double> ds_;
    std::vector<double> curv_;

    double cost;
    //按照cost从小到大进行排序
    bool operator<(SLPath const &r) const
    {
        return cost < r.cost ? true : false;
    }
    double min_dis_obs;
    double dis;
    double offset;
    double jerk;
};

class SLPose
{
public:
    SLPose():s(0.0),s_v(0.0),s_a(0.0),l(0.0),l_v(0.0),l_a(0.0){};
    double s;
    double s_v;
    double s_a;
    double l;
    double l_v;
    double l_a;
    double yaw_;
};
