;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::UpdateMapSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'UpdateMapSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::UPDATEMAPSRV")
  (make-package "SINEVA_NAV::UPDATEMAPSRV"))
(unless (find-package "SINEVA_NAV::UPDATEMAPSRVREQUEST")
  (make-package "SINEVA_NAV::UPDATEMAPSRVREQUEST"))
(unless (find-package "SINEVA_NAV::UPDATEMAPSRVRESPONSE")
  (make-package "SINEVA_NAV::UPDATEMAPSRVRESPONSE"))

(in-package "ROS")

(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))




(defclass sineva_nav::UpdateMapSrvRequest
  :super ros::object
  :slots (_mapDate ))

(defmethod sineva_nav::UpdateMapSrvRequest
  (:init
   (&key
    ((:mapDate __mapDate) (instance nav_msgs::OccupancyGrid :init))
    )
   (send-super :init)
   (setq _mapDate __mapDate)
   self)
  (:mapDate
   (&rest __mapDate)
   (if (keywordp (car __mapDate))
       (send* _mapDate __mapDate)
     (progn
       (if __mapDate (setq _mapDate (car __mapDate)))
       _mapDate)))
  (:serialization-length
   ()
   (+
    ;; nav_msgs/OccupancyGrid _mapDate
    (send _mapDate :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_msgs/OccupancyGrid _mapDate
       (send _mapDate :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_msgs/OccupancyGrid _mapDate
     (send _mapDate :deserialize buf ptr-) (incf ptr- (send _mapDate :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::UpdateMapSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::UpdateMapSrvResponse
  (:init
   (&key
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _result (round __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; int8 _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _result
       (write-byte _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _result 127) (setq _result (- _result 256)))
   ;;
   self)
  )

(defclass sineva_nav::UpdateMapSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::UpdateMapSrv :md5sum-) "e2ab93ba586b17f6c5de94ce88e0aec5")
(setf (get sineva_nav::UpdateMapSrv :datatype-) "sineva_nav/UpdateMapSrv")
(setf (get sineva_nav::UpdateMapSrv :request) sineva_nav::UpdateMapSrvRequest)
(setf (get sineva_nav::UpdateMapSrv :response) sineva_nav::UpdateMapSrvResponse)

(defmethod sineva_nav::UpdateMapSrvRequest
  (:response () (instance sineva_nav::UpdateMapSrvResponse :init)))

(setf (get sineva_nav::UpdateMapSrvRequest :md5sum-) "e2ab93ba586b17f6c5de94ce88e0aec5")
(setf (get sineva_nav::UpdateMapSrvRequest :datatype-) "sineva_nav/UpdateMapSrvRequest")
(setf (get sineva_nav::UpdateMapSrvRequest :definition-)
      "nav_msgs/OccupancyGrid mapDate

================================================================================
MSG: nav_msgs/OccupancyGrid
# This represents a 2-D grid map, in which each cell represents the probability of
# occupancy.

Header header 

#MetaData for the map
MapMetaData info

# The map data, in row-major order, starting with (0,0).  Occupancy
# probabilities are in the range [0,100].  Unknown is -1.
int8[] data

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: nav_msgs/MapMetaData
# This hold basic information about the characterists of the OccupancyGrid

# The time at which the map was loaded
time map_load_time
# The map resolution [m/cell]
float32 resolution
# Map width [cells]
uint32 width
# Map height [cells]
uint32 height
# The origin of the map [m, m, rad].  This is the real-world pose of the
# cell (0,0) in the map.
geometry_msgs/Pose origin
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
int8 result
")

(setf (get sineva_nav::UpdateMapSrvResponse :md5sum-) "e2ab93ba586b17f6c5de94ce88e0aec5")
(setf (get sineva_nav::UpdateMapSrvResponse :datatype-) "sineva_nav/UpdateMapSrvResponse")
(setf (get sineva_nav::UpdateMapSrvResponse :definition-)
      "nav_msgs/OccupancyGrid mapDate

================================================================================
MSG: nav_msgs/OccupancyGrid
# This represents a 2-D grid map, in which each cell represents the probability of
# occupancy.

Header header 

#MetaData for the map
MapMetaData info

# The map data, in row-major order, starting with (0,0).  Occupancy
# probabilities are in the range [0,100].  Unknown is -1.
int8[] data

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: nav_msgs/MapMetaData
# This hold basic information about the characterists of the OccupancyGrid

# The time at which the map was loaded
time map_load_time
# The map resolution [m/cell]
float32 resolution
# Map width [cells]
uint32 width
# Map height [cells]
uint32 height
# The origin of the map [m, m, rad].  This is the real-world pose of the
# cell (0,0) in the map.
geometry_msgs/Pose origin
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
int8 result
")



(provide :sineva_nav/UpdateMapSrv "e2ab93ba586b17f6c5de94ce88e0aec5")


