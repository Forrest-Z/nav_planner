;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::charge_point)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'charge_point (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::CHARGE_POINT")
  (make-package "SINEVA_NAV::CHARGE_POINT"))
(unless (find-package "SINEVA_NAV::CHARGE_POINTREQUEST")
  (make-package "SINEVA_NAV::CHARGE_POINTREQUEST"))
(unless (find-package "SINEVA_NAV::CHARGE_POINTRESPONSE")
  (make-package "SINEVA_NAV::CHARGE_POINTRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::charge_pointRequest
  :super ros::object
  :slots (_type _x _y _r _px _py _pr _dx _dy _dr ))

(defmethod sineva_nav::charge_pointRequest
  (:init
   (&key
    ((:type __type) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:r __r) 0.0)
    ((:px __px) 0.0)
    ((:py __py) 0.0)
    ((:pr __pr) 0.0)
    ((:dx __dx) 0.0)
    ((:dy __dy) 0.0)
    ((:dr __dr) 0.0)
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _r (float __r))
   (setq _px (float __px))
   (setq _py (float __py))
   (setq _pr (float __pr))
   (setq _dx (float __dx))
   (setq _dy (float __dy))
   (setq _dr (float __dr))
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:px
   (&optional __px)
   (if __px (setq _px __px)) _px)
  (:py
   (&optional __py)
   (if __py (setq _py __py)) _py)
  (:pr
   (&optional __pr)
   (if __pr (setq _pr __pr)) _pr)
  (:dx
   (&optional __dx)
   (if __dx (setq _dx __dx)) _dx)
  (:dy
   (&optional __dy)
   (if __dy (setq _dy __dy)) _dy)
  (:dr
   (&optional __dr)
   (if __dr (setq _dr __dr)) _dr)
  (:serialization-length
   ()
   (+
    ;; int8 _type
    1
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _r
    4
    ;; float32 _px
    4
    ;; float32 _py
    4
    ;; float32 _pr
    4
    ;; float32 _dx
    4
    ;; float32 _dy
    4
    ;; float32 _dr
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _type
       (write-byte _type s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _r
       (sys::poke _r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _px
       (sys::poke _px (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _py
       (sys::poke _py (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pr
       (sys::poke _pr (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dx
       (sys::poke _dx (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dy
       (sys::poke _dy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dr
       (sys::poke _dr (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _type 127) (setq _type (- _type 256)))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _r
     (setq _r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _px
     (setq _px (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _py
     (setq _py (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pr
     (setq _pr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dx
     (setq _dx (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dy
     (setq _dy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dr
     (setq _dr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::charge_pointResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::charge_pointResponse
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

(defclass sineva_nav::charge_point
  :super ros::object
  :slots ())

(setf (get sineva_nav::charge_point :md5sum-) "6aa97255462c38fddb44d27b34691d65")
(setf (get sineva_nav::charge_point :datatype-) "sineva_nav/charge_point")
(setf (get sineva_nav::charge_point :request) sineva_nav::charge_pointRequest)
(setf (get sineva_nav::charge_point :response) sineva_nav::charge_pointResponse)

(defmethod sineva_nav::charge_pointRequest
  (:response () (instance sineva_nav::charge_pointResponse :init)))

(setf (get sineva_nav::charge_pointRequest :md5sum-) "6aa97255462c38fddb44d27b34691d65")
(setf (get sineva_nav::charge_pointRequest :datatype-) "sineva_nav/charge_pointRequest")
(setf (get sineva_nav::charge_pointRequest :definition-)
      "int8 type
# charger pose
float32 x
float32 y
float32 r
# dock point pose
float32 px
float32 py
float32 pr
# deviation pose
float32 dx
float32 dy
float32 dr
---
int8 result
")

(setf (get sineva_nav::charge_pointResponse :md5sum-) "6aa97255462c38fddb44d27b34691d65")
(setf (get sineva_nav::charge_pointResponse :datatype-) "sineva_nav/charge_pointResponse")
(setf (get sineva_nav::charge_pointResponse :definition-)
      "int8 type
# charger pose
float32 x
float32 y
float32 r
# dock point pose
float32 px
float32 py
float32 pr
# deviation pose
float32 dx
float32 dy
float32 dr
---
int8 result
")



(provide :sineva_nav/charge_point "6aa97255462c38fddb44d27b34691d65")


