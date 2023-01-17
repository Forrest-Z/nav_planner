; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude GetStateSrv-request.msg.html

(cl:defclass <GetStateSrv-request> (roslisp-msg-protocol:ros-message)
  ((state_id
    :reader state_id
    :initarg :state_id
    :type cl:string
    :initform ""))
)

(cl:defclass GetStateSrv-request (<GetStateSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetStateSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetStateSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<GetStateSrv-request> is deprecated: use sineva_nav-srv:GetStateSrv-request instead.")))

(cl:ensure-generic-function 'state_id-val :lambda-list '(m))
(cl:defmethod state_id-val ((m <GetStateSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:state_id-val is deprecated.  Use sineva_nav-srv:state_id instead.")
  (state_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetStateSrv-request>) ostream)
  "Serializes a message object of type '<GetStateSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'state_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'state_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetStateSrv-request>) istream)
  "Deserializes a message object of type '<GetStateSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'state_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetStateSrv-request>)))
  "Returns string type for a service object of type '<GetStateSrv-request>"
  "sineva_nav/GetStateSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetStateSrv-request)))
  "Returns string type for a service object of type 'GetStateSrv-request"
  "sineva_nav/GetStateSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetStateSrv-request>)))
  "Returns md5sum for a message object of type '<GetStateSrv-request>"
  "702496c6638c59bcef5d602cda36b30f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetStateSrv-request)))
  "Returns md5sum for a message object of type 'GetStateSrv-request"
  "702496c6638c59bcef5d602cda36b30f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetStateSrv-request>)))
  "Returns full string definition for message of type '<GetStateSrv-request>"
  (cl:format cl:nil "# request message~%string state_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetStateSrv-request)))
  "Returns full string definition for message of type 'GetStateSrv-request"
  (cl:format cl:nil "# request message~%string state_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetStateSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'state_id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetStateSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetStateSrv-request
    (cl:cons ':state_id (state_id msg))
))
;//! \htmlinclude GetStateSrv-response.msg.html

(cl:defclass <GetStateSrv-response> (roslisp-msg-protocol:ros-message)
  ((goal_id
    :reader goal_id
    :initarg :goal_id
    :type cl:string
    :initform "")
   (status_code
    :reader status_code
    :initarg :status_code
    :type cl:integer
    :initform 0))
)

(cl:defclass GetStateSrv-response (<GetStateSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetStateSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetStateSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<GetStateSrv-response> is deprecated: use sineva_nav-srv:GetStateSrv-response instead.")))

(cl:ensure-generic-function 'goal_id-val :lambda-list '(m))
(cl:defmethod goal_id-val ((m <GetStateSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:goal_id-val is deprecated.  Use sineva_nav-srv:goal_id instead.")
  (goal_id m))

(cl:ensure-generic-function 'status_code-val :lambda-list '(m))
(cl:defmethod status_code-val ((m <GetStateSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:status_code-val is deprecated.  Use sineva_nav-srv:status_code instead.")
  (status_code m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetStateSrv-response>) ostream)
  "Serializes a message object of type '<GetStateSrv-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'goal_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'goal_id))
  (cl:let* ((signed (cl:slot-value msg 'status_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetStateSrv-response>) istream)
  "Deserializes a message object of type '<GetStateSrv-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'goal_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'goal_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status_code) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetStateSrv-response>)))
  "Returns string type for a service object of type '<GetStateSrv-response>"
  "sineva_nav/GetStateSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetStateSrv-response)))
  "Returns string type for a service object of type 'GetStateSrv-response"
  "sineva_nav/GetStateSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetStateSrv-response>)))
  "Returns md5sum for a message object of type '<GetStateSrv-response>"
  "702496c6638c59bcef5d602cda36b30f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetStateSrv-response)))
  "Returns md5sum for a message object of type 'GetStateSrv-response"
  "702496c6638c59bcef5d602cda36b30f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetStateSrv-response>)))
  "Returns full string definition for message of type '<GetStateSrv-response>"
  (cl:format cl:nil "# response message~%string goal_id~%int32 status_code~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetStateSrv-response)))
  "Returns full string definition for message of type 'GetStateSrv-response"
  (cl:format cl:nil "# response message~%string goal_id~%int32 status_code~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetStateSrv-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'goal_id))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetStateSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetStateSrv-response
    (cl:cons ':goal_id (goal_id msg))
    (cl:cons ':status_code (status_code msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetStateSrv)))
  'GetStateSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetStateSrv)))
  'GetStateSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetStateSrv)))
  "Returns string type for a service object of type '<GetStateSrv>"
  "sineva_nav/GetStateSrv")