; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude CheckGoalStatusSrv-request.msg.html

(cl:defclass <CheckGoalStatusSrv-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass CheckGoalStatusSrv-request (<CheckGoalStatusSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CheckGoalStatusSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CheckGoalStatusSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CheckGoalStatusSrv-request> is deprecated: use sineva_nav-srv:CheckGoalStatusSrv-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <CheckGoalStatusSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:x-val is deprecated.  Use sineva_nav-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <CheckGoalStatusSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:y-val is deprecated.  Use sineva_nav-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <CheckGoalStatusSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:yaw-val is deprecated.  Use sineva_nav-srv:yaw instead.")
  (yaw m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CheckGoalStatusSrv-request>) ostream)
  "Serializes a message object of type '<CheckGoalStatusSrv-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CheckGoalStatusSrv-request>) istream)
  "Deserializes a message object of type '<CheckGoalStatusSrv-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CheckGoalStatusSrv-request>)))
  "Returns string type for a service object of type '<CheckGoalStatusSrv-request>"
  "sineva_nav/CheckGoalStatusSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CheckGoalStatusSrv-request)))
  "Returns string type for a service object of type 'CheckGoalStatusSrv-request"
  "sineva_nav/CheckGoalStatusSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CheckGoalStatusSrv-request>)))
  "Returns md5sum for a message object of type '<CheckGoalStatusSrv-request>"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CheckGoalStatusSrv-request)))
  "Returns md5sum for a message object of type 'CheckGoalStatusSrv-request"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CheckGoalStatusSrv-request>)))
  "Returns full string definition for message of type '<CheckGoalStatusSrv-request>"
  (cl:format cl:nil "# goal pose~%float32 x~%float32 y~%float32 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CheckGoalStatusSrv-request)))
  "Returns full string definition for message of type 'CheckGoalStatusSrv-request"
  (cl:format cl:nil "# goal pose~%float32 x~%float32 y~%float32 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CheckGoalStatusSrv-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CheckGoalStatusSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CheckGoalStatusSrv-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':yaw (yaw msg))
))
;//! \htmlinclude CheckGoalStatusSrv-response.msg.html

(cl:defclass <CheckGoalStatusSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CheckGoalStatusSrv-response (<CheckGoalStatusSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CheckGoalStatusSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CheckGoalStatusSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CheckGoalStatusSrv-response> is deprecated: use sineva_nav-srv:CheckGoalStatusSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <CheckGoalStatusSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CheckGoalStatusSrv-response>) ostream)
  "Serializes a message object of type '<CheckGoalStatusSrv-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CheckGoalStatusSrv-response>) istream)
  "Deserializes a message object of type '<CheckGoalStatusSrv-response>"
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CheckGoalStatusSrv-response>)))
  "Returns string type for a service object of type '<CheckGoalStatusSrv-response>"
  "sineva_nav/CheckGoalStatusSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CheckGoalStatusSrv-response)))
  "Returns string type for a service object of type 'CheckGoalStatusSrv-response"
  "sineva_nav/CheckGoalStatusSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CheckGoalStatusSrv-response>)))
  "Returns md5sum for a message object of type '<CheckGoalStatusSrv-response>"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CheckGoalStatusSrv-response)))
  "Returns md5sum for a message object of type 'CheckGoalStatusSrv-response"
  "3d638b2cdc898e8eb5d6b3cfc2f2c14b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CheckGoalStatusSrv-response>)))
  "Returns full string definition for message of type '<CheckGoalStatusSrv-response>"
  (cl:format cl:nil "# true--occupied  false--free~%bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CheckGoalStatusSrv-response)))
  "Returns full string definition for message of type 'CheckGoalStatusSrv-response"
  (cl:format cl:nil "# true--occupied  false--free~%bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CheckGoalStatusSrv-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CheckGoalStatusSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CheckGoalStatusSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CheckGoalStatusSrv)))
  'CheckGoalStatusSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CheckGoalStatusSrv)))
  'CheckGoalStatusSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CheckGoalStatusSrv)))
  "Returns string type for a service object of type '<CheckGoalStatusSrv>"
  "sineva_nav/CheckGoalStatusSrv")