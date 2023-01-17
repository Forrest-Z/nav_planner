# Install script for directory: /home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/lxf/lxf_work/learning_mpac/mpac_control/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/msg" TYPE FILE FILES
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/map_lidar_state.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/base_sensor_data.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/position.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/pose2D.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/calib_status.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/SlamStatus.msg"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/BaseData.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/srv" TYPE FILE FILES
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CheckGoalStatusSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CancelGoalSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/CloseSafeAreaSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/EnableSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/GetStateSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetGoalSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetInitialPoseSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonCommSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPathSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_map_lidar.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SaveMapping.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/Relocation.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/manage_charge.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/charge_point.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/goal_status.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MoveStatus.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/MapReq.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/UpdateMapSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/StringCommSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/SetPositionsSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/JsonSrv.srv"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/BaseCommand.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/cmake" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/build/sineva_nav/catkin_generated/installspace/sineva_nav-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/include/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/share/roseus/ros/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/share/common-lisp/ros/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/share/gennodejs/ros/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/lib/python2.7/dist-packages/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/devel/lib/python2.7/dist-packages/sineva_nav")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/build/sineva_nav/catkin_generated/installspace/sineva_nav.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/cmake" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/build/sineva_nav/catkin_generated/installspace/sineva_nav-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/cmake" TYPE FILE FILES
    "/home/lxf/lxf_work/learning_mpac/mpac_control/build/sineva_nav/catkin_generated/installspace/sineva_navConfig.cmake"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/build/sineva_nav/catkin_generated/installspace/sineva_navConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/msg" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/msg/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sineva_nav/srv" TYPE DIRECTORY FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/src/sineva_nav/srv/")
endif()

