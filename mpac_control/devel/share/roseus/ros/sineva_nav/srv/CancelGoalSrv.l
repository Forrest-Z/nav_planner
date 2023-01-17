;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::CancelGoalSrv)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'CancelGoalSrv (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::CANCELGOALSRV")
  (make-package "SINEVA_NAV::CANCELGOALSRV"))
(unless (find-package "SINEVA_NAV::CANCELGOALSRVREQUEST")
  (make-package "SINEVA_NAV::CANCELGOALSRVREQUEST"))
(unless (find-package "SINEVA_NAV::CANCELGOALSRVRESPONSE")
  (make-package "SINEVA_NAV::CANCELGOALSRVRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::CancelGoalSrvRequest
  :super ros::object
  :slots (_goal_id ))

(defmethod sineva_nav::CancelGoalSrvRequest
  (:init
   (&key
    ((:goal_id __goal_id) "")
    )
   (send-super :init)
   (setq _goal_id (string __goal_id))
   self)
  (:goal_id
   (&optional __goal_id)
   (if __goal_id (setq _goal_id __goal_id)) _goal_id)
  (:serialization-length
   ()
   (+
    ;; string _goal_id
    4 (length _goal_id)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _goal_id
       (write-long (length _goal_id) s) (princ _goal_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _goal_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _goal_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::CancelGoalSrvResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::CancelGoalSrvResponse
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

(defclass sineva_nav::CancelGoalSrv
  :super ros::object
  :slots ())

(setf (get sineva_nav::CancelGoalSrv :md5sum-) "69b4ce7997dd89357a2ebdc1827d4b0d")
(setf (get sineva_nav::CancelGoalSrv :datatype-) "sineva_nav/CancelGoalSrv")
(setf (get sineva_nav::CancelGoalSrv :request) sineva_nav::CancelGoalSrvRequest)
(setf (get sineva_nav::CancelGoalSrv :response) sineva_nav::CancelGoalSrvResponse)

(defmethod sineva_nav::CancelGoalSrvRequest
  (:response () (instance sineva_nav::CancelGoalSrvResponse :init)))

(setf (get sineva_nav::CancelGoalSrvRequest :md5sum-) "69b4ce7997dd89357a2ebdc1827d4b0d")
(setf (get sineva_nav::CancelGoalSrvRequest :datatype-) "sineva_nav/CancelGoalSrvRequest")
(setf (get sineva_nav::CancelGoalSrvRequest :definition-)
      "# request message
string goal_id
---
# response message
int32 result

")

(setf (get sineva_nav::CancelGoalSrvResponse :md5sum-) "69b4ce7997dd89357a2ebdc1827d4b0d")
(setf (get sineva_nav::CancelGoalSrvResponse :datatype-) "sineva_nav/CancelGoalSrvResponse")
(setf (get sineva_nav::CancelGoalSrvResponse :definition-)
      "# request message
string goal_id
---
# response message
int32 result

")



(provide :sineva_nav/CancelGoalSrv "69b4ce7997dd89357a2ebdc1827d4b0d")


