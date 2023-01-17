## 该存储库用于实现全局路径规划、局部运动规划和运动控制
## 各ROS包功能描述
   ### 1. mpac_generic
   通用的数据格式以及函数
   ### 2. mpac_geometry
   关于几何方面的定义和转换
   ### 3. mpac_global_planner
   全局路径规划器
   ### 4. mpac_local_planner
   局部路径规划器
   ### 5. mpac_manager
   任务管理
   ### 6. mpac_msgs
   ROS消息和服务
   ### 7. mpac_launch
   启动文件
   ### 8. mpac_filter
   点云滤波
## 环境和依赖
   1. Ubuntu 16.04 LTS 
   2. ROS Kinetic
   3. Eigen3
## 安装编译
`$ cd catkin_ws/src`

`$ git clone http://10.1.9.176/amr1/mpac.git -b xxx`

`$ cd ..`

`$ catkin_make`

`$ source devel/setup.bash`

`$ roslaunch mpac_launch single_agv.launch`

