; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude JsonCommSrv-request.msg.html

(cl:defclass <JsonCommSrv-request> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type cl:string
    :initform ""))
)

(cl:defclass JsonCommSrv-request (<JsonCommSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JsonCommSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JsonCommSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<JsonCommSrv-request> is deprecated: use sineva_nav-srv:JsonCommSrv-request instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <JsonCommSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:data-val is deprecated.  Use sineva_nav-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JsonCommSrv-request>) ostream)
  "Serializes a message object of type '<JsonCommSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JsonCommSrv-request>) istream)
  "Deserializes a message object of type '<JsonCommSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'data) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'data) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JsonCommSrv-request>)))
  "Returns string type for a service object of type '<JsonCommSrv-request>"
  "sineva_nav/JsonCommSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonCommSrv-request)))
  "Returns string type for a service object of type 'JsonCommSrv-request"
  "sineva_nav/JsonCommSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JsonCommSrv-request>)))
  "Returns md5sum for a message object of type '<JsonCommSrv-request>"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JsonCommSrv-request)))
  "Returns md5sum for a message object of type 'JsonCommSrv-request"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JsonCommSrv-request>)))
  "Returns full string definition for message of type '<JsonCommSrv-request>"
  (cl:format cl:nil "string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JsonCommSrv-request)))
  "Returns full string definition for message of type 'JsonCommSrv-request"
  (cl:format cl:nil "string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JsonCommSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'data))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JsonCommSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'JsonCommSrv-request
    (cl:cons ':data (data msg))
))
;//! \htmlinclude JsonCommSrv-response.msg.html

(cl:defclass <JsonCommSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass JsonCommSrv-response (<JsonCommSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JsonCommSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JsonCommSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<JsonCommSrv-response> is deprecated: use sineva_nav-srv:JsonCommSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <JsonCommSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JsonCommSrv-response>) ostream)
  "Serializes a message object of type '<JsonCommSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JsonCommSrv-response>) istream)
  "Deserializes a message object of type '<JsonCommSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JsonCommSrv-response>)))
  "Returns string type for a service object of type '<JsonCommSrv-response>"
  "sineva_nav/JsonCommSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonCommSrv-response)))
  "Returns string type for a service object of type 'JsonCommSrv-response"
  "sineva_nav/JsonCommSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JsonCommSrv-response>)))
  "Returns md5sum for a message object of type '<JsonCommSrv-response>"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JsonCommSrv-response)))
  "Returns md5sum for a message object of type 'JsonCommSrv-response"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JsonCommSrv-response>)))
  "Returns full string definition for message of type '<JsonCommSrv-response>"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JsonCommSrv-response)))
  "Returns full string definition for message of type 'JsonCommSrv-response"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JsonCommSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JsonCommSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'JsonCommSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'JsonCommSrv)))
  'JsonCommSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'JsonCommSrv)))
  'JsonCommSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonCommSrv)))
  "Returns string type for a service object of type '<JsonCommSrv>"
  "sineva_nav/JsonCommSrv")