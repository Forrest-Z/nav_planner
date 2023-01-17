;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::base_sensor_data)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'base_sensor_data (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::BASE_SENSOR_DATA")
  (make-package "SINEVA_NAV::BASE_SENSOR_DATA"))

(in-package "ROS")
;;//! \htmlinclude base_sensor_data.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass sineva_nav::base_sensor_data
  :super ros::object
  :slots (_header _power _iEncoder_l _iEncoder_r _iVoltage _iCurrent _quantity _batTemp _capicity _iLeftMotor _iRightMotor _iScram _iCrash _ioStatus _iCharge _iShutdown _iReset _iAuto _iLift ))

(defmethod sineva_nav::base_sensor_data
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:power __power) 0.0)
    ((:iEncoder_l __iEncoder_l) 0)
    ((:iEncoder_r __iEncoder_r) 0)
    ((:iVoltage __iVoltage) 0)
    ((:iCurrent __iCurrent) 0)
    ((:quantity __quantity) 0)
    ((:batTemp __batTemp) 0)
    ((:capicity __capicity) 0)
    ((:iLeftMotor __iLeftMotor) 0)
    ((:iRightMotor __iRightMotor) 0)
    ((:iScram __iScram) 0)
    ((:iCrash __iCrash) 0)
    ((:ioStatus __ioStatus) 0)
    ((:iCharge __iCharge) 0)
    ((:iShutdown __iShutdown) 0)
    ((:iReset __iReset) 0)
    ((:iAuto __iAuto) 0)
    ((:iLift __iLift) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _power (float __power))
   (setq _iEncoder_l (round __iEncoder_l))
   (setq _iEncoder_r (round __iEncoder_r))
   (setq _iVoltage (round __iVoltage))
   (setq _iCurrent (round __iCurrent))
   (setq _quantity (round __quantity))
   (setq _batTemp (round __batTemp))
   (setq _capicity (round __capicity))
   (setq _iLeftMotor (round __iLeftMotor))
   (setq _iRightMotor (round __iRightMotor))
   (setq _iScram (round __iScram))
   (setq _iCrash (round __iCrash))
   (setq _ioStatus (round __ioStatus))
   (setq _iCharge (round __iCharge))
   (setq _iShutdown (round __iShutdown))
   (setq _iReset (round __iReset))
   (setq _iAuto (round __iAuto))
   (setq _iLift (round __iLift))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:power
   (&optional __power)
   (if __power (setq _power __power)) _power)
  (:iEncoder_l
   (&optional __iEncoder_l)
   (if __iEncoder_l (setq _iEncoder_l __iEncoder_l)) _iEncoder_l)
  (:iEncoder_r
   (&optional __iEncoder_r)
   (if __iEncoder_r (setq _iEncoder_r __iEncoder_r)) _iEncoder_r)
  (:iVoltage
   (&optional __iVoltage)
   (if __iVoltage (setq _iVoltage __iVoltage)) _iVoltage)
  (:iCurrent
   (&optional __iCurrent)
   (if __iCurrent (setq _iCurrent __iCurrent)) _iCurrent)
  (:quantity
   (&optional __quantity)
   (if __quantity (setq _quantity __quantity)) _quantity)
  (:batTemp
   (&optional __batTemp)
   (if __batTemp (setq _batTemp __batTemp)) _batTemp)
  (:capicity
   (&optional __capicity)
   (if __capicity (setq _capicity __capicity)) _capicity)
  (:iLeftMotor
   (&optional __iLeftMotor)
   (if __iLeftMotor (setq _iLeftMotor __iLeftMotor)) _iLeftMotor)
  (:iRightMotor
   (&optional __iRightMotor)
   (if __iRightMotor (setq _iRightMotor __iRightMotor)) _iRightMotor)
  (:iScram
   (&optional __iScram)
   (if __iScram (setq _iScram __iScram)) _iScram)
  (:iCrash
   (&optional __iCrash)
   (if __iCrash (setq _iCrash __iCrash)) _iCrash)
  (:ioStatus
   (&optional __ioStatus)
   (if __ioStatus (setq _ioStatus __ioStatus)) _ioStatus)
  (:iCharge
   (&optional __iCharge)
   (if __iCharge (setq _iCharge __iCharge)) _iCharge)
  (:iShutdown
   (&optional __iShutdown)
   (if __iShutdown (setq _iShutdown __iShutdown)) _iShutdown)
  (:iReset
   (&optional __iReset)
   (if __iReset (setq _iReset __iReset)) _iReset)
  (:iAuto
   (&optional __iAuto)
   (if __iAuto (setq _iAuto __iAuto)) _iAuto)
  (:iLift
   (&optional __iLift)
   (if __iLift (setq _iLift __iLift)) _iLift)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _power
    4
    ;; int32 _iEncoder_l
    4
    ;; int32 _iEncoder_r
    4
    ;; int16 _iVoltage
    2
    ;; int16 _iCurrent
    2
    ;; int8 _quantity
    1
    ;; int8 _batTemp
    1
    ;; int8 _capicity
    1
    ;; int8 _iLeftMotor
    1
    ;; int8 _iRightMotor
    1
    ;; int8 _iScram
    1
    ;; int8 _iCrash
    1
    ;; int8 _ioStatus
    1
    ;; int8 _iCharge
    1
    ;; int8 _iShutdown
    1
    ;; int8 _iReset
    1
    ;; int8 _iAuto
    1
    ;; int8 _iLift
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _power
       (sys::poke _power (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _iEncoder_l
       (write-long _iEncoder_l s)
     ;; int32 _iEncoder_r
       (write-long _iEncoder_r s)
     ;; int16 _iVoltage
       (write-word _iVoltage s)
     ;; int16 _iCurrent
       (write-word _iCurrent s)
     ;; int8 _quantity
       (write-byte _quantity s)
     ;; int8 _batTemp
       (write-byte _batTemp s)
     ;; int8 _capicity
       (write-byte _capicity s)
     ;; int8 _iLeftMotor
       (write-byte _iLeftMotor s)
     ;; int8 _iRightMotor
       (write-byte _iRightMotor s)
     ;; int8 _iScram
       (write-byte _iScram s)
     ;; int8 _iCrash
       (write-byte _iCrash s)
     ;; int8 _ioStatus
       (write-byte _ioStatus s)
     ;; int8 _iCharge
       (write-byte _iCharge s)
     ;; int8 _iShutdown
       (write-byte _iShutdown s)
     ;; int8 _iReset
       (write-byte _iReset s)
     ;; int8 _iAuto
       (write-byte _iAuto s)
     ;; int8 _iLift
       (write-byte _iLift s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _power
     (setq _power (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _iEncoder_l
     (setq _iEncoder_l (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _iEncoder_r
     (setq _iEncoder_r (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int16 _iVoltage
     (setq _iVoltage (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _iCurrent
     (setq _iCurrent (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int8 _quantity
     (setq _quantity (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _quantity 127) (setq _quantity (- _quantity 256)))
   ;; int8 _batTemp
     (setq _batTemp (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _batTemp 127) (setq _batTemp (- _batTemp 256)))
   ;; int8 _capicity
     (setq _capicity (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _capicity 127) (setq _capicity (- _capicity 256)))
   ;; int8 _iLeftMotor
     (setq _iLeftMotor (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iLeftMotor 127) (setq _iLeftMotor (- _iLeftMotor 256)))
   ;; int8 _iRightMotor
     (setq _iRightMotor (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iRightMotor 127) (setq _iRightMotor (- _iRightMotor 256)))
   ;; int8 _iScram
     (setq _iScram (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iScram 127) (setq _iScram (- _iScram 256)))
   ;; int8 _iCrash
     (setq _iCrash (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iCrash 127) (setq _iCrash (- _iCrash 256)))
   ;; int8 _ioStatus
     (setq _ioStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ioStatus 127) (setq _ioStatus (- _ioStatus 256)))
   ;; int8 _iCharge
     (setq _iCharge (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iCharge 127) (setq _iCharge (- _iCharge 256)))
   ;; int8 _iShutdown
     (setq _iShutdown (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iShutdown 127) (setq _iShutdown (- _iShutdown 256)))
   ;; int8 _iReset
     (setq _iReset (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iReset 127) (setq _iReset (- _iReset 256)))
   ;; int8 _iAuto
     (setq _iAuto (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iAuto 127) (setq _iAuto (- _iAuto 256)))
   ;; int8 _iLift
     (setq _iLift (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _iLift 127) (setq _iLift (- _iLift 256)))
   ;;
   self)
  )

(setf (get sineva_nav::base_sensor_data :md5sum-) "34841bb51091b10dfad93c5e9e27dde1")
(setf (get sineva_nav::base_sensor_data :datatype-) "sineva_nav/base_sensor_data")
(setf (get sineva_nav::base_sensor_data :definition-)
      "Header header
float32 power
int32 iEncoder_l
int32 iEncoder_r
int16 iVoltage
int16 iCurrent
int8 quantity
int8 batTemp
int8 capicity
int8 iLeftMotor
int8 iRightMotor
int8 iScram
int8 iCrash
int8 ioStatus
int8 iCharge
int8 iShutdown
int8 iReset
int8 iAuto
int8 iLift
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



(provide :sineva_nav/base_sensor_data "34841bb51091b10dfad93c5e9e27dde1")


