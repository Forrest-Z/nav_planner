
#include "points_filter.h"
#include <std_msgs/Int8.h>

ros::Publisher heart_beat_pub_;
ros::Timer timer_heartbeat;

std_msgs::Int8 heartBeatmsg;

void pubHeartbeatTimeroutCB(const ros::TimerEvent &)
{
	heart_beat_pub_.publish(heartBeatmsg);
}

int main(int argc, char *argv[])
{

	ros::init(argc, argv, "points_filter");
	ros::NodeHandle nh_;

	PointsFilter points_filter;
	points_filter.Run();
	heartBeatmsg.data = 6; //6-filter node
	heart_beat_pub_ = nh_.advertise<std_msgs::Int8>("heartBeat", 1);
	timer_heartbeat = nh_.createTimer(ros::Duration(0.5), pubHeartbeatTimeroutCB, false, true);

	ros::Rate loop_rate(10);
	while (ros::ok())
	{
		ros::spinOnce();
		loop_rate.sleep();
	}
	return 0;
}
