;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::CheckGoalStatusSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'CheckGoalStatusSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::CHECKGOALSTATUSSRV")
  (make-package "SINEVA_NAV::CHECKGOALSTATUSSRV"))
(unless (find-package "SINEVA_NAV::CHECKGOALSTATUSSRVREQUEST")
  (make-package "SINEVA_NAV::CHECKGOALSTATUSSRVREQUEST"))
(unless (find-package "SINEVA_NAV::CHECKGOALSTATUSSRVRESPONSE")
  (make-package "SINEVA_NAV::CHECKGOALSTATUSSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::CheckGoalStatusSrvRequest
  :super ros::object
  :slots (_x _y _yaw ))

(defmethod sineva_nav::CheckGoalStatusSrvRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:yaw __yaw) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _yaw (float __yaw))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _yaw
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yaw
     (setq _yaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::CheckGoalStatusSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::CheckGoalStatusSrvResponse
  (:init
   (&key
    ((:result __result) nil)
    )
   (send-super :init)
   (setq _result __result)
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; bool _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _result
       (if _result (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _result
     (setq _result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass sineva_nav::CheckGoalStatusSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::CheckGoalStatusSrv :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::CheckGoalStatusSrv :datatype-) "sineva_nav/CheckGoalStatusSrv")
(setf (get sineva_nav::CheckGoalStatusSrv :request) sineva_nav::CheckGoalStatusSrvRequest)
(setf (get sineva_nav::CheckGoalStatusSrv :response) sineva_nav::CheckGoalStatusSrvResponse)

(defmethod sineva_nav::CheckGoalStatusSrvRequest
  (:response () (instance sineva_nav::CheckGoalStatusSrvResponse :init)))

(setf (get sineva_nav::CheckGoalStatusSrvRequest :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::CheckGoalStatusSrvRequest :datatype-) "sineva_nav/CheckGoalStatusSrvRequest")
(setf (get sineva_nav::CheckGoalStatusSrvRequest :definition-)
      "# goal pose
float32 x
float32 y
float32 yaw
---
# true--occupied  false--free
bool result
")

(setf (get sineva_nav::CheckGoalStatusSrvResponse :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::CheckGoalStatusSrvResponse :datatype-) "sineva_nav/CheckGoalStatusSrvResponse")
(setf (get sineva_nav::CheckGoalStatusSrvResponse :definition-)
      "# goal pose
float32 x
float32 y
float32 yaw
---
# true--occupied  false--free
bool result
")



(provide :sineva_nav/CheckGoalStatusSrv "3d638b2cdc898e8eb5d6b3cfc2f2c14b")


