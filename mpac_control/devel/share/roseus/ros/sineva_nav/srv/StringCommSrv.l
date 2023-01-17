;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::StringCommSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'StringCommSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::STRINGCOMMSRV")
  (make-package "SINEVA_NAV::STRINGCOMMSRV"))
(unless (find-package "SINEVA_NAV::STRINGCOMMSRVREQUEST")
  (make-package "SINEVA_NAV::STRINGCOMMSRVREQUEST"))
(unless (find-package "SINEVA_NAV::STRINGCOMMSRVRESPONSE")
  (make-package "SINEVA_NAV::STRINGCOMMSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::StringCommSrvRequest
  :super ros::object
  :slots (_data ))

(defmethod sineva_nav::StringCommSrvRequest
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

(defclass sineva_nav::StringCommSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::StringCommSrvResponse
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

(defclass sineva_nav::StringCommSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::StringCommSrv :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::StringCommSrv :datatype-) "sineva_nav/StringCommSrv")
(setf (get sineva_nav::StringCommSrv :request) sineva_nav::StringCommSrvRequest)
(setf (get sineva_nav::StringCommSrv :response) sineva_nav::StringCommSrvResponse)

(defmethod sineva_nav::StringCommSrvRequest
  (:response () (instance sineva_nav::StringCommSrvResponse :init)))

(setf (get sineva_nav::StringCommSrvRequest :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::StringCommSrvRequest :datatype-) "sineva_nav/StringCommSrvRequest")
(setf (get sineva_nav::StringCommSrvRequest :definition-)
      "string data
---
int32 result

")

(setf (get sineva_nav::StringCommSrvResponse :md5sum-) "ca17d783c86e928bc4beab3674acd9b4")
(setf (get sineva_nav::StringCommSrvResponse :datatype-) "sineva_nav/StringCommSrvResponse")
(setf (get sineva_nav::StringCommSrvResponse :definition-)
      "string data
---
int32 result

")



(provide :sineva_nav/StringCommSrv "ca17d783c86e928bc4beab3674acd9b4")


