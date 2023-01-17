;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::GetStateSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'GetStateSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::GETSTATESRV")
  (make-package "SINEVA_NAV::GETSTATESRV"))
(unless (find-package "SINEVA_NAV::GETSTATESRVREQUEST")
  (make-package "SINEVA_NAV::GETSTATESRVREQUEST"))
(unless (find-package "SINEVA_NAV::GETSTATESRVRESPONSE")
  (make-package "SINEVA_NAV::GETSTATESRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::GetStateSrvRequest
  :super ros::object
  :slots (_state_id ))

(defmethod sineva_nav::GetStateSrvRequest
  (:init
   (&key
    ((:state_id __state_id) "")
    )
   (send-super :init)
   (setq _state_id (string __state_id))
   self)
  (:state_id
   (&optional __state_id)
   (if __state_id (setq _state_id __state_id)) _state_id)
  (:serialization-length
   ()
   (+
    ;; string _state_id
    4 (length _state_id)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _state_id
       (write-long (length _state_id) s) (princ _state_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _state_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::GetStateSrvResponse
  :super ros::object
  :slots (_goal_id _status_code ))

(defmethod sineva_nav::GetStateSrvResponse
  (:init
   (&key
    ((:goal_id __goal_id) "")
    ((:status_code __status_code) 0)
    )
   (send-super :init)
   (setq _goal_id (string __goal_id))
   (setq _status_code (round __status_code))
   self)
  (:goal_id
   (&optional __goal_id)
   (if __goal_id (setq _goal_id __goal_id)) _goal_id)
  (:status_code
   (&optional __status_code)
   (if __status_code (setq _status_code __status_code)) _status_code)
  (:serialization-length
   ()
   (+
    ;; string _goal_id
    4 (length _goal_id)
    ;; int32 _status_code
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _goal_id
       (write-long (length _goal_id) s) (princ _goal_id s)
     ;; int32 _status_code
       (write-long _status_code s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _goal_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _goal_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _status_code
     (setq _status_code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::GetStateSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::GetStateSrv :md5sum-) "702496c6638c59bcef5d602cda36b30f")
(setf (get sineva_nav::GetStateSrv :datatype-) "sineva_nav/GetStateSrv")
(setf (get sineva_nav::GetStateSrv :request) sineva_nav::GetStateSrvRequest)
(setf (get sineva_nav::GetStateSrv :response) sineva_nav::GetStateSrvResponse)

(defmethod sineva_nav::GetStateSrvRequest
  (:response () (instance sineva_nav::GetStateSrvResponse :init)))

(setf (get sineva_nav::GetStateSrvRequest :md5sum-) "702496c6638c59bcef5d602cda36b30f")
(setf (get sineva_nav::GetStateSrvRequest :datatype-) "sineva_nav/GetStateSrvRequest")
(setf (get sineva_nav::GetStateSrvRequest :definition-)
      "# request message
string state_id
---
# response message
string goal_id
int32 status_code

")

(setf (get sineva_nav::GetStateSrvResponse :md5sum-) "702496c6638c59bcef5d602cda36b30f")
(setf (get sineva_nav::GetStateSrvResponse :datatype-) "sineva_nav/GetStateSrvResponse")
(setf (get sineva_nav::GetStateSrvResponse :definition-)
      "# request message
string state_id
---
# response message
string goal_id
int32 status_code

")



(provide :sineva_nav/GetStateSrv "702496c6638c59bcef5d602cda36b30f")


