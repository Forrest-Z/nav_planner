;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::BaseData)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'BaseData (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::BASEDATA")
  (make-package "SINEVA_NAV::BASEDATA"))

(in-package "ROS")
;;//! \htmlinclude BaseData.msg.html


(defclass sineva_nav::BaseData
  :super ros::object
  :slots (_type _data ))

(defmethod sineva_nav::BaseData
  (:init
   (&key
    ((:type __type) 0)
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _data __data)
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; uint8 _type
    1
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _type
       (write-byte _type s)
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get sineva_nav::BaseData :md5sum-) "fa8c6edfee3919656731e93d6bd477b8")
(setf (get sineva_nav::BaseData :datatype-) "sineva_nav/BaseData")
(setf (get sineva_nav::BaseData :definition-)
      "uint8 type
uint8[] data
")



(provide :sineva_nav/BaseData "fa8c6edfee3919656731e93d6bd477b8")


