#include "lattice_planner.h"
#include "polynomial.h"
#include "string"
#include <numeric>
#include "swTimer.h"
#include "math.h"

#include <spdlog/spdlog.h>
//路径排序
bool smp(SLPath path1, SLPath path2)
{
    return path1.cost < path2.cost;
}

bool first_pose = true;
LatticePlanner::LatticePlanner(std::shared_ptr<WorldOccupancyMap> local_map)
{

    this->local_map_ = local_map;
    cd_ = new CollisionDetector(local_map_.get());
    forward_ = true;
};

LatticePlanner::~LatticePlanner(){
    delete cd_;
};

bool LatticePlanner::setRefLine(mpac_generic::Path path)
{
    origin_path.clear();
    origin_path = path;
    spdlog::info("Set ref line with {} points!", path.poses.size());

    std::vector<double> x;
    std::vector<double> y;

    for (size_t i = 0; i < path.sizePose2d(); i++)
    {
        x.push_back(path.poses[i](0));
        y.push_back(path.poses[i](1));
    }

    if (path.sizePose2d() == 2)
    {
        std::vector<double> x_insert;
        std::vector<double> y_insert;
        int num_insert = 2;
        double x_increment = (x.back() - x.front()) / (num_insert + 1);
        double y_increment = (y.back() - y.front()) / (num_insert + 1);
        for (size_t i = 0; i < num_insert; i++)
        {
            x_insert.push_back(x.front() + x_increment * (i + 1));
            y_insert.push_back(y.front() + y_increment * (i + 1));
        }

        x.insert(x.begin() + 1, x_insert.begin(), x_insert.end());
        y.insert(y.begin() + 1, y_insert.begin(), y_insert.end());
    }

    if (x.size() < 3 || y.size() < 3)
    {
        spdlog::warn("The number of reference points is less than 3!!!!!!!!");
        return false;
    }

    spline_.set_points(x, y);

    last_ref_point_ = spline_.getMinS();

    forward_ = path.pointTypes.back().forward_;

    return true;
   
}

mpac_generic::State2dControl LatticePlanner::SL2XY(SLPose sl_state)
{
    //计算参考点位姿
    double r_x, r_y, r_yaw, r_k;
    spline_.getValue(sl_state.s, r_x, r_y);
    r_yaw = spline_.calcYaw(sl_state.s);
    r_k = spline_.calcCurvature(sl_state.s);

    double x = r_x - sl_state.l * sin(r_yaw);
    double y = r_y + sl_state.l * cos(r_yaw);

    double yaw = atan(sl_state.l_v / (1 - r_k * sl_state.l)) + r_yaw;
    yaw = atan2(sin(yaw), cos(yaw));
    double v = sqrt(pow(sl_state.s_v * (1 - r_k * sl_state.l), 2));

    mpac_generic::State2dControl xy_state;
    xy_state.pose = mpac_generic::Pose2d(x, y, yaw);
    xy_state.v = v;

    return xy_state;
}

SLPose LatticePlanner::XY2SL(mpac_generic::State2dControl currrent_state)
{
    double x, y, yaw, v;

    x = currrent_state.pose(0);
    y = currrent_state.pose(1);
    yaw = currrent_state.pose(2);
    v = currrent_state.v;

    //寻找参考点
    double s_r = spline_.findClosestPoint(x, y, last_ref_point_);
    last_ref_point_ = s_r;

    //计算参考点处的坐标、方向、曲率
    double x_r, y_r, yaw_r, curv_r;
    spline_.getValue(s_r, x_r, y_r);
    yaw_r = spline_.calcYaw(s_r);
    curv_r = spline_.calcCurvature(s_r);

    SLPose pose_sl;

    pose_sl.s = s_r;
    pose_sl.l = mpac_generic::sign((y - y_r) * cos(yaw_r) - (x - x_r) * sin(yaw_r)) * hypot((x - x_r), (y - y_r));
    pose_sl.l_v = v * sin(yaw - yaw_r);
    pose_sl.s_v = v * cos(yaw - yaw_r) / (1 - curv_r * pose_sl.l);
    pose_sl.yaw_ = atan2(sin(yaw - yaw_r),cos(yaw - yaw_r));

    return pose_sl;
}

mpac_generic::Pose2d LatticePlanner::getRefPoint(mpac_generic::Pose2d current_pose)
{
    double x, y, yaw;

    x = current_pose(0);
    y = current_pose(1);
    yaw = current_pose(2);

    //寻找参考点
    double s_r = spline_.findClosestPoint(x, y, last_ref_point_);
    last_ref_point_ = s_r;
    
    //计算参考点处的坐标、方向、曲率
    double x_r, y_r, yaw_r, curv_r;
    spline_.getValue(s_r, x_r, y_r);
    yaw_r = spline_.calcYaw(s_r);
    curv_r = spline_.calcCurvature(s_r);

    mpac_generic::Pose2d ref_pose;
    ref_pose(0) = x_r;
    ref_pose(1) = y_r;
    ref_pose(2) = yaw_r;
    return ref_pose;
}

double LatticePlanner::getResidualDistance(mpac_generic::State2dControl current_state)
{

    double x, y;
    x = current_state.pose(0);
    y = current_state.pose(1);
    double s_r = spline_.findClosestPoint(x, y, last_ref_point_);
    last_ref_point_ = s_r;

    return (spline_.getMaxS() - s_r);
}

std::vector<SLPath> LatticePlanner::samplePathsForCruising(mpac_generic::State2dControl current_state)
{

    SLPose sl0 = XY2SL(current_state);

    double dis_left = spline_.getMaxS() - sl0.s;

    std::vector<SLPath> paths;

    double targetSpeed = CP::localPlanParameters.target_speed;
    
    double min_pre_dis = 0.5 * current_state.v*current_state.v  / CP::max_linearAcceleration + 2;
    double max_pre_dis = 0.5 * current_state.v*current_state.v / CP::max_linearAcceleration + 4;

    //保证采样轨迹不出界
    min_pre_dis = std::min(min_pre_dis,dis_left);
    max_pre_dis = std::min(max_pre_dis,dis_left);

 
    // spdlog::info("sample local trajectry from min_pre_dis {} to max_pre_dis {}",min_pre_dis,max_pre_dis);
    for (double s_all = min_pre_dis; s_all <= max_pre_dis+0.01; s_all = s_all + 1)
    {

        //生成纵向轨迹
        std::vector<double> path_pre_t;
        SLPath path_pre;

        double s_traveled = 0.0;

        double t = 0.0;
        double v = fabs(sl0.s_v);

        int adj_time = 0;
        double  adj_dis = s_all/2;
        bool adj_finish = false;

        while (s_traveled < s_all)
        {

            // v = (sl0.s_v - CP::max_linearVelocity) * cos((s_traveled / s_all * M_PI_2)) + CP::max_linearVelocity;
            if ((v - targetSpeed) > 0.1)
            {
                v = v - 0.1;
            }
            if ((v - targetSpeed) < (-0.1))
            {
                v = v + 0.1;
            }

            path_pre_t.push_back(t);
            path_pre.s_.push_back(s_traveled + sl0.s);
            path_pre.s_v.push_back(v);

            s_traveled = s_traveled + v * SAMPLING_PERIOD_SEC;

                if(!adj_finish){

        if(s_traveled>adj_dis){
            adj_dis = s_traveled;
            adj_time = path_pre.s_.size();
            adj_finish = true;
        }
    }
            t = t + SAMPLING_PERIOD_SEC;
        }
        //加速度
        for (size_t i = 0; i < path_pre.s_v.size() - 1; i++)
        {
            path_pre.s_a.push_back((path_pre.s_v[i + 1] - path_pre.s_v[i]) / SAMPLING_PERIOD_SEC);
        }
        path_pre.s_a.push_back(0.0);

        //加加速度
        for (size_t i = 0; i < path_pre.s_a.size() - 1; i++)
        {
            path_pre.s_jerk.push_back((path_pre.s_a[i + 1] - path_pre.s_a[i]) / SAMPLING_PERIOD_SEC);
        }
        path_pre.s_jerk.push_back(0.0);

        double max_width_sample = CP::avoid_mode == 1  ? 0.0 : CP::localPlanParameters.max_width_sample;
        for (double l1 = -max_width_sample; l1 <= max_width_sample; l1 = l1 + CP::localPlanParameters.step_width_sample)
        {
            //生成横向轨迹
            QuinticPolynomial path_lat(sl0.l, sl0.l_v, sl0.l_a, l1, 0, 0, path_pre_t.back() / 2);

            // QuinticPolynomial path_sl(sl0.l, sl0.yaw_, 0.0, l1, 0, 0, adj_dis);

            double T = 1 / SAMPLING_PERIOD_SEC;
            vector<double> sample_l;

            for (size_t i = 0; i < adj_time; i++)
            {
                sample_l.push_back((sl0.l - l1) * (cos((path_pre.s_[i] - path_pre.s_[0]) /adj_dis * M_PI)+1)/2.0 + l1);
                // sample_l.push_back(path_sl.calc_xt(path_pre.s_[i] - path_pre.s_[0]));
            }

            SLPath path;
            path.t_ = path_pre_t;
            path.s_ = path_pre.s_;
            path.s_v = path_pre.s_v;
            path.s_a = path_pre.s_a;
            path.s_jerk = path_pre.s_jerk;

            for (size_t i = 0; i < path_pre_t.size(); i++)
            {

                if (i < adj_time)
                {
                    path.l_.push_back(sample_l[i]);
                }
                else
                {
                    path.l_.push_back(l1);
                }

            }

            for (size_t i = 0; i < path_pre_t.size() - 1; i++)
            {
                path.l_v.push_back((path.l_[i + 1] - path.l_[i]) / SAMPLING_PERIOD_SEC);
            }
            path.l_v.push_back(0.0);

            for (size_t i = 0; i < path_pre_t.size() - 1; i++)
            {
                path.l_a.push_back((path.l_v[i + 1] - path.l_v[i]) / SAMPLING_PERIOD_SEC);
            }
            path.l_a.push_back(0.0);

            for (size_t i = 0; i < path_pre_t.size() - 1; i++)
            {
                path.l_jerk.push_back((path.l_a[i + 1] - path.l_a[i]) / SAMPLING_PERIOD_SEC);
            }
            path.l_jerk.push_back(0.0);

            //将Frenet坐标系下轨迹合成到ｘ_y坐标系下

            double dis_min = 2.0;
            for (size_t i = 0; i < path_pre_t.size(); i++)
            {
                mpac_generic::State2dControl xy_state;
                SLPose sl_state;
                sl_state.s = path.s_[i];
                sl_state.s_v = path.s_v[i];
                sl_state.l = path.l_[i];
                sl_state.l_v = path.l_v[i];

                xy_state = SL2XY(sl_state);
                path.x_.push_back(xy_state.pose(0));
                path.y_.push_back(xy_state.pose(1));
                path.yaw_.push_back(xy_state.pose(2));
                
                double disObs = local_map_->getShortestDistanceFromObstacles(xy_state.pose);
                if (dis_min>disObs)
                {
                    dis_min = disObs;
                }
                
            }
            path.min_dis_obs = std::min({dis_min,0.6});
            calcYawCurvDs(path.x_, path.y_, path.yaw_, path.curv_, path.ds_);

            //计算路径代价值
            double l_jerk_sum = 0.0; //加加速度
            double s_jerk_sum = 0.0; //加加速度

            for (size_t i = 0; i < path_pre_t.size(); i++)
            {
                l_jerk_sum = l_jerk_sum + path.l_jerk[i];
                s_jerk_sum = s_jerk_sum + path.s_jerk[i];
            }

            l_jerk_sum = l_jerk_sum / path_pre_t.size();
            s_jerk_sum = s_jerk_sum / path_pre_t.size();

            path.offset = l1;
            path.jerk = fabs(l_jerk_sum);
            path.dis = s_all;

            paths.push_back(path);
        }
    }
    // }
    return paths;
}

std::vector<SLPath> LatticePlanner::samplePathsForStopping(mpac_generic::State2dControl current_state)
{

    SLPose sl0 = XY2SL(current_state);

    std::vector<SLPath> paths;

    std::vector<double> path_pre_t;
    SLPath path_pre;

    double t = 0.0;
    double v = fabs(sl0.s_v);
    double s0 = sl0.s;
    double s_all = spline_.getMaxS() - sl0.s;
    double s_traveled = 0.0;

    int adj_time = 0;
    double  adj_dis = s_all/2.0;
    bool adj_finish = false;



    while (s_traveled < s_all)
    {

        v = 1.0 * cos((s_traveled / s_all * M_PI_2));
        if (fabs(v) < 0.1)
        {
            v = 0.1;
        }

        path_pre_t.push_back(t);
        path_pre.s_.push_back(s_traveled + sl0.s);
        path_pre.s_v.push_back(v);

        s_traveled = s_traveled + v * SAMPLING_PERIOD_SEC;

        if(!adj_finish){

            if(s_traveled>adj_dis){
                adj_dis = s_traveled;
                adj_time = path_pre.s_.size();
                adj_finish = true;
            }
        }

        t = t + SAMPLING_PERIOD_SEC;
    }
    if (path_pre_t.size() < 1)
    {
        path_pre_t.push_back(t);
        path_pre.s_.push_back(s_traveled + sl0.s);
        path_pre.s_v.push_back(0.05);

        t = t + SAMPLING_PERIOD_SEC;
    }
    path_pre_t.push_back(t);
    path_pre.s_v.push_back((spline_.getMaxS() - path_pre.s_.back()) / SAMPLING_PERIOD_SEC);
    path_pre.s_.push_back(spline_.getMaxS());

    //加速度
    for (size_t i = 0; i < path_pre_t.size() - 1; i++)
    {
        path_pre.s_a.push_back((path_pre.s_v[i + 1] - path_pre.s_v[i]) / SAMPLING_PERIOD_SEC);
    }
    path_pre.s_a.push_back(0.0);

    //加加速度
    for (size_t i = 0; i < path_pre_t.size() - 1; i++)
    {
        path_pre.s_jerk.push_back((path_pre.s_a[i + 1] - path_pre.s_a[i]) / SAMPLING_PERIOD_SEC);
    }
    path_pre.s_jerk.push_back(0.0);


    double l1 = 0;
    {
        //生成横向轨迹
        double T = 1 / SAMPLING_PERIOD_SEC;
        QuinticPolynomial path_lat(sl0.l, sl0.l_v, sl0.l_a, l1, 0.0, 0.0, path_pre_t.back() / 2);
        
        vector<double> sample_l;

        for (size_t i = 0; i < adj_time; i++)
        {
            sample_l.push_back((sl0.l - l1) * (cos((path_pre.s_[i] - path_pre.s_[0]) /adj_dis * M_PI)+1)/2.0 + l1);
        }
        SLPath path;
        path.t_ = path_pre_t;
        path.s_ = path_pre.s_;
        path.s_v = path_pre.s_v;
        path.s_a = path_pre.s_a;
        path.s_jerk = path_pre.s_jerk;

        for (size_t i = 0; i < path_pre_t.size(); i++)
        {

            if (i <adj_time)
            {
                path.l_.push_back(sample_l[i]);
            }
            else
            {
                path.l_.push_back(l1);
            }

        }

        for (size_t i = 0; i < path_pre_t.size() - 1; i++)
        {
            path.l_v.push_back((path.l_[i + 1] - path.l_[i]) / SAMPLING_PERIOD_SEC);
        }
        path.l_v.push_back(0.0);

        for (size_t i = 0; i < path_pre_t.size() - 1; i++)
        {
            path.l_a.push_back((path.l_v[i + 1] - path.l_v[i]) / SAMPLING_PERIOD_SEC);
        }
        path.l_a.push_back(0.0);

        for (size_t i = 0; i < path_pre_t.size() - 1; i++)
        {
            path.l_jerk.push_back((path.l_a[i + 1] - path.l_a[i]) / SAMPLING_PERIOD_SEC);
        }
        path.l_jerk.push_back(0.0);

        //将Frenet坐标系下轨迹合成到ｘ_y坐标系下
        double dis_min = 2.0;
        for (size_t i = 0; i < path_pre_t.size(); i++)
        {
            mpac_generic::State2dControl xy_state;
            SLPose sl_state;
            sl_state.s = path.s_[i];
            sl_state.s_v = path.s_v[i];
            sl_state.l = path.l_[i];
            sl_state.l_v = path.l_v[i];

            xy_state = SL2XY(sl_state);
            path.x_.push_back(xy_state.pose(0));
            path.y_.push_back(xy_state.pose(1));
            path.yaw_.push_back(xy_state.pose(2));
            
            double disObs = local_map_->getShortestDistanceFromObstacles(xy_state.pose);
            if (dis_min>disObs)
            {
                dis_min = disObs;
            }
                
        }
        path.min_dis_obs = std::min({dis_min,0.6});

        calcYawCurvDs(path.x_, path.y_, path.yaw_, path.curv_, path.ds_);

        //计算路径代价值
        double l_jerk_sum = 0.0; //加加速度
        double s_jerk_sum = 0.0; //加加速度

        for (size_t i = 0; i < path_pre_t.size(); i++)
        {
            l_jerk_sum = l_jerk_sum + path.l_jerk[i];
            s_jerk_sum = s_jerk_sum + path.s_jerk[i];
        }
        l_jerk_sum = l_jerk_sum / path_pre_t.size();
        // s_jerk_sum = s_jerk_sum / path_pre_t.size();

        path.offset = l1;
        path.jerk = fabs(l_jerk_sum);
        path.dis = s_all;

        paths.push_back(path);
    }

    return paths;
}

void LatticePlanner::calcYawCurvDs(std::vector<double> &x, std::vector<double> &y, std::vector<double> &yaw, std::vector<double> &curv, std::vector<double> &ds)
{

    int size = x.size();
    assert(size == y.size());
    assert(size >= 2);
    yaw.clear();

    double dx;
    double dy;
    for (size_t i = 1; i < size; i++)
    {
        dx = x[i] - x[i - 1];
        dy = y[i] - y[i - 1];
        ds.push_back(hypot(dx, dy));
        yaw.push_back(atan2(dy, dx));
    }

    ds.push_back(ds.back());
    yaw.push_back(yaw.back());

    for (size_t i = 1; i < size; i++)
    {
        curv.push_back((yaw[i] - yaw[i - 1]) / ds[i - 1]);
    }
}

bool LatticePlanner::getLocalTrajecoty(mpac_generic::State2dControl current_state, mpac_generic::Trajectory &traj, sampleMode mode)
{
    std::vector<SLPath> paths;
    swTimer timer;

    double stop_v = 0.0;
    double stop_w = 0.0;

    if (mode == sampleMode::STOPPING)
    {
        paths = samplePathsForStopping(current_state);
    }
    else
    {
        paths = samplePathsForCruising(current_state);
        stop_v = CP::move_direction ? CP::max_linearVelocity : CP::min_linearVelocity;
        stop_w = CP::max_angularVelocity;
    }
    if (paths.size() < 0)
    {
        SPDLOG_ERROR("Can not find local path!");
        return false;
    }
    timer.stop();
    // std::cout<<"采样时长："<<timer.get()<<std::endl;

    double max_jerk = 0.0;
    double max_dis_total = 0.0;
    double min_dis_total = 10.0;
    double max_offset = 0.0;
    double max_dis_obs = 0.0;

    //归一化处理
    for (size_t i = 0; i < paths.size(); i++)
    {
        max_jerk = std::max(max_jerk,paths[i].jerk);
        max_dis_total = std::max(max_dis_total,paths[i].dis);
        min_dis_total = std::min(min_dis_total,paths[i].dis);
        max_offset = std::max(max_offset,fabs(paths[i].offset));
        max_dis_obs = std::max(max_dis_obs,paths[i].min_dis_obs);
    }

    //计算每条轨迹cost
    for (size_t i = 0; i < paths.size(); i++)
    {
        paths[i].cost = 0.0;
        if(max_offset > 0.00001)
        {
            paths[i].cost = paths[i].cost + CP::localPlanParameters.w_offset * (fabs(paths[i].offset)/max_offset);
        }

        if(fabs(max_dis_total - min_dis_total)>0.00001)
        {
            paths[i].cost = paths[i].cost + CP::localPlanParameters.w_distance * ((max_dis_total - paths[i].dis) / (max_dis_total - min_dis_total));
        }

        if(fabs(max_jerk)>0.00001)
        {
            paths[i].cost = paths[i].cost + CP::localPlanParameters.w_jerk * (paths[i].jerk / max_jerk);
        }

        if(fabs(max_dis_obs)>0.00001)
        {
            paths[i].cost = paths[i].cost + CP::localPlanParameters.w_collision * ((max_dis_obs - paths[i].min_dis_obs) / max_dis_obs);
        }

        if(paths[i].offset > 0) {
            paths[i].cost = paths[i].cost * 1.2; //优先向右避障
        }
        
    }

 
    std::sort(paths.begin(), paths.end(), smp);

    for (size_t i = 0; i < paths.size(); i++)
    {

        /*碰撞检测*/
        // spdlog::info("cost:{}, offset:{}, jerk:{}, dis:{}, dis_obs:{}",paths[i].cost,paths[i].offset,paths[i].jerk,paths[i].dis,paths[i].min_dis_obs);
        if (travelFree(paths[i]))
        {
            double offset =fabs(paths[i].l_.back() - paths[i].l_.front());

            if(offset > 0.2)
            {
                CP::max_linearVelocity = 1.0;
            }

            swTimer timer_v;
            traj.clear();

            std::vector<double> x;
            std::vector<double> y;
            for (size_t j = 0; j < paths[i].ds_.size(); j++)
            {
                x.push_back(paths[i].x_[j]);
                y.push_back(paths[i].y_[j]);
            }
            // return true;
            if (x.size() < 3)
            {
                SPDLOG_WARN("The number of points is less than 3");
                //如果点数少于3个（当前位置在目标点附近），进行插值，以进行样条曲线拟合
                std::vector<double> x_insert;
                std::vector<double> y_insert;
                int num_insert = 2;
                double x_increment = (x.back() - x.front()) / (num_insert + 1);
                double y_increment = (y.back() - y.front()) / (num_insert + 1);
                for (size_t k = 0; k < num_insert; k++)
                {
                    x_insert.push_back(x.front() + x_increment * (k + 1));
                    y_insert.push_back(y.front() + y_increment * (k + 1));
                }

                x.insert(x.begin() + 1, x_insert.begin(), x_insert.end());
                y.insert(y.begin() + 1, y_insert.begin(), y_insert.end());
            }

            Spline2d spline;
            spline.set_points_no_print(x, y);

            double current_s = 0.0;
            double next_s = 0.0;
            double maxS = spline.getMaxS();
            double v, w;
            double x_cur, y_cur, yaw_cur;
            double x_next, y_next, yaw_next;
            yaw_cur = spline.calcYaw(current_s);
            
            // std::cout<<"path point curva:"<<std::endl;

            if (CP::move_direction == 0)
            {
                yaw_cur = atan2(sin(yaw_cur + M_PI), cos(yaw_cur + M_PI));
            }

            spline.getValue(current_s, x_cur, y_cur);

            //生成运动轨迹
            
            double max_v = CP::move_direction ? CP::max_linearVelocity : CP::min_linearVelocity;

            while (current_s < maxS)
            {
                double Curvature = spline.calcCurvature(current_s);
                //根据最终停止速度，自动调整当前速度，且保证满足加速度要求

                double v_slowDown = (max_v - stop_v) * cos((current_s / maxS * M_PI_2)) + stop_v;
                
                double v_Curv = CP::max_linearVelocity*exp(-1.2*fabs(Curvature));
                v = std::min({fabs(max_v),fabs(v_slowDown),v_Curv});

                if (v < 0.1)
                {
                    v = 0.1;
                }
                
                v = mpac_generic::sign(v_slowDown) * v;

                //当前速度下的下一个目标点
                double ds = fabs(v) * SAMPLING_PERIOD_SEC;
                spline.getValue(current_s + ds, x_next, y_next);
                yaw_next = spline.calcYaw(current_s + ds);
                if (CP::move_direction == 0)
                {
                    yaw_next = atan2(sin(yaw_next + M_PI), cos(yaw_next + M_PI));
                }

                double yaw_error = yaw_next - yaw_cur;
                yaw_error = atan2(sin(yaw_error), cos(yaw_error));

                w = yaw_error / SAMPLING_PERIOD_SEC;

                traj.addTrajectoryPoint(mpac_generic::Pose2d(x_cur, y_cur, yaw_cur), 0.0, v, w);

                x_cur = x_cur + v * SAMPLING_PERIOD_SEC * cos(yaw_cur);
                y_cur = y_cur + v * SAMPLING_PERIOD_SEC * sin(yaw_cur);
                yaw_cur = yaw_cur + w * SAMPLING_PERIOD_SEC;
                yaw_cur = atan2(sin(yaw_cur), cos(yaw_cur));

                current_s = current_s + ds;
            }   

            timer_v.stop();
            // std::cout<<"采样时长："<<timer_v.get()<<std::endl;
            return true;
        }
    }
    // ROS_INFO("get local traj fialed!");
    return false;
}

bool LatticePlanner::travelFree(SLPath &path)
{

    swTimer timer_cd;
    for (size_t i = 0; i < path.x_.size(); i++)
    {
        // mpac_generic::Pose2d pose;
        // pose.x() = path.x_[i];
        // pose.y() = path.y_[i];
        // pose.z() = path.yaw_[i];
        
        // if (!cd_->isCollisionFree(pose,CP::robot_width / 2, CP::robot_width / 2, CP::robot_length_frond, CP::robot_length_back))
        // {
        //     SPDLOG_WARN("Collision:({} {}) with dis {}", path.x_[i], path.y_[i], local_map_->getShortestDistanceFromObstacles(pose));
        //     return false;
        // }
        
        int x_cell, y_cell;
        local_map_->world2map(path.x_[i], path.y_[i], x_cell, y_cell);
        

        if (local_map_->getShortestDistanceFromObstacles(x_cell, y_cell) < (CP::robot_width / 2+0.05) || local_map_->getProhibitedValueInCell(x_cell, y_cell) > 0)
        {
            SPDLOG_WARN("Collision:({} {}) with dis {}", path.x_[i], path.y_[i], local_map_->getShortestDistanceFromObstacles(x_cell, y_cell));
            timer_cd.stop();
            // std::cout<<"路径检测时长_F："<<timer_cd.get()<<std::endl;
            return false;
        }
    }
            timer_cd.stop();
            // std::cout<<"路径检测时长_T："<<timer_cd.get()<<std::endl;
    return true;
}