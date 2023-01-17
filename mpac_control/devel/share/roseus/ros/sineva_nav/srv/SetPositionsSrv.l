;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SetPositionsSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SetPositionsSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SETPOSITIONSSRV")
  (make-package "SINEVA_NAV::SETPOSITIONSSRV"))
(unless (find-package "SINEVA_NAV::SETPOSITIONSSRVREQUEST")
  (make-package "SINEVA_NAV::SETPOSITIONSSRVREQUEST"))
(unless (find-package "SINEVA_NAV::SETPOSITIONSSRVRESPONSE")
  (make-package "SINEVA_NAV::SETPOSITIONSSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::SetPositionsSrvRequest
  :super ros::object
  :slots (_positions ))

(defmethod sineva_nav::SetPositionsSrvRequest
  (:init
   (&key
    ((:positions __positions) (let (r) (dotimes (i 0) (push (instance sineva_nav::position :init) r)) r))
    )
   (send-super :init)
   (setq _positions __positions)
   self)
  (:positions
   (&rest __positions)
   (if (keywordp (car __positions))
       (send* _positions __positions)
     (progn
       (if __positions (setq _positions (car __positions)))
       _positions)))
  (:serialization-length
   ()
   (+
    ;; sineva_nav/position[] _positions
    (apply #'+ (send-all _positions :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sineva_nav/position[] _positions
     (write-long (length _positions) s)
     (dolist (elem _positions)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sineva_nav/position[] _positions
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _positions (let (r) (dotimes (i n) (push (instance sineva_nav::position :init) r)) r))
     (dolist (elem- _positions)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass sineva_nav::SetPositionsSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::SetPositionsSrvResponse
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

(defclass sineva_nav::SetPositionsSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::SetPositionsSrv :md5sum-) "4b4524857e30c20d60b58e736d911c02")
(setf (get sineva_nav::SetPositionsSrv :datatype-) "sineva_nav/SetPositionsSrv")
(setf (get sineva_nav::SetPositionsSrv :request) sineva_nav::SetPositionsSrvRequest)
(setf (get sineva_nav::SetPositionsSrv :response) sineva_nav::SetPositionsSrvResponse)

(defmethod sineva_nav::SetPositionsSrvRequest
  (:response () (instance sineva_nav::SetPositionsSrvResponse :init)))

(setf (get sineva_nav::SetPositionsSrvRequest :md5sum-) "4b4524857e30c20d60b58e736d911c02")
(setf (get sineva_nav::SetPositionsSrvRequest :datatype-) "sineva_nav/SetPositionsSrvRequest")
(setf (get sineva_nav::SetPositionsSrvRequest :definition-)
      "# request message
sineva_nav/position[] positions

================================================================================
MSG: sineva_nav/position
string id
float32 x
float32 y
---
# response message
int32 result

")

(setf (get sineva_nav::SetPositionsSrvResponse :md5sum-) "4b4524857e30c20d60b58e736d911c02")
(setf (get sineva_nav::SetPositionsSrvResponse :datatype-) "sineva_nav/SetPositionsSrvResponse")
(setf (get sineva_nav::SetPositionsSrvResponse :definition-)
      "# request message
sineva_nav/position[] positions

================================================================================
MSG: sineva_nav/position
string id
float32 x
float32 y
---
# response message
int32 result

")



(provide :sineva_nav/SetPositionsSrv "4b4524857e30c20d60b58e736d911c02")


