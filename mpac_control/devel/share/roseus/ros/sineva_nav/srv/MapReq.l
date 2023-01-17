;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::MapReq)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'MapReq (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::MAPREQ")
  (make-package "SINEVA_NAV::MAPREQ"))
(unless (find-package "SINEVA_NAV::MAPREQREQUEST")
  (make-package "SINEVA_NAV::MAPREQREQUEST"))
(unless (find-package "SINEVA_NAV::MAPREQRESPONSE")
  (make-package "SINEVA_NAV::MAPREQRESPONSE"))

(in-package "ROS")



(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))


(defclass sineva_nav::MapReqRequest
  :super ros::object
  :slots (_mapRequest ))

(defmethod sineva_nav::MapReqRequest
  (:init
   (&key
    ((:mapRequest __mapRequest) "")
    )
   (send-super :init)
   (setq _mapRequest (string __mapRequest))
   self)
  (:mapRequest
   (&optional __mapRequest)
   (if __mapRequest (setq _mapRequest __mapRequest)) _mapRequest)
  (:serialization-length
   ()
   (+
    ;; string _mapRequest
    4 (length _mapRequest)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _mapRequest
       (write-long (length _mapRequest) s) (princ _mapRequest s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _mapRequest
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mapRequest (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::MapReqResponse
  :super ros::object
  :slots (_result _mapDate ))

(defmethod sineva_nav::MapReqResponse
  (:init
   (&key
    ((:result __result) 0)
    ((:mapDate __mapDate) (instance nav_msgs::OccupancyGrid :init))
    )
   (send-super :init)
   (setq _result (round __result))
   (setq _mapDate __mapDate)
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
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
    ;; int8 _result
    1
    ;; nav_msgs/OccupancyGrid _mapDate
    (send _mapDate :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _result
       (write-byte _result s)
     ;; nav_msgs/OccupancyGrid _mapDate
       (send _mapDate :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _result 127) (setq _result (- _result 256)))
   ;; nav_msgs/OccupancyGrid _mapDate
     (send _mapDate :deserialize buf ptr-) (incf ptr- (send _mapDate :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::MapReq
  :super ros::object
  :slots ())

(setf (get sineva_nav::MapReq :md5sum-) "f620cddd1adb52c04caee6100b1f237e")
(setf (get sineva_nav::MapReq :datatype-) "sineva_nav/MapReq")
(setf (get sineva_nav::MapReq :request) sineva_nav::MapReqRequest)
(setf (get sineva_nav::MapReq :response) sineva_nav::MapReqResponse)

(defmethod sineva_nav::MapReqRequest
  (:response () (instance sineva_nav::MapReqResponse :init)))

(setf (get sineva_nav::MapReqRequest :md5sum-) "f620cddd1adb52c04caee6100b1f237e")
(setf (get sineva_nav::MapReqRequest :datatype-) "sineva_nav/MapReqRequest")
(setf (get sineva_nav::MapReqRequest :definition-)
      "string mapRequest
---
int8 result
nav_msgs/OccupancyGrid mapDate


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
")

(setf (get sineva_nav::MapReqResponse :md5sum-) "f620cddd1adb52c04caee6100b1f237e")
(setf (get sineva_nav::MapReqResponse :datatype-) "sineva_nav/MapReqResponse")
(setf (get sineva_nav::MapReqResponse :definition-)
      "string mapRequest
---
int8 result
nav_msgs/OccupancyGrid mapDate


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
")



(provide :sineva_nav/MapReq "f620cddd1adb52c04caee6100b1f237e")


