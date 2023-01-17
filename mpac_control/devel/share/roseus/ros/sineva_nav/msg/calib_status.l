;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::calib_status)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'calib_status (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::CALIB_STATUS")
  (make-package "SINEVA_NAV::CALIB_STATUS"))

(in-package "ROS")
;;//! \htmlinclude calib_status.msg.html


(defclass sineva_nav::calib_status
  :super ros::object
  :slots (_status _data ))

(defmethod sineva_nav::calib_status
  (:init
   (&key
    ((:status __status) 0)
    ((:data __data) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _status (round __status))
   (setq _data __data)
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; int8 _status
    1
    ;; float32[] _data
    (* 4    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _status
       (write-byte _status s)
     ;; float32[] _data
     (write-long (length _data) s)
     (dotimes (i (length _data))
       (sys::poke (elt _data i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _status 127) (setq _status (- _status 256)))
   ;; float32[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _data i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get sineva_nav::calib_status :md5sum-) "d1b06abf01a800329a56a7f3daa01cee")
(setf (get sineva_nav::calib_status :datatype-) "sineva_nav/calib_status")
(setf (get sineva_nav::calib_status :definition-)
      "int8 status
float32[] data
")



(provide :sineva_nav/calib_status "d1b06abf01a800329a56a7f3daa01cee")


