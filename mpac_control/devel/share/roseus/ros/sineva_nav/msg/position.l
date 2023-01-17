;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::position)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'position (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::POSITION")
  (make-package "SINEVA_NAV::POSITION"))

(in-package "ROS")
;;//! \htmlinclude position.msg.html


(defclass sineva_nav::position
  :super ros::object
  :slots (_id _x _y _r ))

(defmethod sineva_nav::position
  (:init
   (&key
    ((:id __id) "")
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:r __r) 0.0)
    )
   (send-super :init)
   (setq _id (string __id))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _r (float __r))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:serialization-length
   ()
   (+
    ;; string _id
    4 (length _id)
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _r
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _id
       (write-long (length _id) s) (princ _id s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _r
       (sys::poke _r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _r
     (setq _r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get sineva_nav::position :md5sum-) "2b5dece5aaf667954a5f3c6de65b0487")
(setf (get sineva_nav::position :datatype-) "sineva_nav/position")
(setf (get sineva_nav::position :definition-)
      "string id
float32 x
float32 y
float32 r
")



(provide :sineva_nav/position "2b5dece5aaf667954a5f3c6de65b0487")


