cmake_minimum_required(VERSION 2.8.3)
project(mpac_generic)
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS cmake_modules angles)
find_package(Boost REQUIRED COMPONENTS serialization)

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
  CATKIN_DEPENDS angles
  DEPENDS Boost
)

###########
## Build ##
###########
include_directories(
  include
  ${Boost_INCLUDE_DIR}
  ${EIGEN3_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  )

# add_executable(random_test_mpac test/random_test.cc)

# add_executable(serialization_test_mpac test/serialization_test.cc)
# target_link_libraries(serialization_test_mpac -lboost_serialization)

#############
## Install ##
#############

install(DIRECTORY include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
       )
