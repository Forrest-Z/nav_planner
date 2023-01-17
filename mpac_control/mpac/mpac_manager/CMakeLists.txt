cmake_minimum_required(VERSION 2.8.3)
project(mpac_manager)
# Compile as C++11
add_compile_options(-std=c++11)

set(CMAKE_BUILD_TYPE Release)
find_package(catkin REQUIRED COMPONENTS
  cmake_modules
  roscpp
  std_msgs
  std_srvs
  nav_msgs
  mpac_msgs
  mpac_generic
  mpac_rviz
  mpac_conversions
  mpac_geometry
  mpac_trajectory_processor
  mpac_constraint_extract
  tf
  laser_geometry
  sineva_nav
)

find_package(Boost REQUIRED COMPONENTS system thread program_options)

find_package(Eigen3)
if(NOT EIGEN3_FOUND)
  # Fallback to cmake_modules
  find_package(cmake_modules REQUIRED)
  find_package(Eigen REQUIRED)
  set(EIGEN3_INCLUDE_DIRS ${EIGEN_INCLUDE_DIRS})
else()
  set(EIGEN3_INCLUDE_DIRS ${EIGEN3_INCLUDE_DIR})
endif()

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS roscpp std_msgs std_srvs nav_msgs sineva_nav mpac_msgs mpac_generic mpac_rviz mpac_conversions mpac_geometry mpac_trajectory_processor mpac_constraint_extract tf laser_geometry
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

add_executable(mpac_manager_node src/mpac_manager_node.cpp)
add_dependencies(mpac_manager_node ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_manager_node
   ${catkin_LIBRARIES}
 )


#############
## Install ##
#############

install(TARGETS mpac_manager_node 
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
       )

install(DIRECTORY
  targets
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY include/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
       )
