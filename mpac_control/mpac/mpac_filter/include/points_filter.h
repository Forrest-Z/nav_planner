#include "ros/ros.h"
#include <pcl/PCLPointCloud2.h>
#include <pcl/common/transforms.h>
#include <pcl/filters/voxel_grid.h>  ///filter
#include <pcl/filters/radius_outlier_removal.h>
#include <pcl/filters/passthrough.h>
#include <pcl/registration/icp.h>
#include <pcl/point_cloud.h>
#include <pcl_conversions/pcl_conversions.h>
#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/PointCloud2.h>
#include <std_msgs/Bool.h>
#include <tf/transform_listener.h>
#include "csm/csm_all.h"
#include "laser_geometry/laser_geometry.h"

class PointsFilter
{

public:
    PointsFilter();
    ~PointsFilter();
    void Run();
    
private:
    
    ros::NodeHandle node_fliter;
    ros::Subscriber sub_laser_points;
    ros::Subscriber sub_cam_points;
    ros::Subscriber sub_laser_pose;
    ros::Subscriber sub_laser_scan;

    ros::Publisher pub_points_filtered;
    ros::Publisher point_cloud_publisher_;
    tf::TransformListener listener;
    laser_geometry::LaserProjection projector_;

    bool isGetCamPoints;
    sensor_msgs::PointCloud2ConstPtr laser_msg_last;
    pcl::PCLPointCloud2Ptr camera_points;
    pcl::PCLPointCloud2Ptr transform_points;

    pcl::PointCloud<pcl::PointXYZ> pointscloud_laser;
    pcl::PointCloud<pcl::PointXYZ> pointscloud_camera;
    ros::Time last_time;

    int downsampling;

    Eigen::Vector3f offset_cam;
    Eigen::Quaternionf rotation_cam;

    bool cam_points_enable = false;

    void LaserPointsCallBack(sensor_msgs::PointCloud2ConstPtr msg);
    void CamPointsCallBack(sensor_msgs::PointCloud2ConstPtr msg);
    void LaserScanCallBack(sensor_msgs::LaserScanConstPtr msg);

    std::string base_link;


};

