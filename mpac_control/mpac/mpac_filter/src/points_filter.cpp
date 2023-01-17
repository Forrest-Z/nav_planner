#include "points_filter.h"

PointsFilter::PointsFilter()
{
}
PointsFilter::~PointsFilter()
{
}

void PointsFilter::Run()
{

  // this->listener = new tf::TransformListener();
  node_fliter.getParam("CamPoint_enable", cam_points_enable);

  sub_laser_points = node_fliter.subscribe("/scan_matched_points2", 10, &PointsFilter::LaserPointsCallBack, this);

   if(cam_points_enable){
      sub_cam_points = node_fliter.subscribe("/points_no_ground",1,&PointsFilter::CamPointsCallBack,this);
   }

  // sub_laser_scan = node_fliter.subscribe("/base_scan", 1, &PointsFilter::LaserScanCallBack, this);

  pub_points_filtered = node_fliter.advertise<sensor_msgs::PointCloud2>("laser_points_filtered", 1);

  point_cloud_publisher_ = node_fliter.advertise<sensor_msgs::PointCloud2>("camera_points_filtered", 1, false);

//   std::vector<float> transform_list;
//   if (node_fliter.getParam("Extri_T_baselink_camera", transform_list) && transform_list.size() == 7)
//   {
//     offset_cam << transform_list[0], transform_list[1], transform_list[2];
//     rotation_cam = Eigen::Quaternionf(transform_list[3], transform_list[4], transform_list[5], transform_list[6]);
//   }
//   else
//   {
//     offset_cam << 0.44, 0., 0.23;
//     rotation_cam = Eigen::Quaternionf(0.455, -0.542, 0.542, -0.455);
//   }
//      offset_cam << 0.0, 0., 0.0;
//      rotation_cam = Eigen::Quaternionf(0.0, -0.0, 1.0, 0.0);

  node_fliter.getParam("CamPoint_enable", cam_points_enable);

  downsampling = 0;

  last_time = ros::Time::now();
  isGetCamPoints = false;

  base_link = "base_link";
}

void PointsFilter::LaserPointsCallBack(sensor_msgs::PointCloud2ConstPtr msg)
{

  //降低采样频率
  downsampling--;
  if (downsampling > 0)
  {
     return ;
  }
  downsampling = 3;
  
  //点云格式转换
  pcl::PointCloud<pcl::PointXYZ> LaserCloudIn;
  pcl::fromROSMsg(*msg, LaserCloudIn);

  if(LaserCloudIn.points.size()<5)
  {
    return;
  }

  // pcl::PCLPointCloud2 cloud_temp; //原始的点云的数据格式
  // pcl_conversions::toPCL(*msg, cloud_temp);
  // pcl::fromPCLPointCloud2(cloud_temp, pointscloud_laser);

  // if (cam_points_enable && isGetCamPoints && ((ros::Time::now().toSec() - last_time.toSec()) < 0.3))
  // {
  //   for (size_t i = 0; i < pointscloud_camera.size(); i++)
  //   {
  //     pointscloud_laser.points.push_back(pointscloud_camera.points[i]);
  //   }
  //   pointscloud_laser.width = pointscloud_laser.width + pointscloud_camera.size();
  // }

    // pcl::PointCloud<pcl::PointXYZ> points_filtered;
    // for (size_t i = 0; i < pointscloud_laser.points.size(); i++)
    // {
    //   pcl::PointXYZ pt = pointscloud_laser.points[i];
    //   points_filtered.push_back(pt);

    // }
    // sensor_msgs::PointCloud2 pointcloud_filtered;
    // pointcloud_filtered.header.stamp = ros::Time::now();
    // pcl::toROSMsg(points_filtered, pointcloud_filtered);
    // pointcloud_filtered.header.frame_id = "map";
    // this->pub_points_filtered.publish(pointcloud_filtered);

    // 距离滤波  截取车体中心周围4*4的激光点
    if (this->listener.canTransform("map", base_link, ros::Time()))
    {
      geometry_msgs::PoseStamped base_link_pose;
      base_link_pose.header.frame_id = base_link;

      base_link_pose.header.stamp = ros::Time();
      base_link_pose.pose.position.x = 0.0;
      base_link_pose.pose.position.y = 0.0;
      base_link_pose.pose.position.z = 0.0;
      base_link_pose.pose.orientation.x = 0.0;
      base_link_pose.pose.orientation.y = 0.0;
      base_link_pose.pose.orientation.z = 0.0;
      base_link_pose.pose.orientation.w = 1.0;
      try
      {
        geometry_msgs::PoseStamped pose_stamped;
        this->listener.transformPose("map", base_link_pose, pose_stamped);
        double x_l = pose_stamped.pose.position.x - 4;
        double x_u = pose_stamped.pose.position.x + 4;
        double y_l = pose_stamped.pose.position.y - 4;
        double y_u = pose_stamped.pose.position.y + 4;

        pcl::PointCloud<pcl::PointXYZ> pointsFilteredByXYZ;
        for (size_t i = 0; i < LaserCloudIn.points.size(); i++)
        {
          pcl::PointXYZ pt = LaserCloudIn.points[i];
          if ((pt.x > x_l) && (pt.x < x_u) && (pt.y > y_l) && (pt.y < y_u))
          {
            pointsFilteredByXYZ.push_back(pt);
          }
        }

        //噪点滤波
        if(pointsFilteredByXYZ.points.size()<1)
        {
          return;
        }
        pcl::RadiusOutlierRemoval<pcl::PointXYZ> filter;
        pcl::PointCloud<pcl::PointXYZ>::Ptr ptr_cloud(new pcl::PointCloud<pcl::PointXYZ>);
        *ptr_cloud = pointsFilteredByXYZ;
        filter.setInputCloud(ptr_cloud);
        filter.setRadiusSearch(0.1);
        filter.setMinNeighborsInRadius(3);
        pcl::PointCloud<pcl::PointXYZ> pointsFiltered;
        filter.filter(pointsFiltered);

        sensor_msgs::PointCloud2 pointcloud_filtered;
        pointcloud_filtered.header.stamp = ros::Time::now();
        pcl::toROSMsg(pointsFiltered, pointcloud_filtered);
        pointcloud_filtered.header.frame_id = "map";
        this->pub_points_filtered.publish(pointcloud_filtered);

      }
      catch (tf::TransformException &ex)
      {
        ROS_ERROR("Received an exception trying to transform a point from \"base_link\" to \"map\": %s", ex.what());
      }
    }
 
}
void PointsFilter::LaserScanCallBack(sensor_msgs::LaserScanConstPtr msg)
{

  sensor_msgs::PointCloud2 cloud;

  if (!listener.waitForTransform(
          "base_laser_link",
          "map",
          msg->header.stamp + ros::Duration().fromSec(0.1),
          ros::Duration(1)))
  {
    return;
  }
  projector_.transformLaserScanToPointCloud("map", *msg, cloud, listener);
  point_cloud_publisher_.publish(cloud);
}

void PointsFilter::CamPointsCallBack(sensor_msgs::PointCloud2ConstPtr msg)
{

  //降采样
  downsampling++;
  if (downsampling < 2)
  {
    return;
  }
  downsampling = 0;

  pcl::PointCloud<pcl::PointXYZ> cameraCloudIn;
  pcl::fromROSMsg(*msg, cameraCloudIn);
  if(cameraCloudIn.points.size()<5)
  {
    return;
  }

  //点云格式转换
  pcl::PCLPointCloud2 *cloud_temp = new pcl::PCLPointCloud2; //原始的点云的数据格式
  pcl_conversions::toPCL(*msg, *cloud_temp);

  //体素滤波
  pcl::PCLPointCloud2ConstPtr cloudPtr(cloud_temp);
  pcl::PCLPointCloud2 cloud_filter;
  pcl::VoxelGrid<pcl::PCLPointCloud2> sor;
  sor.setInputCloud(cloudPtr);       //设置输入的滤波，将需要过滤的点云给滤波对象
  sor.setLeafSize(0.02, 0.02, 0.02); //设置滤波时创建的体素大小为2cm立方体
  sor.filter(cloud_filter);          //执行滤波处理，存储输出cloud_filtered

  //pointcloud2  转 pointcloud
  pcl::PointCloud<pcl::PointXYZ> cloud_baselink;
  pcl::fromPCLPointCloud2(cloud_filter, cloud_baselink);

  //压缩前离群点噪点滤波
  pcl::RadiusOutlierRemoval<pcl::PointXYZ> filter_f;  //移除离群点
  pcl::PointCloud<pcl::PointXYZ>::Ptr ptr_cloud_f(new pcl::PointCloud<pcl::PointXYZ>);
  *ptr_cloud_f = cloud_baselink;
  cloud_baselink.clear();
  filter_f.setInputCloud(ptr_cloud_f);
  filter_f.setRadiusSearch(0.1);//设置在0.1的半径内找临近点
  filter_f.setMinNeighborsInRadius(8);//设置查询点的邻近点集数小于5的删除
  filter_f.filter(cloud_baselink);



 //范围滤波
  pcl::PointCloud<pcl::PointXYZ> cloud_baselink_filter;
  for (size_t i = 0; i < cloud_baselink.points.size(); i++)
  {
    if (((cloud_baselink.points[i].x) > 0.8) && (cloud_baselink.points[i].x < 3.5) && (fabs(cloud_baselink.points[i].y) < 0.4) && ((cloud_baselink.points[i].z) > 0.06) && (cloud_baselink.points[i].z < 1.6) )
    {
      cloud_baselink.points[i].z = 0.0;
      cloud_baselink_filter.points.push_back(cloud_baselink.points[i]);
    }
  }
  if (cloud_baselink_filter.points.size() < 1)
  {
    return;
  }
  // //压缩后去噪点  
  // pcl::PointCloud<pcl::PointXYZ> cloud_filter_plane;
  // pcl::VoxelGrid<pcl::PointXYZ> filter_p;
  // pcl::PointCloud<pcl::PointXYZ>::Ptr ptr_cloud_p(new pcl::PointCloud<pcl::PointXYZ>);
  // *ptr_cloud_p = cloud_baselink_filter;
  // filter_p.setInputCloud(ptr_cloud_p);
  // filter_p.setLeafSize(0.05, 0.05, 0.05); //设置滤波时创建的体素大小为3cm立方体
  // filter_p.filter(cloud_filter_plane);

  //压缩后噪点滤波
  pcl::RadiusOutlierRemoval<pcl::PointXYZ> filter;  //移除离群点
  pcl::PointCloud<pcl::PointXYZ>::Ptr ptr_cloud(new pcl::PointCloud<pcl::PointXYZ>);
  *ptr_cloud = cloud_baselink_filter;
  cloud_baselink.clear();
  filter.setInputCloud(ptr_cloud);
  filter.setRadiusSearch(0.2);//设置在0.1的半径内找临近点
  filter.setMinNeighborsInRadius(20);//设置查询点的邻近点集数小于5的删除
  filter.filter(cloud_baselink);

  if (cloud_baselink.points.size() < 5)
  {
    return;
  }

//-----------------------------------------------------------------//
  // //发布出去
  // sensor_msgs::PointCloud2 pointcloud_filtered;
  // pointcloud_filtered.header.stamp = ros::Time::now();
  // pcl::toROSMsg (cloud_baselink,pointcloud_filtered);
  // pointcloud_filtered.header.frame_id = "map";
  // this->pub_points_filtered.publish(pointcloud_filtered);
//-----------------------------------------------------------------//
  if (listener.canTransform("map", "base_link", ros::Time()))
  {
    geometry_msgs::PoseStamped base_link_pose;
    base_link_pose.header.frame_id = "base_link";

    base_link_pose.header.stamp = ros::Time();
    base_link_pose.pose.position.x = 0.0;
    base_link_pose.pose.position.y = 0.0;
    base_link_pose.pose.position.z = 0.0;
    base_link_pose.pose.orientation.x = 0.0;
    base_link_pose.pose.orientation.y = 0.0;
    base_link_pose.pose.orientation.z = 0.0;
    base_link_pose.pose.orientation.w = 1.0;

    try
    {
      geometry_msgs::PoseStamped pose_stamped;
      listener.transformPose("map", base_link_pose, pose_stamped);
      pcl::transformPointCloud(cloud_baselink, pointscloud_camera, Eigen::Vector3f(pose_stamped.pose.position.x, pose_stamped.pose.position.y, 0.0),
                               Eigen::Quaternionf(pose_stamped.pose.orientation.w,
                                                  pose_stamped.pose.orientation.x,
                                                  pose_stamped.pose.orientation.y,
                                                  pose_stamped.pose.orientation.z)); ////use
      sensor_msgs::PointCloud2 pointcloud_filtered;
      pointcloud_filtered.header.stamp = ros::Time::now();
      pcl::toROSMsg (pointscloud_camera,pointcloud_filtered);
      pointcloud_filtered.header.frame_id = "map";
      this->point_cloud_publisher_.publish(pointcloud_filtered);
    }
    catch (tf::TransformException &ex)
    {
      ROS_ERROR("Received an exception trying to transform a point from \"base_link\" to \"map\": %s", ex.what());
    }
  }
}
