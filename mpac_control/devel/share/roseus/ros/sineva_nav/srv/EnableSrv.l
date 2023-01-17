;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::EnableSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'EnableSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::ENABLESRV")
  (make-package "SINEVA_NAV::ENABLESRV"))
(unless (find-package "SINEVA_NAV::ENABLESRVREQUEST")
  (make-package "SINEVA_NAV::ENABLESRVREQUEST"))
(unless (find-package "SINEVA_NAV::ENABLESRVRESPONSE")
  (make-package "SINEVA_NAV::ENABLESRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::EnableSrvRequest
  :super ros::object
  :slots (_enable ))

(defmethod sineva_nav::EnableSrvRequest
  (:init
   (&key
    ((:enable __enable) 0)
    )
   (send-super :init)
   (setq _enable (round __enable))
   self)
  (:enable
   (&optional __enable)
   (if __enable (setq _enable __enable)) _enable)
  (:serialization-length
   ()
   (+
    ;; int32 _enable
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _enable
       (write-long _enable s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _enable
     (setq _enable (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::EnableSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::EnableSrvResponse
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

(defclass sineva_nav::EnableSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::EnableSrv :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::EnableSrv :datatype-) "sineva_nav/EnableSrv")
(setf (get sineva_nav::EnableSrv :request) sineva_nav::EnableSrvRequest)
(setf (get sineva_nav::EnableSrv :response) sineva_nav::EnableSrvResponse)

(defmethod sineva_nav::EnableSrvRequest
  (:response () (instance sineva_nav::EnableSrvResponse :init)))

(setf (get sineva_nav::EnableSrvRequest :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::EnableSrvRequest :datatype-) "sineva_nav/EnableSrvRequest")
(setf (get sineva_nav::EnableSrvRequest :definition-)
      "# request message
int32 enable
---
# response message
int32 result

")

(setf (get sineva_nav::EnableSrvResponse :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::EnableSrvResponse :datatype-) "sineva_nav/EnableSrvResponse")
(setf (get sineva_nav::EnableSrvResponse :definition-)
      "# request message
int32 enable
---
# response message
int32 result

")



(provide :sineva_nav/EnableSrv "453c8349175735b023f9d38fc609cbe6")


