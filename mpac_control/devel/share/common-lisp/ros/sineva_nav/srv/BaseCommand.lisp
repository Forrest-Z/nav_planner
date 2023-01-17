; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude BaseCommand-request.msg.html

(cl:defclass <BaseCommand-request> (roslisp-msg-protocol:ros-message)
  ((cmd
    :reader cmd
    :initarg :cmd
    :type cl:fixnum
    :initform 0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass BaseCommand-request (<BaseCommand-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BaseCommand-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BaseCommand-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<BaseCommand-request> is deprecated: use sineva_nav-srv:BaseCommand-request instead.")))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <BaseCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:cmd-val is deprecated.  Use sineva_nav-srv:cmd instead.")
  (cmd m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <BaseCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:data-val is deprecated.  Use sineva_nav-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BaseCommand-request>) ostream)
  "Serializes a message object of type '<BaseCommand-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BaseCommand-request>) istream)
  "Deserializes a message object of type '<BaseCommand-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BaseCommand-request>)))
  "Returns string type for a service object of type '<BaseCommand-request>"
  "sineva_nav/BaseCommandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BaseCommand-request)))
  "Returns string type for a service object of type 'BaseCommand-request"
  "sineva_nav/BaseCommandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BaseCommand-request>)))
  "Returns md5sum for a message object of type '<BaseCommand-request>"
  "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BaseCommand-request)))
  "Returns md5sum for a message object of type 'BaseCommand-request"
  "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BaseCommand-request>)))
  "Returns full string definition for message of type '<BaseCommand-request>"
  (cl:format cl:nil "uint8 cmd~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BaseCommand-request)))
  "Returns full string definition for message of type 'BaseCommand-request"
  (cl:format cl:nil "uint8 cmd~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BaseCommand-request>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BaseCommand-request>))
  "Converts a ROS message object to a list"
  (cl:list 'BaseCommand-request
    (cl:cons ':cmd (cmd msg))
    (cl:cons ':data (data msg))
))
;//! \htmlinclude BaseCommand-response.msg.html

(cl:defclass <BaseCommand-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass BaseCommand-response (<BaseCommand-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BaseCommand-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BaseCommand-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<BaseCommand-response> is deprecated: use sineva_nav-srv:BaseCommand-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <BaseCommand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BaseCommand-response>) ostream)
  "Serializes a message object of type '<BaseCommand-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BaseCommand-response>) istream)
  "Deserializes a message object of type '<BaseCommand-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BaseCommand-response>)))
  "Returns string type for a service object of type '<BaseCommand-response>"
  "sineva_nav/BaseCommandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BaseCommand-response)))
  "Returns string type for a service object of type 'BaseCommand-response"
  "sineva_nav/BaseCommandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BaseCommand-response>)))
  "Returns md5sum for a message object of type '<BaseCommand-response>"
  "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BaseCommand-response)))
  "Returns md5sum for a message object of type 'BaseCommand-response"
  "f6f2dc9a7416a2a175dbf05bca3c4fdb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BaseCommand-response>)))
  "Returns full string definition for message of type '<BaseCommand-response>"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BaseCommand-response)))
  "Returns full string definition for message of type 'BaseCommand-response"
  (cl:format cl:nil "int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BaseCommand-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BaseCommand-response>))
  "Converts a ROS message object to a list"
  (cl:list 'BaseCommand-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'BaseCommand)))
  'BaseCommand-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'BaseCommand)))
  'BaseCommand-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BaseCommand)))
  "Returns string type for a service object of type '<BaseCommand>"
  "sineva_nav/BaseCommand")