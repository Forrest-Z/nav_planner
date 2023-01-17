;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SetInitialPoseSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SetInitialPoseSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SETINITIALPOSESRV")
  (make-package "SINEVA_NAV::SETINITIALPOSESRV"))
(unless (find-package "SINEVA_NAV::SETINITIALPOSESRVREQUEST")
  (make-package "SINEVA_NAV::SETINITIALPOSESRVREQUEST"))
(unless (find-package "SINEVA_NAV::SETINITIALPOSESRVRESPONSE")
  (make-package "SINEVA_NAV::SETINITIALPOSESRVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass sineva_nav::SetInitialPoseSrvRequest
  :super ros::object
  :slots (_initialpose ))

(defmethod sineva_nav::SetInitialPoseSrvRequest
  (:init
   (&key
    ((:initialpose __initialpose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _initialpose __initialpose)
   self)
  (:initialpose
   (&rest __initialpose)
   (if (keywordp (car __initialpose))
       (send* _initialpose __initialpose)
     (progn
       (if __initialpose (setq _initialpose (car __initialpose)))
       _initialpose)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _initialpose
    (send _initialpose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _initialpose
       (send _initialpose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _initialpose
     (send _initialpose :deserialize buf ptr-) (incf ptr- (send _initialpose :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::SetInitialPoseSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::SetInitialPoseSrvResponse
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

(defclass sineva_nav::SetInitialPoseSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::SetInitialPoseSrv :md5sum-) "f79b49745aeb97ecd996566018ba09e8")
(setf (get sineva_nav::SetInitialPoseSrv :datatype-) "sineva_nav/SetInitialPoseSrv")
(setf (get sineva_nav::SetInitialPoseSrv :request) sineva_nav::SetInitialPoseSrvRequest)
(setf (get sineva_nav::SetInitialPoseSrv :response) sineva_nav::SetInitialPoseSrvResponse)

(defmethod sineva_nav::SetInitialPoseSrvRequest
  (:response () (instance sineva_nav::SetInitialPoseSrvResponse :init)))

(setf (get sineva_nav::SetInitialPoseSrvRequest :md5sum-) "f79b49745aeb97ecd996566018ba09e8")
(setf (get sineva_nav::SetInitialPoseSrvRequest :datatype-) "sineva_nav/SetInitialPoseSrvRequest")
(setf (get sineva_nav::SetInitialPoseSrvRequest :definition-)
      "# request message
geometry_msgs/Pose initialpose

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

(setf (get sineva_nav::SetInitialPoseSrvResponse :md5sum-) "f79b49745aeb97ecd996566018ba09e8")
(setf (get sineva_nav::SetInitialPoseSrvResponse :datatype-) "sineva_nav/SetInitialPoseSrvResponse")
(setf (get sineva_nav::SetInitialPoseSrvResponse :definition-)
      "# request message
geometry_msgs/Pose initialpose

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



(provide :sineva_nav/SetInitialPoseSrv "f79b49745aeb97ecd996566018ba09e8")


