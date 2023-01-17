;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SetPathSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SetPathSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SETPATHSRV")
  (make-package "SINEVA_NAV::SETPATHSRV"))
(unless (find-package "SINEVA_NAV::SETPATHSRVREQUEST")
  (make-package "SINEVA_NAV::SETPATHSRVREQUEST"))
(unless (find-package "SINEVA_NAV::SETPATHSRVRESPONSE")
  (make-package "SINEVA_NAV::SETPATHSRVRESPONSE"))

(in-package "ROS")

(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))




(defclass sineva_nav::SetPathSrvRequest
  :super ros::object
  :slots (_goal_id _path ))

(defmethod sineva_nav::SetPathSrvRequest
  (:init
   (&key
    ((:goal_id __goal_id) "")
    ((:path __path) (instance nav_msgs::Path :init))
    )
   (send-super :init)
   (setq _goal_id (string __goal_id))
   (setq _path __path)
   self)
  (:goal_id
   (&optional __goal_id)
   (if __goal_id (setq _goal_id __goal_id)) _goal_id)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:serialization-length
   ()
   (+
    ;; string _goal_id
    4 (length _goal_id)
    ;; nav_msgs/Path _path
    (send _path :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _goal_id
       (write-long (length _goal_id) s) (princ _goal_id s)
     ;; nav_msgs/Path _path
       (send _path :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _goal_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _goal_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; nav_msgs/Path _path
     (send _path :deserialize buf ptr-) (incf ptr- (send _path :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::SetPathSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::SetPathSrvResponse
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
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::SetPathSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::SetPathSrv :md5sum-) "00b963a59692bf94c8192290a3afedc1")
(setf (get sineva_nav::SetPathSrv :datatype-) "sineva_nav/SetPathSrv")
(setf (get sineva_nav::SetPathSrv :request) sineva_nav::SetPathSrvRequest)
(setf (get sineva_nav::SetPathSrv :response) sineva_nav::SetPathSrvResponse)

(defmethod sineva_nav::SetPathSrvRequest
  (:response () (instance sineva_nav::SetPathSrvResponse :init)))

(setf (get sineva_nav::SetPathSrvRequest :md5sum-) "00b963a59692bf94c8192290a3afedc1")
(setf (get sineva_nav::SetPathSrvRequest :datatype-) "sineva_nav/SetPathSrvRequest")
(setf (get sineva_nav::SetPathSrvRequest :definition-)
      "# request message
string goal_id
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

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
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
# response message
int32 result
")

(setf (get sineva_nav::SetPathSrvResponse :md5sum-) "00b963a59692bf94c8192290a3afedc1")
(setf (get sineva_nav::SetPathSrvResponse :datatype-) "sineva_nav/SetPathSrvResponse")
(setf (get sineva_nav::SetPathSrvResponse :definition-)
      "# request message
string goal_id
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

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
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
# response message
int32 result
")



(provide :sineva_nav/SetPathSrv "00b963a59692bf94c8192290a3afedc1")


