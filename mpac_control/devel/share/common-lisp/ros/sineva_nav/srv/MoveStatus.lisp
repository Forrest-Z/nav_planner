; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude MoveStatus-request.msg.html

(cl:defclass <MoveStatus-request> (roslisp-msg-protocol:ros-message)
  ((moveStatus
    :reader moveStatus
    :initarg :moveStatus
    :type cl:integer
    :initform 0)
   (info
    :reader info
    :initarg :info
    :type cl:string
    :initform ""))
)

(cl:defclass MoveStatus-request (<MoveStatus-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveStatus-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveStatus-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<MoveStatus-request> is deprecated: use sineva_nav-srv:MoveStatus-request instead.")))

(cl:ensure-generic-function 'moveStatus-val :lambda-list '(m))
(cl:defmethod moveStatus-val ((m <MoveStatus-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:moveStatus-val is deprecated.  Use sineva_nav-srv:moveStatus instead.")
  (moveStatus m))

(cl:ensure-generic-function 'info-val :lambda-list '(m))
(cl:defmethod info-val ((m <MoveStatus-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:info-val is deprecated.  Use sineva_nav-srv:info instead.")
  (info m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveStatus-request>) ostream)
  "Serializes a message object of type '<MoveStatus-request>"
  (cl:let* ((signed (cl:slot-value msg 'moveStatus)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'info))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'info))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveStatus-request>) istream)
  "Deserializes a message object of type '<MoveStatus-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'moveStatus) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'info) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'info) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveStatus-request>)))
  "Returns string type for a service object of type '<MoveStatus-request>"
  "sineva_nav/MoveStatusRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveStatus-request)))
  "Returns string type for a service object of type 'MoveStatus-request"
  "sineva_nav/MoveStatusRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveStatus-request>)))
  "Returns md5sum for a message object of type '<MoveStatus-request>"
  "f6729728149600a4ea80caa7ab1e5015")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveStatus-request)))
  "Returns md5sum for a message object of type 'MoveStatus-request"
  "f6729728149600a4ea80caa7ab1e5015")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveStatus-request>)))
  "Returns full string definition for message of type '<MoveStatus-request>"
  (cl:format cl:nil "# request message~%int32 moveStatus~%string info~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveStatus-request)))
  "Returns full string definition for message of type 'MoveStatus-request"
  (cl:format cl:nil "# request message~%int32 moveStatus~%string info~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveStatus-request>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'info))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveStatus-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveStatus-request
    (cl:cons ':moveStatus (moveStatus msg))
    (cl:cons ':info (info msg))
))
;//! \htmlinclude MoveStatus-response.msg.html

(cl:defclass <MoveStatus-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0))
)

(cl:defclass MoveStatus-response (<MoveStatus-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveStatus-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveStatus-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<MoveStatus-response> is deprecated: use sineva_nav-srv:MoveStatus-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <MoveStatus-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveStatus-response>) ostream)
  "Serializes a message object of type '<MoveStatus-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveStatus-response>) istream)
  "Deserializes a message object of type '<MoveStatus-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveStatus-response>)))
  "Returns string type for a service object of type '<MoveStatus-response>"
  "sineva_nav/MoveStatusResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveStatus-response)))
  "Returns string type for a service object of type 'MoveStatus-response"
  "sineva_nav/MoveStatusResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveStatus-response>)))
  "Returns md5sum for a message object of type '<MoveStatus-response>"
  "f6729728149600a4ea80caa7ab1e5015")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveStatus-response)))
  "Returns md5sum for a message object of type 'MoveStatus-response"
  "f6729728149600a4ea80caa7ab1e5015")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveStatus-response>)))
  "Returns full string definition for message of type '<MoveStatus-response>"
  (cl:format cl:nil "# response message~%int8 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveStatus-response)))
  "Returns full string definition for message of type 'MoveStatus-response"
  (cl:format cl:nil "# response message~%int8 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveStatus-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveStatus-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveStatus-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MoveStatus)))
  'MoveStatus-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MoveStatus)))
  'MoveStatus-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveStatus)))
  "Returns string type for a service object of type '<MoveStatus>"
  "sineva_nav/MoveStatus")