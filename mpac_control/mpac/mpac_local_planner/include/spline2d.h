#include "spline.h"

class Spline2d
{
private:
    
    tk::spline x_;
    tk::spline y_;

    std::vector<double> s_;
    

public:
    Spline2d(/* args */);
    ~Spline2d();

    void set_points_no_print(const std::vector<double>& x, const std::vector<double>& y);
    void set_points(const std::vector<double>& x, const std::vector<double>& y);
    void getValue(double s,double& x, double& y);
    double calcCurvature(double s);
    double calcYaw(double s);

    double getMaxS(){return s_.back();};
    double getMinS(){return s_.front();};
    double findClosestPoint(double x,double y,double last_s); //reture s value of closest point;
    std::vector<double> getS(){return s_;};
    
};

