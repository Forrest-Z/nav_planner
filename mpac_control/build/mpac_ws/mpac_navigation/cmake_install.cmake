# Install script for directory: /home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/build/mpac_ws/mpac_navigation/catkin_generated/installspace/mpac_navigation.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mpac_navigation/cmake" TYPE FILE FILES
    "/home/lxf/lxf_work/learning_mpac/mpac_control/build/mpac_ws/mpac_navigation/catkin_generated/installspace/mpac_navigationConfig.cmake"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/build/mpac_ws/mpac_navigation/catkin_generated/installspace/mpac_navigationConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mpac_navigation" TYPE FILE FILES "/home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mpac_navigation" TYPE DIRECTORY FILES
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation/launch"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation/maps"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation/param"
    "/home/lxf/lxf_work/learning_mpac/mpac_control/src/mpac_ws/mpac_navigation/rviz"
    )
endif()

