;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::BaseCommand)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'BaseCommand (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::BASECOMMAND")
  (make-package "SINEVA_NAV::BASECOMMAND"))
(unless (find-package "SINEVA_NAV::BASECOMMANDREQUEST")
  (make-package "SINEVA_NAV::BASECOMMANDREQUEST"))
(unless (find-package "SINEVA_NAV::BASECOMMANDRESPONSE")
  (make-package "SINEVA_NAV::BASECOMMANDRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::BaseCommandRequest
  :super ros::object
  :slots (_cmd _data ))

(defmethod sineva_nav::BaseCommandRequest
  (:init
   (&key
    ((:cmd __cmd) 0)
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _cmd (round __cmd))
   (setq _data __data)
   self)
  (:cmd
   (&optional __cmd)
   (if __cmd (setq _cmd __cmd)) _cmd)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; uint8 _cmd
    1
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _cmd
       (write-byte _cmd s)
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _cmd
     (setq _cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::BaseCommandResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::BaseCommandResponse
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

(defclass sineva_nav::BaseCommand
  :super ros::object
  :slots ())

(setf (get sineva_nav::BaseCommand :md5sum-) "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(setf (get sineva_nav::BaseCommand :datatype-) "sineva_nav/BaseCommand")
(setf (get sineva_nav::BaseCommand :request) sineva_nav::BaseCommandRequest)
(setf (get sineva_nav::BaseCommand :response) sineva_nav::BaseCommandResponse)

(defmethod sineva_nav::BaseCommandRequest
  (:response () (instance sineva_nav::BaseCommandResponse :init)))

(setf (get sineva_nav::BaseCommandRequest :md5sum-) "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(setf (get sineva_nav::BaseCommandRequest :datatype-) "sineva_nav/BaseCommandRequest")
(setf (get sineva_nav::BaseCommandRequest :definition-)
      "uint8 cmd
uint8[] data
---
int32 result

")

(setf (get sineva_nav::BaseCommandResponse :md5sum-) "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(setf (get sineva_nav::BaseCommandResponse :datatype-) "sineva_nav/BaseCommandResponse")
(setf (get sineva_nav::BaseCommandResponse :definition-)
      "uint8 cmd
uint8[] data
---
int32 result

")



(provide :sineva_nav/BaseCommand "f6f2dc9a7416a2a175dbf05bca3c4fdb")


