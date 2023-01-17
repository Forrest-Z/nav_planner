; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude JsonSrv-request.msg.html

(cl:defclass <JsonSrv-request> (roslisp-msg-protocol:ros-message)
  ((flag
    :reader flag
    :initarg :flag
    :type cl:string
    :initform "")
   (dataReq
    :reader dataReq
    :initarg :dataReq
    :type cl:string
    :initform ""))
)

(cl:defclass JsonSrv-request (<JsonSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JsonSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JsonSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<JsonSrv-request> is deprecated: use sineva_nav-srv:JsonSrv-request instead.")))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <JsonSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:flag-val is deprecated.  Use sineva_nav-srv:flag instead.")
  (flag m))

(cl:ensure-generic-function 'dataReq-val :lambda-list '(m))
(cl:defmethod dataReq-val ((m <JsonSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:dataReq-val is deprecated.  Use sineva_nav-srv:dataReq instead.")
  (dataReq m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JsonSrv-request>) ostream)
  "Serializes a message object of type '<JsonSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'flag))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'flag))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'dataReq))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'dataReq))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JsonSrv-request>) istream)
  "Deserializes a message object of type '<JsonSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'flag) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'flag) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dataReq) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'dataReq) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JsonSrv-request>)))
  "Returns string type for a service object of type '<JsonSrv-request>"
  "sineva_nav/JsonSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonSrv-request)))
  "Returns string type for a service object of type 'JsonSrv-request"
  "sineva_nav/JsonSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JsonSrv-request>)))
  "Returns md5sum for a message object of type '<JsonSrv-request>"
  "d8d0627554acfa5cf898bc2c61190e8e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JsonSrv-request)))
  "Returns md5sum for a message object of type 'JsonSrv-request"
  "d8d0627554acfa5cf898bc2c61190e8e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JsonSrv-request>)))
  "Returns full string definition for message of type '<JsonSrv-request>"
  (cl:format cl:nil "# request message~%string flag~%string dataReq~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JsonSrv-request)))
  "Returns full string definition for message of type 'JsonSrv-request"
  (cl:format cl:nil "# request message~%string flag~%string dataReq~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JsonSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'flag))
     4 (cl:length (cl:slot-value msg 'dataReq))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JsonSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'JsonSrv-request
    (cl:cons ':flag (flag msg))
    (cl:cons ':dataReq (dataReq msg))
))
;//! \htmlinclude JsonSrv-response.msg.html

(cl:defclass <JsonSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0)
   (dataRes
    :reader dataRes
    :initarg :dataRes
    :type cl:string
    :initform ""))
)

(cl:defclass JsonSrv-response (<JsonSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JsonSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JsonSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<JsonSrv-response> is deprecated: use sineva_nav-srv:JsonSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <JsonSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))

(cl:ensure-generic-function 'dataRes-val :lambda-list '(m))
(cl:defmethod dataRes-val ((m <JsonSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:dataRes-val is deprecated.  Use sineva_nav-srv:dataRes instead.")
  (dataRes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JsonSrv-response>) ostream)
  "Serializes a message object of type '<JsonSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'dataRes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'dataRes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JsonSrv-response>) istream)
  "Deserializes a message object of type '<JsonSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dataRes) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'dataRes) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JsonSrv-response>)))
  "Returns string type for a service object of type '<JsonSrv-response>"
  "sineva_nav/JsonSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonSrv-response)))
  "Returns string type for a service object of type 'JsonSrv-response"
  "sineva_nav/JsonSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JsonSrv-response>)))
  "Returns md5sum for a message object of type '<JsonSrv-response>"
  "d8d0627554acfa5cf898bc2c61190e8e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JsonSrv-response)))
  "Returns md5sum for a message object of type 'JsonSrv-response"
  "d8d0627554acfa5cf898bc2c61190e8e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JsonSrv-response>)))
  "Returns full string definition for message of type '<JsonSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%string dataRes~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JsonSrv-response)))
  "Returns full string definition for message of type 'JsonSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%string dataRes~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JsonSrv-response>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'dataRes))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JsonSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'JsonSrv-response
    (cl:cons ':result (result msg))
    (cl:cons ':dataRes (dataRes msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'JsonSrv)))
  'JsonSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'JsonSrv)))
  'JsonSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JsonSrv)))
  "Returns string type for a service object of type '<JsonSrv>"
  "sineva_nav/JsonSrv")