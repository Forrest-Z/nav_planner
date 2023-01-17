; Auto-generated. Do not edit!


(cl:in-package sineva_nav-msg)


;//! \htmlinclude SlamStatus.msg.html

(cl:defclass <SlamStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (status
    :reader status
    :initarg :status
    :type cl:string
    :initform "")
   (result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil)
   (information
    :reader information
    :initarg :information
    :type cl:float
    :initform 0.0))
)

(cl:defclass SlamStatus (<SlamStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SlamStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SlamStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-msg:<SlamStatus> is deprecated: use sineva_nav-msg:SlamStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SlamStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:header-val is deprecated.  Use sineva_nav-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <SlamStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:status-val is deprecated.  Use sineva_nav-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <SlamStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:result-val is deprecated.  Use sineva_nav-msg:result instead.")
  (result m))

(cl:ensure-generic-function 'information-val :lambda-list '(m))
(cl:defmethod information-val ((m <SlamStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:information-val is deprecated.  Use sineva_nav-msg:information instead.")
  (information m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SlamStatus>) ostream)
  "Serializes a message object of type '<SlamStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'status))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'information))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SlamStatus>) istream)
  "Deserializes a message object of type '<SlamStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'information) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SlamStatus>)))
  "Returns string type for a message object of type '<SlamStatus>"
  "sineva_nav/SlamStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SlamStatus)))
  "Returns string type for a message object of type 'SlamStatus"
  "sineva_nav/SlamStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SlamStatus>)))
  "Returns md5sum for a message object of type '<SlamStatus>"
  "a7626330be62699453af28c97dc15917")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SlamStatus)))
  "Returns md5sum for a message object of type 'SlamStatus"
  "a7626330be62699453af28c97dc15917")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SlamStatus>)))
  "Returns full string definition for message of type '<SlamStatus>"
  (cl:format cl:nil "std_msgs/Header header~%string          status      # Current status~%bool            result      # Success or failed~%float32         information # Other information~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SlamStatus)))
  "Returns full string definition for message of type 'SlamStatus"
  (cl:format cl:nil "std_msgs/Header header~%string          status      # Current status~%bool            result      # Success or failed~%float32         information # Other information~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SlamStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'status))
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SlamStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'SlamStatus
    (cl:cons ':header (header msg))
    (cl:cons ':status (status msg))
    (cl:cons ':result (result msg))
    (cl:cons ':information (information msg))
))
