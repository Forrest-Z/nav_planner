;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::goal_status)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'goal_status (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::GOAL_STATUS")
  (make-package "SINEVA_NAV::GOAL_STATUS"))
(unless (find-package "SINEVA_NAV::GOAL_STATUSREQUEST")
  (make-package "SINEVA_NAV::GOAL_STATUSREQUEST"))
(unless (find-package "SINEVA_NAV::GOAL_STATUSRESPONSE")
  (make-package "SINEVA_NAV::GOAL_STATUSRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::goal_statusRequest
  :super ros::object
  :slots (_x _y _yaw ))

(defmethod sineva_nav::goal_statusRequest
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

(defclass sineva_nav::goal_statusResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::goal_statusResponse
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

(defclass sineva_nav::goal_status
  :super ros::object
  :slots ())

(setf (get sineva_nav::goal_status :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::goal_status :datatype-) "sineva_nav/goal_status")
(setf (get sineva_nav::goal_status :request) sineva_nav::goal_statusRequest)
(setf (get sineva_nav::goal_status :response) sineva_nav::goal_statusResponse)

(defmethod sineva_nav::goal_statusRequest
  (:response () (instance sineva_nav::goal_statusResponse :init)))

(setf (get sineva_nav::goal_statusRequest :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::goal_statusRequest :datatype-) "sineva_nav/goal_statusRequest")
(setf (get sineva_nav::goal_statusRequest :definition-)
      "# goal pose
float32 x
float32 y
float32 yaw
---
# true--occupied  false--free
bool result
")

(setf (get sineva_nav::goal_statusResponse :md5sum-) "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(setf (get sineva_nav::goal_statusResponse :datatype-) "sineva_nav/goal_statusResponse")
(setf (get sineva_nav::goal_statusResponse :definition-)
      "# goal pose
float32 x
float32 y
float32 yaw
---
# true--occupied  false--free
bool result
")



(provide :sineva_nav/goal_status "3d638b2cdc898e8eb5d6b3cfc2f2c14b")


