#include "plane_ground_filter_core.h"

/*
    @brief Compare function to sort points. Here use z axis.
    @return z-axis accent
*/
bool point_cmp(VPoint a, VPoint b)
{
    return a.z < b.z;       
}
Eigen::Vector3f offset_cam;
Eigen::Quaternionf rotation_cam;

int sample_fps = 0;

PlaneGroundFilter::PlaneGroundFilter(ros::NodeHandle &nh)
{
    std::string input_topic;
    nh.getParam("input_topic", input_topic);
    sub_point_cloud_ = nh.subscribe(input_topic, 10, &PlaneGroundFilter::point_cb, this);
    //------------------------- lxf 测试 --------------------------------//
    // pub_points_filtered = nh.advertise<sensor_msgs::PointCloud2>("/lxf_points_filtered", 1); //lxf 测试加
    // init publisher
    std::string no_ground_topic, ground_topic, all_points_topic;

    nh.getParam("no_ground_point_topic", no_ground_topic);
    nh.getParam("ground_point_topic", ground_topic);
    nh.getParam("all_points_topic", all_points_topic);

    nh.getParam("clip_height", clip_height_);
    ROS_INFO("clip_height: %f", clip_height_);
    nh.getParam("sensor_height", sensor_height_);
    ROS_INFO("sensor_height: %f", sensor_height_);
    nh.getParam("min_distance", min_distance_);
    ROS_INFO("min_distance: %f", min_distance_);
    nh.getParam("max_distance", max_distance_);
    ROS_INFO("max_distance: %f", max_distance_);

    nh.getParam("sensor_model", sensor_model_);
    ROS_INFO("sensor_model: %d", sensor_model_);
    nh.getParam("num_iter", num_iter_);
    ROS_INFO("num_iter: %d", num_iter_);
    nh.getParam("num_lpr", num_lpr_);
    ROS_INFO("num_lpr: %d", num_lpr_);
    nh.getParam("th_seeds", th_seeds_);
    ROS_INFO("th_seeds: %f", th_seeds_);
    nh.getParam("th_dist", th_dist_);
    ROS_INFO("th_dist: %f", th_dist_);

    std::vector<float> transform_list;
    if (nh.getParam("Extri_T_baselink_camera", transform_list))
    {
        offset_cam << transform_list[0], transform_list[1], transform_list[2];
        rotation_cam = Eigen::Quaternionf(transform_list[3], transform_list[4], transform_list[5], transform_list[6]);
        ROS_INFO("Extri_T_baselink_camera: [%f  %f  %f  %f  %f  %f  %f ]", transform_list[0],transform_list[1],transform_list[2],transform_list[3],transform_list[4],transform_list[5],transform_list[6]);
    }
    else
    {
        offset_cam << 0.457, 0., 0.157;
        rotation_cam = Eigen::Quaternionf(0.509, -0.491, 0.491, -0.509);
        ROS_INFO("Extri_T_baselink_camera: default");  
    }

    pub_ground_ = nh.advertise<sensor_msgs::PointCloud2>(ground_topic, 10);
    pub_no_ground_ = nh.advertise<sensor_msgs::PointCloud2>(no_ground_topic, 10);
    pub_all_points_ = nh.advertise<sensor_msgs::PointCloud2>(all_points_topic, 10);

    g_seeds_pc = pcl::PointCloud<VPoint>::Ptr(new pcl::PointCloud<VPoint>);
    g_ground_pc = pcl::PointCloud<VPoint>::Ptr(new pcl::PointCloud<VPoint>);
    g_not_ground_pc = pcl::PointCloud<VPoint>::Ptr(new pcl::PointCloud<VPoint>);
    g_all_pc = pcl::PointCloud<SLRPointXYZIRL>::Ptr(new pcl::PointCloud<SLRPointXYZIRL>);
    ros::spin();
}
PlaneGroundFilter::~PlaneGroundFilter() {}
void PlaneGroundFilter::Spin()
{
}
void PlaneGroundFilter::clip_above(const pcl::PointCloud<VPoint>::Ptr in,
                                   const pcl::PointCloud<VPoint>::Ptr out)
{
    pcl::ExtractIndices<VPoint> cliper;
    cliper.setInputCloud(in);
    pcl::PointIndices indices;
#pragma omp for
    for (size_t i = 0; i < in->points.size(); i++)
    {
        if (in->points[i].z > clip_height_) 
        {
            indices.indices.push_back(i);
        }
    }
    cliper.setIndices(boost::make_shared<pcl::PointIndices>(indices));
    cliper.setNegative(true); //ture to remove the indices
    cliper.filter(*out);
}

void PlaneGroundFilter::remove_close_far_pt(const pcl::PointCloud<VPoint>::Ptr in,
                                            const pcl::PointCloud<VPoint>::Ptr out)
{
    pcl::ExtractIndices<VPoint> cliper;

    cliper.setInputCloud(in);
    pcl::PointIndices indices;
#pragma omp for
    for (size_t i = 0; i < in->points.size(); i++)
    {
        double distance = sqrt(in->points[i].x * in->points[i].x + in->points[i].y * in->points[i].y);  //y->z  lxf

        if ((distance < min_distance_) || (distance > max_distance_))
        {
            indices.indices.push_back(i);
        }
    }
    cliper.setIndices(boost::make_shared<pcl::PointIndices>(indices));
    cliper.setNegative(true); //ture to remove the indices
    cliper.filter(*out);
}

/*
    @brief The function to estimate plane model. The
    model parameter `normal_` and `d_`, and `th_dist_d_`
    is set here.
    The main step is performed SVD(UAV) on covariance matrix.
    Taking the sigular vector in U matrix according to the smallest
    sigular value in A, as the `normal_`. `d_` is then calculated 
    according to mean ground points.

    @param g_ground_pc:global ground pointcloud ptr.
    
*/
void PlaneGroundFilter::estimate_plane_(void)
{
    // Create covarian matrix in single pass.
    // TODO: compare the efficiency.
    Eigen::Matrix3f cov;
    Eigen::Vector4f pc_mean;
    pcl::computeMeanAndCovarianceMatrix(*g_ground_pc, cov, pc_mean);
    // Singular Value Decomposition: SVD
    JacobiSVD<MatrixXf> svd(cov, Eigen::DecompositionOptions::ComputeFullU);
    // use the least singular vector as normal
    normal_ = (svd.matrixU().col(2));
    // mean ground seeds value
    Eigen::Vector3f seeds_mean = pc_mean.head<3>();

    // according to normal.T*[x,y,z] = -d
    d_ = -(normal_.transpose() * seeds_mean)(0, 0);
    // set distance threhold to `th_dist - d`
    th_dist_d_ = th_dist_ - d_;

    // return the equation parameters
}

/*
    @brief Extract initial seeds of the given pointcloud sorted segment.
    This function filter ground seeds points accoring to heigt.
    This function will set the `g_ground_pc` to `g_seed_pc`.
    @param p_sorted: sorted pointcloud
    
    @param ::num_lpr_: num of LPR points
    @param ::th_seeds_: threshold distance of seeds
    @param ::
*/
void PlaneGroundFilter::extract_initial_seeds_(const pcl::PointCloud<VPoint> &p_sorted)
{
    // LPR is the mean of low point representative
    double sum = 0;
    int cnt = 0;
    // Calculate the mean height value.
    for (int i = 0; i < p_sorted.points.size() && cnt < num_lpr_; i++)
    {
        sum += p_sorted.points[i].z;                                     
        cnt++;
    }
    double lpr_height = cnt != 0 ? sum / cnt : 0; // in case divide by 0        求均值
    g_seeds_pc->clear();
    // iterate pointcloud, filter those height is less than lpr.height+th_seeds_
    for (int i = 0; i < p_sorted.points.size(); i++)                //迭代，过滤点云数据
    {
        if (p_sorted.points[i].z < lpr_height + th_seeds_)    
        {
            g_seeds_pc->points.push_back(p_sorted.points[i]);
        }
    }
    // return seeds points
}

void PlaneGroundFilter::post_process(const pcl::PointCloud<VPoint>::Ptr in, const pcl::PointCloud<VPoint>::Ptr out)
{
    pcl::PointCloud<VPoint>::Ptr cliped_pc_ptr(new pcl::PointCloud<VPoint>);
    clip_above(in, cliped_pc_ptr);
    pcl::PointCloud<VPoint>::Ptr remove_close(new pcl::PointCloud<VPoint>);
    remove_close_far_pt(cliped_pc_ptr, out);
}

//源码
void PlaneGroundFilter::point_cb(const sensor_msgs::PointCloud2ConstPtr &in_cloud_ptr)
{
    sample_fps++;
    if(sample_fps < 3){
        return;
    };
    sample_fps = 0;

    // 1.Msg to pointcloud
    pcl::PointCloud<VPoint> cameraCloudIn;
    pcl::fromROSMsg(*in_cloud_ptr, cameraCloudIn);
    
    pcl::PointCloud<VPoint> cameraCloudFilterByZ;
    for (size_t i = 0; i < cameraCloudIn.points.size(); i++)
    {
        if(cameraCloudIn.points[i].z > 3 || fabs(cameraCloudIn.points[i].x) > 1 || cameraCloudIn.points[i].y > 0.28)
        {
            continue ;
        }
        if((cameraCloudIn.points[i].z * (-0.45) + 0.08< cameraCloudIn.points[i].y))// && (cameraCloudIn.points[i].z * 0.94 > fabs(cameraCloudIn.points[i].x) )
        {
        cameraCloudFilterByZ.points.push_back(cameraCloudIn.points[i]);
        }
    }
    // pcl::PointCloud<VPoint> cameraCloudIn_org;
    // pcl::fromROSMsg(*in_cloud_ptr, cameraCloudIn_org);
    // For mark ground points and hold all points

    // Pointcloud to baselink
    pcl::PointCloud<VPoint> laserCloudIn;
    pcl::transformPointCloud(cameraCloudFilterByZ, laserCloudIn, offset_cam, rotation_cam);
    pcl::PointCloud<VPoint> laserCloudIn_org;
    pcl::transformPointCloud(cameraCloudFilterByZ, laserCloudIn_org, offset_cam, rotation_cam);

    SLRPointXYZIRL point;
    // for (size_t i = 0; i < laserCloudIn.points.size(); i++)
    // {
    //     point.x = laserCloudIn.points[i].x;
    //     point.y = laserCloudIn.points[i].y;
    //     point.z = laserCloudIn.points[i].z;
    //     // point.intensity = laserCloudIn.points[i].intensity;
    //     // point.ring = laserCloudIn.points[i].ring;
    //     point.label = 0u; // 0 means uncluster
    //     g_all_pc->points.push_back(point);
    // }
    //std::vector<int> indices;
    //pcl::removeNaNFromPointCloud(laserCloudIn, laserCloudIn,indices);
    // 2.Sort on Z-axis value.
    sort(laserCloudIn.points.begin(), laserCloudIn.end(), point_cmp);

    // 3.Error point removal
    // As there are some error mirror reflection under the ground,
    // here regardless point under 2* sensor_height
    // Sort point according to height, here uses z-axis in default
    pcl::PointCloud<VPoint>::iterator it = laserCloudIn.points.begin();
    for (int i = 0; i < laserCloudIn.points.size(); i++)
    {
        if (laserCloudIn.points[i].z < -1.5 * sensor_height_)  
        {
            it++;
        }
        else
        {
            break;
        }
    }
    laserCloudIn.points.erase(laserCloudIn.points.begin(), it);//擦除点   //第一次过滤   距离的过滤
    // 4. Extract init ground seeds.
    extract_initial_seeds_(laserCloudIn);               //第二次过滤  擦除使用均值  得到g_seeds_pc
    g_ground_pc = g_seeds_pc;
    // 5. Ground plane fitter mainloop
    for (int i = 0; i < num_iter_; i++)         //第三次滤波
    {
        estimate_plane_();
        g_ground_pc->clear();
        g_not_ground_pc->clear();

        //pointcloud to matrix
        MatrixXf points(laserCloudIn_org.points.size(), 3);
        int j = 0;
        for (auto p : laserCloudIn_org.points)
        {
            points.row(j++) << p.x, p.y, p.z;
        }
        // ground plane model
        VectorXf result = points * normal_;
        // threshold filter
        for (int r = 0; r < result.rows(); r++)
        {
            if (result[r] < th_dist_d_)
            {
                // g_all_pc->points[r].label = 1u; // means ground
                g_ground_pc->points.push_back(laserCloudIn_org[r]);
            }
            else
            {
                // g_all_pc->points[r].label = 0u; // means not ground and non clusterred
                g_not_ground_pc->points.push_back(laserCloudIn_org[r]);
            }
        }
    }

    pcl::PointCloud<VPoint>::Ptr final_no_ground(new pcl::PointCloud<VPoint>);
    post_process(g_not_ground_pc, final_no_ground);
    
    // ROS_INFO_STREAM("origin: "<<g_not_ground_pc->points.size()<<" post_process: "<<final_no_ground->points.size());

    // publish ground points
    sensor_msgs::PointCloud2 ground_msg;
    pcl::toROSMsg(*g_ground_pc, ground_msg);
    ground_msg.header.stamp = in_cloud_ptr->header.stamp;
    ground_msg.header.frame_id = "base_link";
    pub_ground_.publish(ground_msg);

    // publish not ground points
    sensor_msgs::PointCloud2 groundless_msg;
    pcl::toROSMsg(*final_no_ground, groundless_msg);
    groundless_msg.header.stamp = in_cloud_ptr->header.stamp;
    groundless_msg.header.frame_id = "base_link";
    pub_no_ground_.publish(groundless_msg);

    // publish all points
    // sensor_msgs::PointCloud2 all_points_msg;
    // pcl::toROSMsg(*g_all_pc, all_points_msg);
    // all_points_msg.header.stamp = in_cloud_ptr->header.stamp;
    // all_points_msg.header.frame_id = "base_link";
    // pub_all_points_.publish(all_points_msg);
    // g_all_pc->clear();
}
