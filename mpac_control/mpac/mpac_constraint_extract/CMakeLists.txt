cmake_minimum_required(VERSION 2.8.3)
project(mpac_constraint_extract)
add_compile_options(-std=c++11)
set(CMAKE_BUILD_TYPE Release)
find_package(catkin REQUIRED COMPONENTS
  cmake_modules
  roscpp
  std_msgs
  nav_msgs
  mpac_msgs
  mpac_generic
  mpac_rviz
  mpac_conversions
  mpac_geometry
  tf
)

find_package(Boost REQUIRED COMPONENTS program_options serialization filesystem) # thread signals system

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
  INCLUDE_DIRS include ${Boost_INCLUDE_DIRS} ${EIGEN3_INCLUDE_DIRS}
  LIBRARIES ${PROJECT_NAME} ${Boost_LIBRARIES}
  CATKIN_DEPENDS roscpp std_msgs nav_msgs mpac_msgs mpac_generic mpac_rviz mpac_conversions mpac_geometry tf
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

add_library(${PROJECT_NAME}
  src/grid_map.cpp
  src/model_only.cpp
  )
add_dependencies(${PROJECT_NAME} ${catkin_EXPORTED_TARGETS})

add_executable(mpac_polygonconstraint_service src/polygonconstraint_service.cpp)
add_dependencies(mpac_polygonconstraint_service ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_polygonconstraint_service
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

add_executable(mpac_polygonfootprint_service src/polygonfootprint_service.cpp)
add_dependencies(mpac_polygonfootprint_service ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_polygonfootprint_service
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

# add_executable(mpac_robot_model2d_test test/robot_model2d_test.cpp)
# add_dependencies(mpac_robot_model2d_test ${catkin_EXPORTED_TARGETS})
# target_link_libraries(mpac_robot_model2d_test
#   ${catkin_LIBRARIES}
#   ${Boost_LIBRARIES}
# )

# add_executable(mpac_constraint_extract_serialization_test test/serialization_test.cpp)
# add_dependencies(mpac_constraint_extract_serialization_test ${catkin_EXPORTED_TARGETS})
# target_link_libraries(mpac_constraint_extract_serialization_test
#   ${catkin_LIBRARIES}
#   ${Boost_LIBRARIES}
# )

# add_executable(mpac_grid_map_collision_test test/grid_map_collision_test.cpp)
# add_dependencies(mpac_grid_map_collision_test ${catkin_EXPORTED_TARGETS})
# target_link_libraries(mpac_grid_map_collision_test
#   ${catkin_LIBRARIES}
#   ${Boost_LIBRARIES}
# )

add_executable(mpac_polygonfootprint_client src/polygonfootprint_client.cpp)
add_dependencies(mpac_polygonfootprint_client ${catkin_EXPORTED_TARGETS})
target_link_libraries(mpac_polygonfootprint_client
  ${catkin_LIBRARIES} ${Boost_LIBRARIES}
)


#############
## Install ##
#############

install(TARGETS ${PROJECT_NAME} mpac_polygonconstraint_service mpac_polygonfootprint_service mpac_polygonfootprint_client
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
  )

install(DIRECTORY
  include/${PROJECT_NAME}/
  tables
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  )

install(DIRECTORY
  tables
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  )
