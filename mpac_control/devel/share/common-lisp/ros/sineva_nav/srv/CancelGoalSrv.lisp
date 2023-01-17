; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude CancelGoalSrv-request.msg.html

(cl:defclass <CancelGoalSrv-request> (roslisp-msg-protocol:ros-message)
  ((goal_id
    :reader goal_id
    :initarg :goal_id
    :type cl:string
    :initform ""))
)

(cl:defclass CancelGoalSrv-request (<CancelGoalSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CancelGoalSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CancelGoalSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CancelGoalSrv-request> is deprecated: use sineva_nav-srv:CancelGoalSrv-request instead.")))

(cl:ensure-generic-function 'goal_id-val :lambda-list '(m))
(cl:defmethod goal_id-val ((m <CancelGoalSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:goal_id-val is deprecated.  Use sineva_nav-srv:goal_id instead.")
  (goal_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CancelGoalSrv-request>) ostream)
  "Serializes a message object of type '<CancelGoalSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'goal_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'goal_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CancelGoalSrv-request>) istream)
  "Deserializes a message object of type '<CancelGoalSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'goal_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'goal_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CancelGoalSrv-request>)))
  "Returns string type for a service object of type '<CancelGoalSrv-request>"
  "sineva_nav/CancelGoalSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoalSrv-request)))
  "Returns string type for a service object of type 'CancelGoalSrv-request"
  "sineva_nav/CancelGoalSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CancelGoalSrv-request>)))
  "Returns md5sum for a message object of type '<CancelGoalSrv-request>"
  "69b4ce7997dd89357a2ebdc1827d4b0d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CancelGoalSrv-request)))
  "Returns md5sum for a message object of type 'CancelGoalSrv-request"
  "69b4ce7997dd89357a2ebdc1827d4b0d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CancelGoalSrv-request>)))
  "Returns full string definition for message of type '<CancelGoalSrv-request>"
  (cl:format cl:nil "# request message~%string goal_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CancelGoalSrv-request)))
  "Returns full string definition for message of type 'CancelGoalSrv-request"
  (cl:format cl:nil "# request message~%string goal_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CancelGoalSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'goal_id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CancelGoalSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CancelGoalSrv-request
    (cl:cons ':goal_id (goal_id msg))
))
;//! \htmlinclude CancelGoalSrv-response.msg.html

(cl:defclass <CancelGoalSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass CancelGoalSrv-response (<CancelGoalSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CancelGoalSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CancelGoalSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CancelGoalSrv-response> is deprecated: use sineva_nav-srv:CancelGoalSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <CancelGoalSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CancelGoalSrv-response>) ostream)
  "Serializes a message object of type '<CancelGoalSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CancelGoalSrv-response>) istream)
  "Deserializes a message object of type '<CancelGoalSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CancelGoalSrv-response>)))
  "Returns string type for a service object of type '<CancelGoalSrv-response>"
  "sineva_nav/CancelGoalSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoalSrv-response)))
  "Returns string type for a service object of type 'CancelGoalSrv-response"
  "sineva_nav/CancelGoalSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CancelGoalSrv-response>)))
  "Returns md5sum for a message object of type '<CancelGoalSrv-response>"
  "69b4ce7997dd89357a2ebdc1827d4b0d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CancelGoalSrv-response)))
  "Returns md5sum for a message object of type 'CancelGoalSrv-response"
  "69b4ce7997dd89357a2ebdc1827d4b0d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CancelGoalSrv-response>)))
  "Returns full string definition for message of type '<CancelGoalSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CancelGoalSrv-response)))
  "Returns full string definition for message of type 'CancelGoalSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CancelGoalSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CancelGoalSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CancelGoalSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CancelGoalSrv)))
  'CancelGoalSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CancelGoalSrv)))
  'CancelGoalSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoalSrv)))
  "Returns string type for a service object of type '<CancelGoalSrv>"
  "sineva_nav/CancelGoalSrv")