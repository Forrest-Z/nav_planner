mpac_navigation
#  配置move_base导航的相关参数文件

mpac_simulations
#  小车的仿真模型

mpac_slam
# 使用各类算法建图 默认gmapping

mpac_teleop
# 键盘控制小车移动


### 执行指令

# 使用gmapping建图
roslaunch mpac_gazebo lxf_turtlebot3_world.launch 
roslaunch mpac_teleop turtlebot3_teleop_key.launch 
roslaunch mpac_slam mpac_slam.launch 
rosrun map_server map_saver -f  ~/catkin_ws/src/hypharos_minicar/launch/map/mymap

# 使用move_base导航
roslaunch mpac_gazebo lxf_turtlebot3_world.launch 
roslaunch mpac_navigation mpac_navigation.launch 






