; Auto-generated. Do not edit!


(cl:in-package sineva_nav-msg)


;//! \htmlinclude base_sensor_data.msg.html

(cl:defclass <base_sensor_data> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (power
    :reader power
    :initarg :power
    :type cl:float
    :initform 0.0)
   (iEncoder_l
    :reader iEncoder_l
    :initarg :iEncoder_l
    :type cl:integer
    :initform 0)
   (iEncoder_r
    :reader iEncoder_r
    :initarg :iEncoder_r
    :type cl:integer
    :initform 0)
   (iVoltage
    :reader iVoltage
    :initarg :iVoltage
    :type cl:fixnum
    :initform 0)
   (iCurrent
    :reader iCurrent
    :initarg :iCurrent
    :type cl:fixnum
    :initform 0)
   (quantity
    :reader quantity
    :initarg :quantity
    :type cl:fixnum
    :initform 0)
   (batTemp
    :reader batTemp
    :initarg :batTemp
    :type cl:fixnum
    :initform 0)
   (capicity
    :reader capicity
    :initarg :capicity
    :type cl:fixnum
    :initform 0)
   (iLeftMotor
    :reader iLeftMotor
    :initarg :iLeftMotor
    :type cl:fixnum
    :initform 0)
   (iRightMotor
    :reader iRightMotor
    :initarg :iRightMotor
    :type cl:fixnum
    :initform 0)
   (iScram
    :reader iScram
    :initarg :iScram
    :type cl:fixnum
    :initform 0)
   (iCrash
    :reader iCrash
    :initarg :iCrash
    :type cl:fixnum
    :initform 0)
   (ioStatus
    :reader ioStatus
    :initarg :ioStatus
    :type cl:fixnum
    :initform 0)
   (iCharge
    :reader iCharge
    :initarg :iCharge
    :type cl:fixnum
    :initform 0)
   (iShutdown
    :reader iShutdown
    :initarg :iShutdown
    :type cl:fixnum
    :initform 0)
   (iReset
    :reader iReset
    :initarg :iReset
    :type cl:fixnum
    :initform 0)
   (iAuto
    :reader iAuto
    :initarg :iAuto
    :type cl:fixnum
    :initform 0)
   (iLift
    :reader iLift
    :initarg :iLift
    :type cl:fixnum
    :initform 0))
)

(cl:defclass base_sensor_data (<base_sensor_data>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <base_sensor_data>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'base_sensor_data)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-msg:<base_sensor_data> is deprecated: use sineva_nav-msg:base_sensor_data instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:header-val is deprecated.  Use sineva_nav-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'power-val :lambda-list '(m))
(cl:defmethod power-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:power-val is deprecated.  Use sineva_nav-msg:power instead.")
  (power m))

(cl:ensure-generic-function 'iEncoder_l-val :lambda-list '(m))
(cl:defmethod iEncoder_l-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iEncoder_l-val is deprecated.  Use sineva_nav-msg:iEncoder_l instead.")
  (iEncoder_l m))

(cl:ensure-generic-function 'iEncoder_r-val :lambda-list '(m))
(cl:defmethod iEncoder_r-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iEncoder_r-val is deprecated.  Use sineva_nav-msg:iEncoder_r instead.")
  (iEncoder_r m))

(cl:ensure-generic-function 'iVoltage-val :lambda-list '(m))
(cl:defmethod iVoltage-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iVoltage-val is deprecated.  Use sineva_nav-msg:iVoltage instead.")
  (iVoltage m))

(cl:ensure-generic-function 'iCurrent-val :lambda-list '(m))
(cl:defmethod iCurrent-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iCurrent-val is deprecated.  Use sineva_nav-msg:iCurrent instead.")
  (iCurrent m))

(cl:ensure-generic-function 'quantity-val :lambda-list '(m))
(cl:defmethod quantity-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:quantity-val is deprecated.  Use sineva_nav-msg:quantity instead.")
  (quantity m))

(cl:ensure-generic-function 'batTemp-val :lambda-list '(m))
(cl:defmethod batTemp-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:batTemp-val is deprecated.  Use sineva_nav-msg:batTemp instead.")
  (batTemp m))

(cl:ensure-generic-function 'capicity-val :lambda-list '(m))
(cl:defmethod capicity-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:capicity-val is deprecated.  Use sineva_nav-msg:capicity instead.")
  (capicity m))

(cl:ensure-generic-function 'iLeftMotor-val :lambda-list '(m))
(cl:defmethod iLeftMotor-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iLeftMotor-val is deprecated.  Use sineva_nav-msg:iLeftMotor instead.")
  (iLeftMotor m))

(cl:ensure-generic-function 'iRightMotor-val :lambda-list '(m))
(cl:defmethod iRightMotor-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iRightMotor-val is deprecated.  Use sineva_nav-msg:iRightMotor instead.")
  (iRightMotor m))

(cl:ensure-generic-function 'iScram-val :lambda-list '(m))
(cl:defmethod iScram-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iScram-val is deprecated.  Use sineva_nav-msg:iScram instead.")
  (iScram m))

(cl:ensure-generic-function 'iCrash-val :lambda-list '(m))
(cl:defmethod iCrash-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iCrash-val is deprecated.  Use sineva_nav-msg:iCrash instead.")
  (iCrash m))

(cl:ensure-generic-function 'ioStatus-val :lambda-list '(m))
(cl:defmethod ioStatus-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:ioStatus-val is deprecated.  Use sineva_nav-msg:ioStatus instead.")
  (ioStatus m))

(cl:ensure-generic-function 'iCharge-val :lambda-list '(m))
(cl:defmethod iCharge-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iCharge-val is deprecated.  Use sineva_nav-msg:iCharge instead.")
  (iCharge m))

(cl:ensure-generic-function 'iShutdown-val :lambda-list '(m))
(cl:defmethod iShutdown-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iShutdown-val is deprecated.  Use sineva_nav-msg:iShutdown instead.")
  (iShutdown m))

(cl:ensure-generic-function 'iReset-val :lambda-list '(m))
(cl:defmethod iReset-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iReset-val is deprecated.  Use sineva_nav-msg:iReset instead.")
  (iReset m))

(cl:ensure-generic-function 'iAuto-val :lambda-list '(m))
(cl:defmethod iAuto-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iAuto-val is deprecated.  Use sineva_nav-msg:iAuto instead.")
  (iAuto m))

(cl:ensure-generic-function 'iLift-val :lambda-list '(m))
(cl:defmethod iLift-val ((m <base_sensor_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:iLift-val is deprecated.  Use sineva_nav-msg:iLift instead.")
  (iLift m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <base_sensor_data>) ostream)
  "Serializes a message object of type '<base_sensor_data>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'power))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'iEncoder_l)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iEncoder_r)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iVoltage)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iCurrent)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'quantity)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'batTemp)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'capicity)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iLeftMotor)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iRightMotor)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iScram)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iCrash)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ioStatus)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iCharge)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iShutdown)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iReset)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iAuto)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'iLift)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <base_sensor_data>) istream)
  "Deserializes a message object of type '<base_sensor_data>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'power) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iEncoder_l) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iEncoder_r) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iVoltage) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iCurrent) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'quantity) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'batTemp) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'capicity) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iLeftMotor) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iRightMotor) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iScram) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iCrash) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ioStatus) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iCharge) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iShutdown) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iReset) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iAuto) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iLift) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<base_sensor_data>)))
  "Returns string type for a message object of type '<base_sensor_data>"
  "sineva_nav/base_sensor_data")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'base_sensor_data)))
  "Returns string type for a message object of type 'base_sensor_data"
  "sineva_nav/base_sensor_data")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<base_sensor_data>)))
  "Returns md5sum for a message object of type '<base_sensor_data>"
  "34841bb51091b10dfad93c5e9e27dde1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'base_sensor_data)))
  "Returns md5sum for a message object of type 'base_sensor_data"
  "34841bb51091b10dfad93c5e9e27dde1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<base_sensor_data>)))
  "Returns full string definition for message of type '<base_sensor_data>"
  (cl:format cl:nil "Header header~%float32 power~%int32 iEncoder_l~%int32 iEncoder_r~%int16 iVoltage~%int16 iCurrent~%int8 quantity~%int8 batTemp~%int8 capicity~%int8 iLeftMotor~%int8 iRightMotor~%int8 iScram~%int8 iCrash~%int8 ioStatus~%int8 iCharge~%int8 iShutdown~%int8 iReset~%int8 iAuto~%int8 iLift~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'base_sensor_data)))
  "Returns full string definition for message of type 'base_sensor_data"
  (cl:format cl:nil "Header header~%float32 power~%int32 iEncoder_l~%int32 iEncoder_r~%int16 iVoltage~%int16 iCurrent~%int8 quantity~%int8 batTemp~%int8 capicity~%int8 iLeftMotor~%int8 iRightMotor~%int8 iScram~%int8 iCrash~%int8 ioStatus~%int8 iCharge~%int8 iShutdown~%int8 iReset~%int8 iAuto~%int8 iLift~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <base_sensor_data>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     2
     2
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <base_sensor_data>))
  "Converts a ROS message object to a list"
  (cl:list 'base_sensor_data
    (cl:cons ':header (header msg))
    (cl:cons ':power (power msg))
    (cl:cons ':iEncoder_l (iEncoder_l msg))
    (cl:cons ':iEncoder_r (iEncoder_r msg))
    (cl:cons ':iVoltage (iVoltage msg))
    (cl:cons ':iCurrent (iCurrent msg))
    (cl:cons ':quantity (quantity msg))
    (cl:cons ':batTemp (batTemp msg))
    (cl:cons ':capicity (capicity msg))
    (cl:cons ':iLeftMotor (iLeftMotor msg))
    (cl:cons ':iRightMotor (iRightMotor msg))
    (cl:cons ':iScram (iScram msg))
    (cl:cons ':iCrash (iCrash msg))
    (cl:cons ':ioStatus (ioStatus msg))
    (cl:cons ':iCharge (iCharge msg))
    (cl:cons ':iShutdown (iShutdown msg))
    (cl:cons ':iReset (iReset msg))
    (cl:cons ':iAuto (iAuto msg))
    (cl:cons ':iLift (iLift msg))
))
