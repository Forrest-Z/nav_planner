;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::Relocation)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'Relocation (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::RELOCATION")
  (make-package "SINEVA_NAV::RELOCATION"))
(unless (find-package "SINEVA_NAV::RELOCATIONREQUEST")
  (make-package "SINEVA_NAV::RELOCATIONREQUEST"))
(unless (find-package "SINEVA_NAV::RELOCATIONRESPONSE")
  (make-package "SINEVA_NAV::RELOCATIONRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass sineva_nav::RelocationRequest
  :super ros::object
  :slots (_mapId _flag ))

(defmethod sineva_nav::RelocationRequest
  (:init
   (&key
    ((:mapId __mapId) "")
    ((:flag __flag) "")
    )
   (send-super :init)
   (setq _mapId (string __mapId))
   (setq _flag (string __flag))
   self)
  (:mapId
   (&optional __mapId)
   (if __mapId (setq _mapId __mapId)) _mapId)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:serialization-length
   ()
   (+
    ;; string _mapId
    4 (length _mapId)
    ;; string _flag
    4 (length _flag)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _mapId
       (write-long (length _mapId) s) (princ _mapId s)
     ;; string _flag
       (write-long (length _flag) s) (princ _flag s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _mapId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mapId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _flag
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _flag (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::RelocationResponse
  :super ros::object
  :slots (_result _mapId _pose ))

(defmethod sineva_nav::RelocationResponse
  (:init
   (&key
    ((:result __result) 0)
    ((:mapId __mapId) "")
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _result (round __result))
   (setq _mapId (string __mapId))
   (setq _pose __pose)
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:mapId
   (&optional __mapId)
   (if __mapId (setq _mapId __mapId)) _mapId)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; int8 _result
    1
    ;; string _mapId
    4 (length _mapId)
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _result
       (write-byte _result s)
     ;; string _mapId
       (write-long (length _mapId) s) (princ _mapId s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _result 127) (setq _result (- _result 256)))
   ;; string _mapId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mapId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::Relocation
  :super ros::object
  :slots ())

(setf (get sineva_nav::Relocation :md5sum-) "82f1b53ec405d751bfebc95a42bfd76d")
(setf (get sineva_nav::Relocation :datatype-) "sineva_nav/Relocation")
(setf (get sineva_nav::Relocation :request) sineva_nav::RelocationRequest)
(setf (get sineva_nav::Relocation :response) sineva_nav::RelocationResponse)

(defmethod sineva_nav::RelocationRequest
  (:response () (instance sineva_nav::RelocationResponse :init)))

(setf (get sineva_nav::RelocationRequest :md5sum-) "82f1b53ec405d751bfebc95a42bfd76d")
(setf (get sineva_nav::RelocationRequest :datatype-) "sineva_nav/RelocationRequest")
(setf (get sineva_nav::RelocationRequest :definition-)
      "string mapId
string flag
---
int8 result
string mapId
geometry_msgs/Pose pose

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

(setf (get sineva_nav::RelocationResponse :md5sum-) "82f1b53ec405d751bfebc95a42bfd76d")
(setf (get sineva_nav::RelocationResponse :datatype-) "sineva_nav/RelocationResponse")
(setf (get sineva_nav::RelocationResponse :definition-)
      "string mapId
string flag
---
int8 result
string mapId
geometry_msgs/Pose pose

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



(provide :sineva_nav/Relocation "82f1b53ec405d751bfebc95a42bfd76d")


