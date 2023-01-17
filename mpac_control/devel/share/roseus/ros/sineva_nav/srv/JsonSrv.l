;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::JsonSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'JsonSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::JSONSRV")
  (make-package "SINEVA_NAV::JSONSRV"))
(unless (find-package "SINEVA_NAV::JSONSRVREQUEST")
  (make-package "SINEVA_NAV::JSONSRVREQUEST"))
(unless (find-package "SINEVA_NAV::JSONSRVRESPONSE")
  (make-package "SINEVA_NAV::JSONSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::JsonSrvRequest
  :super ros::object
  :slots (_flag _dataReq ))

(defmethod sineva_nav::JsonSrvRequest
  (:init
   (&key
    ((:flag __flag) "")
    ((:dataReq __dataReq) "")
    )
   (send-super :init)
   (setq _flag (string __flag))
   (setq _dataReq (string __dataReq))
   self)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:dataReq
   (&optional __dataReq)
   (if __dataReq (setq _dataReq __dataReq)) _dataReq)
  (:serialization-length
   ()
   (+
    ;; string _flag
    4 (length _flag)
    ;; string _dataReq
    4 (length _dataReq)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _flag
       (write-long (length _flag) s) (princ _flag s)
     ;; string _dataReq
       (write-long (length _dataReq) s) (princ _dataReq s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _flag
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _flag (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _dataReq
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _dataReq (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::JsonSrvResponse
  :super ros::object
  :slots (_result _dataRes ))

(defmethod sineva_nav::JsonSrvResponse
  (:init
   (&key
    ((:result __result) 0)
    ((:dataRes __dataRes) "")
    )
   (send-super :init)
   (setq _result (round __result))
   (setq _dataRes (string __dataRes))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:dataRes
   (&optional __dataRes)
   (if __dataRes (setq _dataRes __dataRes)) _dataRes)
  (:serialization-length
   ()
   (+
    ;; int32 _result
    4
    ;; string _dataRes
    4 (length _dataRes)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;; string _dataRes
       (write-long (length _dataRes) s) (princ _dataRes s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _dataRes
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _dataRes (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::JsonSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::JsonSrv :md5sum-) "d8d0627554acfa5cf898bc2c61190e8e")
(setf (get sineva_nav::JsonSrv :datatype-) "sineva_nav/JsonSrv")
(setf (get sineva_nav::JsonSrv :request) sineva_nav::JsonSrvRequest)
(setf (get sineva_nav::JsonSrv :response) sineva_nav::JsonSrvResponse)

(defmethod sineva_nav::JsonSrvRequest
  (:response () (instance sineva_nav::JsonSrvResponse :init)))

(setf (get sineva_nav::JsonSrvRequest :md5sum-) "d8d0627554acfa5cf898bc2c61190e8e")
(setf (get sineva_nav::JsonSrvRequest :datatype-) "sineva_nav/JsonSrvRequest")
(setf (get sineva_nav::JsonSrvRequest :definition-)
      "# request message
string flag
string dataReq
---
# response message
int32 result
string dataRes
")

(setf (get sineva_nav::JsonSrvResponse :md5sum-) "d8d0627554acfa5cf898bc2c61190e8e")
(setf (get sineva_nav::JsonSrvResponse :datatype-) "sineva_nav/JsonSrvResponse")
(setf (get sineva_nav::JsonSrvResponse :definition-)
      "# request message
string flag
string dataReq
---
# response message
int32 result
string dataRes
")



(provide :sineva_nav/JsonSrv "d8d0627554acfa5cf898bc2c61190e8e")


