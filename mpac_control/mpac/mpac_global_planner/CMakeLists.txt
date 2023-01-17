cmake_minimum_required(VERSION 2.8.3)
project(mpac_global_planner)

set(CMAKE_BUILD_TYPE Release)
find_package(catkin REQUIRED COMPONENTS
  cmake_modules
  roscpp
  std_msgs
  nav_msgs
  cv_bridge
  mpac_msgs
  mpac_generic
  mpac_rviz
  mpac_conversions
  mpac_geometry
  mpac_manager
)
find_package(OpenCV 3 REQUIRED)

find_package(Eigen3)
if(NOT EIGEN3_FOUND)
  # Fallback to cmake_modules
  find_package(cmake_modules REQUIRED)
  find_package(Eigen REQUIRED)
  set(EIGEN3_INCLUDE_DIRS ${EIGEN_INCLUDE_DIRS})
else()
  set(EIGEN3_INCLUDE_DIRS ${EIGEN3_INCLUDE_DIR})
endif()

## System dependencies are found with CMake's conventions
find_package(Boost REQUIRED COMPONENTS system program_options thread)
if (${Boost_VERSION} LESS 106500)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBOOST_MATH_DISABLE_FLOAT128")
endif()

#SET(CMAKE_CXX_FLAGS "-std=c++11 -O3")
  add_definitions(-std=c++11)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES mpac_global_planner
  CATKIN_DEPENDS roscpp std_msgs nav_msgs cv_bridge mpac_msgs mpac_generic mpac_rviz mpac_conversions mpac_geometry mpac_manager
  DEPENDS Boost
)

###########
## Build ##
###########

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIRS}
)

message(${catkin_INCLUDE_DIRS})

add_library(mpac_global_planner
src/ARAStarPathPlanner.cpp
src/AStar.cpp
src/AStarPathPlanner.cpp
src/CarConfiguration.cpp
src/CarModel.cpp
src/CollisionDetector.cpp
src/Configuration.cpp
src/DiscWorldVisualizer.cpp
src/LHDConfiguration.cpp
src/LHDModel.cpp
src/MapGenerators.cpp
src/MotionPrimitiveData.cpp
src/MotionPrimitiveSelector.cpp
src/PathFinder.cpp
src/PathNode.cpp
src/UnicycleConfiguration.cpp
src/UnicycleModel.cpp
src/Utils.cpp
src/VehicleMission.cpp
src/VehicleModel.cpp
src/World.cpp
src/WorldOccupancyMap.cpp
src/WorldParameters.cpp
src/WorldRoadNetMap.cpp
src/vec2d.cpp
src/dynamic_voronoi.cpp
src/smoother.cpp
src/Dijkstra.cpp
src/Node2d.cpp
  )
target_link_libraries(mpac_global_planner
  ${catkin_LIBRARIES} ${OpenCV_LIBS}
  )

## Declare a cpp executable
add_executable(mpac_get_path_service src/get_path_service.cpp
)
add_dependencies(mpac_get_path_service ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_get_path_service
#  mpac_motion_planner 
mpac_global_planner
${catkin_LIBRARIES} ${OpenCV_LIBS}
)

add_executable(mpac_get_path_client src/get_path_client.cpp)
add_dependencies(mpac_get_path_client ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_get_path_client
  ${catkin_LIBRARIES} ${Boost_LIBRARIES} ${OpenCV_LIBS}
)

#############
## Install ##
#############

install(TARGETS mpac_get_path_service mpac_get_path_client mpac_global_planner
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY
  include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

install(DIRECTORY
  LookupTables
  Primitives
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
