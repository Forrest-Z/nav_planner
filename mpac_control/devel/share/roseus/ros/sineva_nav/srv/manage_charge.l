;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::manage_charge)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'manage_charge (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::MANAGE_CHARGE")
  (make-package "SINEVA_NAV::MANAGE_CHARGE"))
(unless (find-package "SINEVA_NAV::MANAGE_CHARGEREQUEST")
  (make-package "SINEVA_NAV::MANAGE_CHARGEREQUEST"))
(unless (find-package "SINEVA_NAV::MANAGE_CHARGERESPONSE")
  (make-package "SINEVA_NAV::MANAGE_CHARGERESPONSE"))

(in-package "ROS")





(defclass sineva_nav::manage_chargeRequest
  :super ros::object
  :slots (_flag _x _y _r _dx _dy _dr ))

(defmethod sineva_nav::manage_chargeRequest
  (:init
   (&key
    ((:flag __flag) "")
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:r __r) 0.0)
    ((:dx __dx) 0.0)
    ((:dy __dy) 0.0)
    ((:dr __dr) 0.0)
    )
   (send-super :init)
   (setq _flag (string __flag))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _r (float __r))
   (setq _dx (float __dx))
   (setq _dy (float __dy))
   (setq _dr (float __dr))
   self)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
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
    ;; string _flag
    4 (length _flag)
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _r
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
     ;; string _flag
       (write-long (length _flag) s) (princ _flag s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _r
       (sys::poke _r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
   ;; string _flag
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _flag (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _r
     (setq _r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dx
     (setq _dx (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dy
     (setq _dy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dr
     (setq _dr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass sineva_nav::manage_chargeResponse
  :super ros::object
  :slots (_result ))

(defmethod sineva_nav::manage_chargeResponse
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

(defclass sineva_nav::manage_charge
  :super ros::object
  :slots ())

(setf (get sineva_nav::manage_charge :md5sum-) "a5c10a0299cfe8117c94010efa5c0025")
(setf (get sineva_nav::manage_charge :datatype-) "sineva_nav/manage_charge")
(setf (get sineva_nav::manage_charge :request) sineva_nav::manage_chargeRequest)
(setf (get sineva_nav::manage_charge :response) sineva_nav::manage_chargeResponse)

(defmethod sineva_nav::manage_chargeRequest
  (:response () (instance sineva_nav::manage_chargeResponse :init)))

(setf (get sineva_nav::manage_chargeRequest :md5sum-) "a5c10a0299cfe8117c94010efa5c0025")
(setf (get sineva_nav::manage_chargeRequest :datatype-) "sineva_nav/manage_chargeRequest")
(setf (get sineva_nav::manage_chargeRequest :definition-)
      "string flag
# dist point
float32 x
float32 y
float32 r
# deviation point
float32 dx
float32 dy
float32 dr
---
int8 result
")

(setf (get sineva_nav::manage_chargeResponse :md5sum-) "a5c10a0299cfe8117c94010efa5c0025")
(setf (get sineva_nav::manage_chargeResponse :datatype-) "sineva_nav/manage_chargeResponse")
(setf (get sineva_nav::manage_chargeResponse :definition-)
      "string flag
# dist point
float32 x
float32 y
float32 r
# deviation point
float32 dx
float32 dy
float32 dr
---
int8 result
")



(provide :sineva_nav/manage_charge "a5c10a0299cfe8117c94010efa5c0025")


