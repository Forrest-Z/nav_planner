;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::MoveStatus)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'MoveStatus (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::MOVESTATUS")
  (make-package "SINEVA_NAV::MOVESTATUS"))
(unless (find-package "SINEVA_NAV::MOVESTATUSREQUEST")
  (make-package "SINEVA_NAV::MOVESTATUSREQUEST"))
(unless (find-package "SINEVA_NAV::MOVESTATUSRESPONSE")
  (make-package "SINEVA_NAV::MOVESTATUSRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::MoveStatusRequest
  :super ros::object
  :slots (_moveStatus _info ))

(defmethod sineva_nav::MoveStatusRequest
  (:init
   (&key
    ((:moveStatus __moveStatus) 0)
    ((:info __info) "")
    )
   (send-super :init)
   (setq _moveStatus (round __moveStatus))
   (setq _info (string __info))
   self)
  (:moveStatus
   (&optional __moveStatus)
   (if __moveStatus (setq _moveStatus __moveStatus)) _moveStatus)
  (:info
   (&optional __info)
   (if __info (setq _info __info)) _info)
  (:serialization-length
   ()
   (+
    ;; int32 _moveStatus
    4
    ;; string _info
    4 (length _info)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _moveStatus
       (write-long _moveStatus s)
     ;; string _info
       (write-long (length _info) s) (princ _info s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _moveStatus
     (setq _moveStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _info
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _info (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::MoveStatusResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::MoveStatusResponse
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
    ;; int8 _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _result
       (write-byte _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _result 127) (setq _result (- _result 256)))
   ;;
   self)
  )

(defclass sineva_nav::MoveStatus
  :super ros::object
  :slots ())

(setf (get sineva_nav::MoveStatus :md5sum-) "f6729728149600a4ea80caa7ab1e5015")
(setf (get sineva_nav::MoveStatus :datatype-) "sineva_nav/MoveStatus")
(setf (get sineva_nav::MoveStatus :request) sineva_nav::MoveStatusRequest)
(setf (get sineva_nav::MoveStatus :response) sineva_nav::MoveStatusResponse)

(defmethod sineva_nav::MoveStatusRequest
  (:response () (instance sineva_nav::MoveStatusResponse :init)))

(setf (get sineva_nav::MoveStatusRequest :md5sum-) "f6729728149600a4ea80caa7ab1e5015")
(setf (get sineva_nav::MoveStatusRequest :datatype-) "sineva_nav/MoveStatusRequest")
(setf (get sineva_nav::MoveStatusRequest :definition-)
      "# request message
int32 moveStatus
string info
---
# response message
int8 result

")

(setf (get sineva_nav::MoveStatusResponse :md5sum-) "f6729728149600a4ea80caa7ab1e5015")
(setf (get sineva_nav::MoveStatusResponse :datatype-) "sineva_nav/MoveStatusResponse")
(setf (get sineva_nav::MoveStatusResponse :definition-)
      "# request message
int32 moveStatus
string info
---
# response message
int8 result

")



(provide :sineva_nav/MoveStatus "f6729728149600a4ea80caa7ab1e5015")


