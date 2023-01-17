#include <Eigen/Dense>
#include <Eigen/LU>

//四次多项式
//x(t) = k0 + k1*t + k2*t^2 + k3*t^3 + k4*t^4
class QuarticPolynomial
{
private:
    Eigen::Matrix<double, 5, 1> k;
    Eigen::Matrix<double, 5, 1> t_vec;

public:
    QuarticPolynomial(double x0, double v0, double a0, double v1, double a1, double T)
    {
        
        k(0) = x0;
        k(1) = v0;
        k(2) = a0 / 2;

        Eigen::Matrix2d A;
        A << 3 * T * T, 4 * T * T * T,
            6 * T, 12 * T * T;
        Eigen::Vector2d b;
        b << v1 - v0 - a0 * T, a1 - a0;
        k.bottomRows(2) = A.lu().solve(b);
    }
    ~QuarticPolynomial(){};
    double calc_xt(double t)
    {
        
        t_vec << 1, t, pow(t, 2), pow(t, 3), pow(t, 4);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_dxt(double t)
    {
        
        t_vec << 0, 1, 2 * t, 3 * pow(t, 2), 4 * pow(t, 3);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_ddxt(double t)
    {
        
        t_vec << 0, 0, 2, 6 * t, 12 * pow(t, 2);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_dddxt(double t)
    {
        
        t_vec << 0, 0, 0, 6 , 24 * t;
        return (k.transpose() * t_vec)(0, 0);
    }
};


// //五次多项式
// //x(t) = k0 + k1*t + k2*t^2 + k3*t^3 + k4*t^4　+ k5*t^5
class QuinticPolynomial
{
private:
    Eigen::Matrix<double, 6, 1> k; 
    Eigen::Matrix<double, 6, 1> t_vec;

public:
    QuinticPolynomial(double x0, double v0, double a0, double x1, double v1, double a1, double T)
    {
        
        k(0) = x0;
        k(1) = v0;
        k(2) = a0 / 2;

        Eigen::Matrix3d A;
        A << pow(T,3),   pow(T,4),    pow(T,5),
             3*pow(T,2), 4*pow(T,3),  5*pow(T,4),
             6*T,        12*pow(T,2), 20*pow(T,3);

        Eigen::Vector3d b;
        b << x1-x0-v0*T - a0*pow(T,2)/2, v1-v0-a0*T, a1-a0;
        k.bottomRows(3) = A.lu().solve(b);
    }
    ~QuinticPolynomial(){};
    double calc_xt(double t)
    {
        
        t_vec << 1, t, pow(t, 2), pow(t, 3), pow(t, 4), pow(t,5);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_dxt(double t)
    {
        
        t_vec << 0, 1, 2 * t, 3 * pow(t, 2), 4 * pow(t, 3), 5*pow(t,4);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_ddxt(double t)
    {
        
        t_vec << 0, 0, 2, 6 * t, 12 * pow(t, 2),20*pow(t,3);
        return (k.transpose() * t_vec)(0, 0);
    }

    double calc_dddxt(double t)
    {
        
        t_vec << 0, 0, 0, 6 , 24 * t,60*pow(t,2);
        return (k.transpose() * t_vec)(0, 0);
    }
};
