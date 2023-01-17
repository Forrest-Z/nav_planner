;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SetGoalSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SetGoalSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SETGOALSRV")
  (make-package "SINEVA_NAV::SETGOALSRV"))
(unless (find-package "SINEVA_NAV::SETGOALSRVREQUEST")
  (make-package "SINEVA_NAV::SETGOALSRVREQUEST"))
(unless (find-package "SINEVA_NAV::SETGOALSRVRESPONSE")
  (make-package "SINEVA_NAV::SETGOALSRVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass sineva_nav::SetGoalSrvRequest
  :super ros::object
  :slots (_goal_id _goal _timeout _maxDistance ))

(defmethod sineva_nav::SetGoalSrvRequest
  (:init
   (&key
    ((:goal_id __goal_id) "")
    ((:goal __goal) (instance geometry_msgs::Pose :init))
    ((:timeout __timeout) 0)
    ((:maxDistance __maxDistance) 0.0)
    )
   (send-super :init)
   (setq _goal_id (string __goal_id))
   (setq _goal __goal)
   (setq _timeout (round __timeout))
   (setq _maxDistance (float __maxDistance))
   self)
  (:goal_id
   (&optional __goal_id)
   (if __goal_id (setq _goal_id __goal_id)) _goal_id)
  (:goal
   (&rest __goal)
   (if (keywordp (car __goal))
       (send* _goal __goal)
     (progn
       (if __goal (setq _goal (car __goal)))
       _goal)))
  (:timeout
   (&optional __timeout)
   (if __timeout (setq _timeout __timeout)) _timeout)
  (:maxDistance
   (&optional __maxDistance)
   (if __maxDistance (setq _maxDistance __maxDistance)) _maxDistance)
  (:serialization-length
   ()
   (+
    ;; string _goal_id
    4 (length _goal_id)
    ;; geometry_msgs/Pose _goal
    (send _goal :serialization-length)
    ;; int32 _timeout
    4
    ;; float32 _maxDistance
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _goal_id
       (write-long (length _goal_id) s) (princ _goal_id s)
     ;; geometry_msgs/Pose _goal
       (send _goal :serialize s)
     ;; int32 _timeout
       (write-long _timeout s)
     ;; float32 _maxDistance
       (sys::poke _maxDistance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _goal_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _goal_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _goal
     (send _goal :deserialize buf ptr-) (incf ptr- (send _goal :serialization-length))
   ;; int32 _timeout
     (setq _timeout (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _maxDistance
     (setq _maxDistance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::SetGoalSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::SetGoalSrvResponse
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

(defclass sineva_nav::SetGoalSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::SetGoalSrv :md5sum-) "c19bf813310f153659784721f23f0785")
(setf (get sineva_nav::SetGoalSrv :datatype-) "sineva_nav/SetGoalSrv")
(setf (get sineva_nav::SetGoalSrv :request) sineva_nav::SetGoalSrvRequest)
(setf (get sineva_nav::SetGoalSrv :response) sineva_nav::SetGoalSrvResponse)

(defmethod sineva_nav::SetGoalSrvRequest
  (:response () (instance sineva_nav::SetGoalSrvResponse :init)))

(setf (get sineva_nav::SetGoalSrvRequest :md5sum-) "c19bf813310f153659784721f23f0785")
(setf (get sineva_nav::SetGoalSrvRequest :datatype-) "sineva_nav/SetGoalSrvRequest")
(setf (get sineva_nav::SetGoalSrvRequest :definition-)
      "# request message
string goal_id
geometry_msgs/Pose goal
int32 timeout
float32 maxDistance

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

(setf (get sineva_nav::SetGoalSrvResponse :md5sum-) "c19bf813310f153659784721f23f0785")
(setf (get sineva_nav::SetGoalSrvResponse :datatype-) "sineva_nav/SetGoalSrvResponse")
(setf (get sineva_nav::SetGoalSrvResponse :definition-)
      "# request message
string goal_id
geometry_msgs/Pose goal
int32 timeout
float32 maxDistance

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



(provide :sineva_nav/SetGoalSrv "c19bf813310f153659784721f23f0785")


