;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::JsonCommSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'JsonCommSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::JSONCOMMSRV")
  (make-package "SINEVA_NAV::JSONCOMMSRV"))
(unless (find-package "SINEVA_NAV::JSONCOMMSRVREQUEST")
  (make-package "SINEVA_NAV::JSONCOMMSRVREQUEST"))
(unless (find-package "SINEVA_NAV::JSONCOMMSRVRESPONSE")
  (make-package "SINEVA_NAV::JSONCOMMSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::JsonCommSrvRequest
  :super ros::object
  :slots (_data ))

(defmethod sineva_nav::JsonCommSrvRequest
  (:init
   (&key
    ((:data __data) "")
    )
   (send-super :init)
   (setq _data (string __data))
   self)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; string _data
    4 (length _data)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _data
       (write-long (length _data) s) (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _data
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _data (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::JsonCommSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::JsonCommSrvResponse
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

(defclass sineva_nav::JsonCommSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::JsonCommSrv :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::JsonCommSrv :datatype-) "sineva_nav/JsonCommSrv")
(setf (get sineva_nav::JsonCommSrv :request) sineva_nav::JsonCommSrvRequest)
(setf (get sineva_nav::JsonCommSrv :response) sineva_nav::JsonCommSrvResponse)

(defmethod sineva_nav::JsonCommSrvRequest
  (:response () (instance sineva_nav::JsonCommSrvResponse :init)))

(setf (get sineva_nav::JsonCommSrvRequest :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::JsonCommSrvRequest :datatype-) "sineva_nav/JsonCommSrvRequest")
(setf (get sineva_nav::JsonCommSrvRequest :definition-)
      "string data
---
int32 result

")

(setf (get sineva_nav::JsonCommSrvResponse :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::JsonCommSrvResponse :datatype-) "sineva_nav/JsonCommSrvResponse")
(setf (get sineva_nav::JsonCommSrvResponse :definition-)
      "string data
---
int32 result

")



(provide :sineva_nav/JsonCommSrv "ca17d783c86e928bc4beab3674acd9b4")


