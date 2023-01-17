; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude goal_status-request.msg.html

(cl:defclass <goal_status-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (yaw
    :reader yaw
    :initarg :yaw
    :type cl:float
    :initform 0.0))
)

(cl:defclass goal_status-request (<goal_status-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goal_status-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goal_status-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<goal_status-request> is deprecated: use sineva_nav-srv:goal_status-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <goal_status-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:x-val is deprecated.  Use sineva_nav-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <goal_status-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:y-val is deprecated.  Use sineva_nav-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <goal_status-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:yaw-val is deprecated.  Use sineva_nav-srv:yaw instead.")
  (yaw m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goal_status-request>) ostream)
  "Serializes a message object of type '<goal_status-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goal_status-request>) istream)
  "Deserializes a message object of type '<goal_status-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goal_status-request>)))
  "Returns string type for a service object of type '<goal_status-request>"
  "sineva_nav/goal_statusRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal_status-request)))
  "Returns string type for a service object of type 'goal_status-request"
  "sineva_nav/goal_statusRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goal_status-request>)))
  "Returns md5sum for a message object of type '<goal_status-request>"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goal_status-request)))
  "Returns md5sum for a message object of type 'goal_status-request"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goal_status-request>)))
  "Returns full string definition for message of type '<goal_status-request>"
  (cl:format cl:nil "# goal pose~%float32 x~%float32 y~%float32 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goal_status-request)))
  "Returns full string definition for message of type 'goal_status-request"
  (cl:format cl:nil "# goal pose~%float32 x~%float32 y~%float32 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goal_status-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goal_status-request>))
  "Converts a ROS message object to a list"
  (cl:list 'goal_status-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':yaw (yaw msg))
))
;//! \htmlinclude goal_status-response.msg.html

(cl:defclass <goal_status-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goal_status-response (<goal_status-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goal_status-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goal_status-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<goal_status-response> is deprecated: use sineva_nav-srv:goal_status-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <goal_status-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goal_status-response>) ostream)
  "Serializes a message object of type '<goal_status-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goal_status-response>) istream)
  "Deserializes a message object of type '<goal_status-response>"
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goal_status-response>)))
  "Returns string type for a service object of type '<goal_status-response>"
  "sineva_nav/goal_statusResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal_status-response)))
  "Returns string type for a service object of type 'goal_status-response"
  "sineva_nav/goal_statusResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goal_status-response>)))
  "Returns md5sum for a message object of type '<goal_status-response>"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goal_status-response)))
  "Returns md5sum for a message object of type 'goal_status-response"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goal_status-response>)))
  "Returns full string definition for message of type '<goal_status-response>"
  (cl:format cl:nil "# true--occupied  false--free~%bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goal_status-response)))
  "Returns full string definition for message of type 'goal_status-response"
  (cl:format cl:nil "# true--occupied  false--free~%bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goal_status-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goal_status-response>))
  "Converts a ROS message object to a list"
  (cl:list 'goal_status-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'goal_status)))
  'goal_status-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'goal_status)))
  'goal_status-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal_status)))
  "Returns string type for a service object of type '<goal_status>"
  "sineva_nav/goal_status")