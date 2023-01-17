; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude StringCommSrv-request.msg.html

(cl:defclass <StringCommSrv-request> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type cl:string
    :initform ""))
)

(cl:defclass StringCommSrv-request (<StringCommSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StringCommSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StringCommSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<StringCommSrv-request> is deprecated: use sineva_nav-srv:StringCommSrv-request instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <StringCommSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:data-val is deprecated.  Use sineva_nav-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StringCommSrv-request>) ostream)
  "Serializes a message object of type '<StringCommSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StringCommSrv-request>) istream)
  "Deserializes a message object of type '<StringCommSrv-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StringCommSrv-request>)))
  "Returns string type for a service object of type '<StringCommSrv-request>"
  "sineva_nav/StringCommSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StringCommSrv-request)))
  "Returns string type for a service object of type 'StringCommSrv-request"
  "sineva_nav/StringCommSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StringCommSrv-request>)))
  "Returns md5sum for a message object of type '<StringCommSrv-request>"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StringCommSrv-request)))
  "Returns md5sum for a message object of type 'StringCommSrv-request"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StringCommSrv-request>)))
  "Returns full string definition for message of type '<StringCommSrv-request>"
  (cl:format cl:nil "string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StringCommSrv-request)))
  "Returns full string definition for message of type 'StringCommSrv-request"
  (cl:format cl:nil "string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StringCommSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'data))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StringCommSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StringCommSrv-request
    (cl:cons ':data (data msg))
))
;//! \htmlinclude StringCommSrv-response.msg.html

(cl:defclass <StringCommSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass StringCommSrv-response (<StringCommSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StringCommSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StringCommSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<StringCommSrv-response> is deprecated: use sineva_nav-srv:StringCommSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <StringCommSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StringCommSrv-response>) ostream)
  "Serializes a message object of type '<StringCommSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StringCommSrv-response>) istream)
  "Deserializes a message object of type '<StringCommSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StringCommSrv-response>)))
  "Returns string type for a service object of type '<StringCommSrv-response>"
  "sineva_nav/StringCommSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StringCommSrv-response)))
  "Returns string type for a service object of type 'StringCommSrv-response"
  "sineva_nav/StringCommSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StringCommSrv-response>)))
  "Returns md5sum for a message object of type '<StringCommSrv-response>"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StringCommSrv-response)))
  "Returns md5sum for a message object of type 'StringCommSrv-response"
  "ca17d783c86e928bc4beab3674acd9b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StringCommSrv-response>)))
  "Returns full string definition for message of type '<StringCommSrv-response>"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StringCommSrv-response)))
  "Returns full string definition for message of type 'StringCommSrv-response"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StringCommSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StringCommSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StringCommSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StringCommSrv)))
  'StringCommSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StringCommSrv)))
  'StringCommSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StringCommSrv)))
  "Returns string type for a service object of type '<StringCommSrv>"
  "sineva_nav/StringCommSrv")