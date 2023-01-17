;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::CloseSafeAreaSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'CloseSafeAreaSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::CLOSESAFEAREASRV")
  (make-package "SINEVA_NAV::CLOSESAFEAREASRV"))
(unless (find-package "SINEVA_NAV::CLOSESAFEAREASRVREQUEST")
  (make-package "SINEVA_NAV::CLOSESAFEAREASRVREQUEST"))
(unless (find-package "SINEVA_NAV::CLOSESAFEAREASRVRESPONSE")
  (make-package "SINEVA_NAV::CLOSESAFEAREASRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::CloseSafeAreaSrvRequest
  :super ros::object
  :slots (_enable ))

(defmethod sineva_nav::CloseSafeAreaSrvRequest
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

(defclass sineva_nav::CloseSafeAreaSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::CloseSafeAreaSrvResponse
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

(defclass sineva_nav::CloseSafeAreaSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::CloseSafeAreaSrv :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::CloseSafeAreaSrv :datatype-) "sineva_nav/CloseSafeAreaSrv")
(setf (get sineva_nav::CloseSafeAreaSrv :request) sineva_nav::CloseSafeAreaSrvRequest)
(setf (get sineva_nav::CloseSafeAreaSrv :response) sineva_nav::CloseSafeAreaSrvResponse)

(defmethod sineva_nav::CloseSafeAreaSrvRequest
  (:response () (instance sineva_nav::CloseSafeAreaSrvResponse :init)))

(setf (get sineva_nav::CloseSafeAreaSrvRequest :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::CloseSafeAreaSrvRequest :datatype-) "sineva_nav/CloseSafeAreaSrvRequest")
(setf (get sineva_nav::CloseSafeAreaSrvRequest :definition-)
      "# request message
int32 enable
---
# response message
int32 result

")

(setf (get sineva_nav::CloseSafeAreaSrvResponse :md5sum-) "453c8349175735b023f9d38fc609cbe6")
(setf (get sineva_nav::CloseSafeAreaSrvResponse :datatype-) "sineva_nav/CloseSafeAreaSrvResponse")
(setf (get sineva_nav::CloseSafeAreaSrvResponse :definition-)
      "# request message
int32 enable
---
# response message
int32 result

")



(provide :sineva_nav/CloseSafeAreaSrv "453c8349175735b023f9d38fc609cbe6")


