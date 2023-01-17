# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sineva_nav: 7 messages, 22 services")

set(MSG_I_FLAGS "-Isineva_nav:/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Inav_msgs:/opt/ros/melodic/share/nav_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/melodic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/melodic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sineva_nav_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" "nav_msgs/MapMetaData:geometry_msgs/Pose:nav_msgs/OccupancyGrid:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" "sineva_nav/position"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" "nav_msgs/MapMetaData:geometry_msgs/Pose:nav_msgs/OccupancyGrid:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" "nav_msgs/Path:geometry_msgs/Pose:std_msgs/Header:geometry_msgs/Point:geometry_msgs/PoseStamped:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" ""
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" "geometry_msgs/Pose2D:std_msgs/Header"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_custom_target(_sineva_nav_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sineva_nav" "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_msg_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)

### Generating Services
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
  "${MSG_I_FLAGS}"
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/Path.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)
_generate_srv_cpp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
)

### Generating Module File
_generate_module_cpp(sineva_nav
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sineva_nav_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sineva_nav_generate_messages sineva_nav_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_cpp _sineva_nav_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sineva_nav_gencpp)
add_dependencies(sineva_nav_gencpp sineva_nav_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sineva_nav_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_msg_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)

### Generating Services
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
  "${MSG_I_FLAGS}"
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/Path.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)
_generate_srv_eus(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
)

### Generating Module File
_generate_module_eus(sineva_nav
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sineva_nav_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sineva_nav_generate_messages sineva_nav_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_eus _sineva_nav_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sineva_nav_geneus)
add_dependencies(sineva_nav_geneus sineva_nav_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sineva_nav_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_msg_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)

### Generating Services
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
  "${MSG_I_FLAGS}"
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/Path.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)
_generate_srv_lisp(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
)

### Generating Module File
_generate_module_lisp(sineva_nav
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sineva_nav_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sineva_nav_generate_messages sineva_nav_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_lisp _sineva_nav_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sineva_nav_genlisp)
add_dependencies(sineva_nav_genlisp sineva_nav_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sineva_nav_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_msg_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)

### Generating Services
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
  "${MSG_I_FLAGS}"
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/Path.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)
_generate_srv_nodejs(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
)

### Generating Module File
_generate_module_nodejs(sineva_nav
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sineva_nav_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sineva_nav_generate_messages sineva_nav_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_nodejs _sineva_nav_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sineva_nav_gennodejs)
add_dependencies(sineva_nav_gennodejs sineva_nav_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sineva_nav_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_msg_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)

### Generating Services
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
  "${MSG_I_FLAGS}"
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/nav_msgs/cmake/../msg/OccupancyGrid.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/nav_msgs/cmake/../msg/Path.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)
_generate_srv_py(sineva_nav
  "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
)

### Generating Module File
_generate_module_py(sineva_nav
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sineva_nav_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sineva_nav_generate_messages sineva_nav_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv" NAME_WE)
add_dependencies(sineva_nav_generate_messages_py _sineva_nav_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sineva_nav_genpy)
add_dependencies(sineva_nav_genpy sineva_nav_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sineva_nav_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sineva_nav
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sineva_nav_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET nav_msgs_generate_messages_cpp)
  add_dependencies(sineva_nav_generate_messages_cpp nav_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(sineva_nav_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sineva_nav
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sineva_nav_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET nav_msgs_generate_messages_eus)
  add_dependencies(sineva_nav_generate_messages_eus nav_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(sineva_nav_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sineva_nav
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sineva_nav_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET nav_msgs_generate_messages_lisp)
  add_dependencies(sineva_nav_generate_messages_lisp nav_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(sineva_nav_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sineva_nav
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sineva_nav_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET nav_msgs_generate_messages_nodejs)
  add_dependencies(sineva_nav_generate_messages_nodejs nav_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(sineva_nav_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sineva_nav
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sineva_nav_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET nav_msgs_generate_messages_py)
  add_dependencies(sineva_nav_generate_messages_py nav_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(sineva_nav_generate_messages_py sensor_msgs_generate_messages_py)
endif()
