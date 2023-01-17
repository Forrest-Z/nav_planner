;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SlamStatus)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SlamStatus (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SLAMSTATUS")
  (make-package "SINEVA_NAV::SLAMSTATUS"))

(in-package "ROS")
;;//! \htmlinclude SlamStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sineva_nav::SlamStatus
  :super ros::object
  :slots (_header _status _result _information ))

(defmethod sineva_nav::SlamStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:status __status) "")
    ((:result __result) nil)
    ((:information __information) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _status (string __status))
   (setq _result __result)
   (setq _information (float __information))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:information
   (&optional __information)
   (if __information (setq _information __information)) _information)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _status
    4 (length _status)
    ;; bool _result
    1
    ;; float32 _information
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _status
       (write-long (length _status) s) (princ _status s)
     ;; bool _result
       (if _result (write-byte -1 s) (write-byte 0 s))
     ;; float32 _information
       (sys::poke _information (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _status
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _status (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _result
     (setq _result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _information
     (setq _information (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get sineva_nav::SlamStatus :md5sum-) "a7626330be62699453af28c97dc15917")
(setf (get sineva_nav::SlamStatus :datatype-) "sineva_nav/SlamStatus")
(setf (get sineva_nav::SlamStatus :definition-)
      "std_msgs/Header header
string          status      # Current status
bool            result      # Success or failed
float32         information # Other information

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :sineva_nav/SlamStatus "a7626330be62699453af28c97dc15917")


