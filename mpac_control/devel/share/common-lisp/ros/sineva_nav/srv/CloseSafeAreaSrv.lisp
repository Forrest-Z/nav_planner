; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude CloseSafeAreaSrv-request.msg.html

(cl:defclass <CloseSafeAreaSrv-request> (roslisp-msg-protocol:ros-message)
  ((enable
    :reader enable
    :initarg :enable
    :type cl:integer
    :initform 0))
)

(cl:defclass CloseSafeAreaSrv-request (<CloseSafeAreaSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CloseSafeAreaSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CloseSafeAreaSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CloseSafeAreaSrv-request> is deprecated: use sineva_nav-srv:CloseSafeAreaSrv-request instead.")))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <CloseSafeAreaSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:enable-val is deprecated.  Use sineva_nav-srv:enable instead.")
  (enable m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CloseSafeAreaSrv-request>) ostream)
  "Serializes a message object of type '<CloseSafeAreaSrv-request>"
  (cl:let* ((signed (cl:slot-value msg 'enable)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CloseSafeAreaSrv-request>) istream)
  "Deserializes a message object of type '<CloseSafeAreaSrv-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'enable) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CloseSafeAreaSrv-request>)))
  "Returns string type for a service object of type '<CloseSafeAreaSrv-request>"
  "sineva_nav/CloseSafeAreaSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CloseSafeAreaSrv-request)))
  "Returns string type for a service object of type 'CloseSafeAreaSrv-request"
  "sineva_nav/CloseSafeAreaSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CloseSafeAreaSrv-request>)))
  "Returns md5sum for a message object of type '<CloseSafeAreaSrv-request>"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CloseSafeAreaSrv-request)))
  "Returns md5sum for a message object of type 'CloseSafeAreaSrv-request"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CloseSafeAreaSrv-request>)))
  "Returns full string definition for message of type '<CloseSafeAreaSrv-request>"
  (cl:format cl:nil "# request message~%int32 enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CloseSafeAreaSrv-request)))
  "Returns full string definition for message of type 'CloseSafeAreaSrv-request"
  (cl:format cl:nil "# request message~%int32 enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CloseSafeAreaSrv-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CloseSafeAreaSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CloseSafeAreaSrv-request
    (cl:cons ':enable (enable msg))
))
;//! \htmlinclude CloseSafeAreaSrv-response.msg.html

(cl:defclass <CloseSafeAreaSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass CloseSafeAreaSrv-response (<CloseSafeAreaSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CloseSafeAreaSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CloseSafeAreaSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<CloseSafeAreaSrv-response> is deprecated: use sineva_nav-srv:CloseSafeAreaSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <CloseSafeAreaSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CloseSafeAreaSrv-response>) ostream)
  "Serializes a message object of type '<CloseSafeAreaSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CloseSafeAreaSrv-response>) istream)
  "Deserializes a message object of type '<CloseSafeAreaSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CloseSafeAreaSrv-response>)))
  "Returns string type for a service object of type '<CloseSafeAreaSrv-response>"
  "sineva_nav/CloseSafeAreaSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CloseSafeAreaSrv-response)))
  "Returns string type for a service object of type 'CloseSafeAreaSrv-response"
  "sineva_nav/CloseSafeAreaSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CloseSafeAreaSrv-response>)))
  "Returns md5sum for a message object of type '<CloseSafeAreaSrv-response>"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CloseSafeAreaSrv-response)))
  "Returns md5sum for a message object of type 'CloseSafeAreaSrv-response"
  "453c8349175735b023f9d38fc609cbe6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CloseSafeAreaSrv-response>)))
  "Returns full string definition for message of type '<CloseSafeAreaSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CloseSafeAreaSrv-response)))
  "Returns full string definition for message of type 'CloseSafeAreaSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CloseSafeAreaSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CloseSafeAreaSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CloseSafeAreaSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CloseSafeAreaSrv)))
  'CloseSafeAreaSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CloseSafeAreaSrv)))
  'CloseSafeAreaSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CloseSafeAreaSrv)))
  "Returns string type for a service object of type '<CloseSafeAreaSrv>"
  "sineva_nav/CloseSafeAreaSrv")