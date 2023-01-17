#include <ros/ros.h>
#include <boost/program_options.hpp>
#include <mpac_generic/interfaces.h>
#include <mpac_generic/utils.h>
#include <mpac_generic/io.h>
#include <mpac_conversions/conversions.h>
#include <mpac_msgs/GetPolygonFootPrint.h>
#include <mpac_msgs/RobotTarget.h>

namespace po = boost::program_options;

using namespace std;

int main(int argc, char** argv) {
  ros::init(argc, argv, "polygonfootprint_client");

  std::string path_file;
  po::options_description desc("Allowed options");
  desc.add_options()
    ("path_file", po::value<string>(&path_file)->required(), "path file to be used")
    ("help", "produce help message")
    ;
  
  po::variables_map vm;
  po::store(po::parse_command_line(argc, argv, desc), vm);
  
  if (vm.count("help")) {
    cout << desc << "\n";
    return 1;
  }

  po::notify(vm);    

  ros::NodeHandle nh;

  mpac_msgs::RobotTarget target;
  target.robot_id = 1;
  target.goal_id = 1;
  target.type_id = 4;

  mpac_generic::Path path = mpac_generic::loadPathTextFile(path_file);
  { // Get path service call related stuff goes here...
    mpac_msgs::GetPolygonFootPrint srv;
    srv.request.path = mpac_conversions::createPathMsgFromPathInterface(path);
    srv.request.target = target;
    // Update the target goal pose and map based on the load operations
    // Need to package the target + the map and ask the motion planner.
    ros::ServiceClient client = nh.serviceClient<mpac_msgs::GetPolygonFootPrint>("polygonfootprint_service");
    
    if (client.call(srv)) {
      ROS_INFO("[polygonfootprint_client] - polygonfootprint_service sucessfull");
    }
    else
    {
      ROS_ERROR("[polygonfootprint_client] - Failed to call service: PolygontFootPrint");
      return false;
    }
    
  }

  ros::Rate r(1);
  while (ros::ok()) {
    ros::spinOnce();
    r.sleep();
    ROS_INFO_STREAM(".");
  }
}
