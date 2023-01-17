#include "spline2d.h"
#include <iostream>

Spline2d::Spline2d(/* args */)
{
}

Spline2d::~Spline2d()
{
}

void Spline2d::set_points(const std::vector<double> &x, const std::vector<double> &y)
{

    s_.clear();
    s_.resize(x.size());
    s_[0] = 0.0;

    std::cout << x[0] << " " << y[0] << " " << s_[0] << std::endl;

    for (size_t i = 1; i < x.size(); i++)
    {
        double ds = sqrt(pow(x[i] - x[i - 1], 2) + pow(y[i] - y[i - 1], 2));
        s_[i] = s_[i - 1] + ds;
        std::cout << x[i] << " " << y[i] << " " << s_[i] << std::endl;
    }

    x_.set_points(s_, x);
    std::cout << "finish set points --x" << std::endl;
    y_.set_points(s_, y);
    std::cout << "finish set points --y" << std::endl;
}

void Spline2d::set_points_no_print(const std::vector<double> &x, const std::vector<double> &y)
{
    s_.clear();
    s_.resize(x.size());
    s_[0] = 0.0;

    for (size_t i = 1; i < x.size(); i++)
    {
        double ds = sqrt(pow(x[i] - x[i - 1], 2) + pow(y[i] - y[i - 1], 2));
        s_[i] = s_[i - 1] + ds;
    }

    x_.set_points(s_, x);
    y_.set_points(s_, y);
}

void Spline2d::getValue(double s, double &x, double &y)
{

    x = x_(s);
    y = y_(s);
}

double Spline2d::calcCurvature(double s)
{
    double dx = this->x_.calcd(s);
    double ddx = this->x_.calcdd(s);
    double dy = this->y_.calcd(s);
    double ddy = this->y_.calcdd(s);

    double k = (ddy * dx - ddx * dy) / (dx * dx + dy * dy);

    return k;
}

double Spline2d::calcYaw(double s)
{
    double dx = this->x_.calcd(s);
    double dy = this->y_.calcd(s);

    double yaw = atan2(dy, dx);

    return yaw;
}

double Spline2d::findClosestPoint(double x, double y, double last_s)
{

    double min_dis = 10000;
    double min_s = last_s;
    double x_r, y_r, temp_dis;
    double range_s = 2;    //首次采样范围为±１ｍ
    double step_s = 0.001; //首次采样步长为0.1m

    double start_point = (last_s - 2) > 0 ? (last_s - 2) : 0;
    double end_point = last_s + 2;

    for (double s_sample = start_point; s_sample < end_point; s_sample += step_s)
    {
        getValue(s_sample, x_r, y_r);
        temp_dis = hypot((x - x_r), (y - y_r));
        if (temp_dis < min_dis)
        {
            min_s = s_sample;
            min_dis = temp_dis;
        }
    }
    return min_s;
}
