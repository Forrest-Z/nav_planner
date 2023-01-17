; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude EnableSrv-request.msg.html

(cl:defclass <EnableSrv-request> (roslisp-msg-protocol:ros-message)
  ((enable
    :reader enable
    :initarg :enable
    :type cl:integer
    :initform 0))
)

(cl:defclass EnableSrv-request (<EnableSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EnableSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EnableSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<EnableSrv-request> is deprecated: use sineva_nav-srv:EnableSrv-request instead.")))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <EnableSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:enable-val is deprecated.  Use sineva_nav-srv:enable instead.")
  (enable m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EnableSrv-request>) ostream)
  "Serializes a message object of type '<EnableSrv-request>"
  (cl:let* ((signed (cl:slot-value msg 'enable)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EnableSrv-request>) istream)
  "Deserializes a message object of type '<EnableSrv-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'enable) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EnableSrv-request>)))
  "Returns string type for a service object of type '<EnableSrv-request>"
  "sineva_nav/EnableSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EnableSrv-request)))
  "Returns string type for a service object of type 'EnableSrv-request"
  "sineva_nav/EnableSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EnableSrv-request>)))
  "Returns md5sum for a message object of type '<EnableSrv-request>"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EnableSrv-request)))
  "Returns md5sum for a message object of type 'EnableSrv-request"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EnableSrv-request>)))
  "Returns full string definition for message of type '<EnableSrv-request>"
  (cl:format cl:nil "# request message~%int32 enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EnableSrv-request)))
  "Returns full string definition for message of type 'EnableSrv-request"
  (cl:format cl:nil "# request message~%int32 enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EnableSrv-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EnableSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'EnableSrv-request
    (cl:cons ':enable (enable msg))
))
;//! \htmlinclude EnableSrv-response.msg.html

(cl:defclass <EnableSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass EnableSrv-response (<EnableSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EnableSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EnableSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<EnableSrv-response> is deprecated: use sineva_nav-srv:EnableSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <EnableSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EnableSrv-response>) ostream)
  "Serializes a message object of type '<EnableSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EnableSrv-response>) istream)
  "Deserializes a message object of type '<EnableSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EnableSrv-response>)))
  "Returns string type for a service object of type '<EnableSrv-response>"
  "sineva_nav/EnableSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EnableSrv-response)))
  "Returns string type for a service object of type 'EnableSrv-response"
  "sineva_nav/EnableSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EnableSrv-response>)))
  "Returns md5sum for a message object of type '<EnableSrv-response>"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EnableSrv-response)))
  "Returns md5sum for a message object of type 'EnableSrv-response"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EnableSrv-response>)))
  "Returns full string definition for message of type '<EnableSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EnableSrv-response)))
  "Returns full string definition for message of type 'EnableSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EnableSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EnableSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'EnableSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'EnableSrv)))
  'EnableSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'EnableSrv)))
  'EnableSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EnableSrv)))
  "Returns string type for a service object of type '<EnableSrv>"
  "sineva_nav/EnableSrv")