; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude manage_charge-request.msg.html

(cl:defclass <manage_charge-request> (roslisp-msg-protocol:ros-message)
  ((flag
    :reader flag
    :initarg :flag
    :type cl:string
    :initform "")
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (r
    :reader r
    :initarg :r
    :type cl:float
    :initform 0.0)
   (dx
    :reader dx
    :initarg :dx
    :type cl:float
    :initform 0.0)
   (dy
    :reader dy
    :initarg :dy
    :type cl:float
    :initform 0.0)
   (dr
    :reader dr
    :initarg :dr
    :type cl:float
    :initform 0.0))
)

(cl:defclass manage_charge-request (<manage_charge-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <manage_charge-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'manage_charge-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<manage_charge-request> is deprecated: use sineva_nav-srv:manage_charge-request instead.")))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:flag-val is deprecated.  Use sineva_nav-srv:flag instead.")
  (flag m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:x-val is deprecated.  Use sineva_nav-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:y-val is deprecated.  Use sineva_nav-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'r-val :lambda-list '(m))
(cl:defmethod r-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:r-val is deprecated.  Use sineva_nav-srv:r instead.")
  (r m))

(cl:ensure-generic-function 'dx-val :lambda-list '(m))
(cl:defmethod dx-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:dx-val is deprecated.  Use sineva_nav-srv:dx instead.")
  (dx m))

(cl:ensure-generic-function 'dy-val :lambda-list '(m))
(cl:defmethod dy-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:dy-val is deprecated.  Use sineva_nav-srv:dy instead.")
  (dy m))

(cl:ensure-generic-function 'dr-val :lambda-list '(m))
(cl:defmethod dr-val ((m <manage_charge-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:dr-val is deprecated.  Use sineva_nav-srv:dr instead.")
  (dr m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <manage_charge-request>) ostream)
  "Serializes a message object of type '<manage_charge-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'flag))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'flag))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dr))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <manage_charge-request>) istream)
  "Deserializes a message object of type '<manage_charge-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'flag) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'flag) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
    (cl:setf (cl:slot-value msg 'r) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dx) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dr) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<manage_charge-request>)))
  "Returns string type for a service object of type '<manage_charge-request>"
  "sineva_nav/manage_chargeRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_charge-request)))
  "Returns string type for a service object of type 'manage_charge-request"
  "sineva_nav/manage_chargeRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<manage_charge-request>)))
  "Returns md5sum for a message object of type '<manage_charge-request>"
  "a5c10a0299cfe8117c94010efa5c0025")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'manage_charge-request)))
  "Returns md5sum for a message object of type 'manage_charge-request"
  "a5c10a0299cfe8117c94010efa5c0025")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<manage_charge-request>)))
  "Returns full string definition for message of type '<manage_charge-request>"
  (cl:format cl:nil "string flag~%# dist point~%float32 x~%float32 y~%float32 r~%# deviation point~%float32 dx~%float32 dy~%float32 dr~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'manage_charge-request)))
  "Returns full string definition for message of type 'manage_charge-request"
  (cl:format cl:nil "string flag~%# dist point~%float32 x~%float32 y~%float32 r~%# deviation point~%float32 dx~%float32 dy~%float32 dr~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <manage_charge-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'flag))
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <manage_charge-request>))
  "Converts a ROS message object to a list"
  (cl:list 'manage_charge-request
    (cl:cons ':flag (flag msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':r (r msg))
    (cl:cons ':dx (dx msg))
    (cl:cons ':dy (dy msg))
    (cl:cons ':dr (dr msg))
))
;//! \htmlinclude manage_charge-response.msg.html

(cl:defclass <manage_charge-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0))
)

(cl:defclass manage_charge-response (<manage_charge-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <manage_charge-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'manage_charge-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<manage_charge-response> is deprecated: use sineva_nav-srv:manage_charge-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <manage_charge-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <manage_charge-response>) ostream)
  "Serializes a message object of type '<manage_charge-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <manage_charge-response>) istream)
  "Deserializes a message object of type '<manage_charge-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<manage_charge-response>)))
  "Returns string type for a service object of type '<manage_charge-response>"
  "sineva_nav/manage_chargeResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_charge-response)))
  "Returns string type for a service object of type 'manage_charge-response"
  "sineva_nav/manage_chargeResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<manage_charge-response>)))
  "Returns md5sum for a message object of type '<manage_charge-response>"
  "a5c10a0299cfe8117c94010efa5c0025")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'manage_charge-response)))
  "Returns md5sum for a message object of type 'manage_charge-response"
  "a5c10a0299cfe8117c94010efa5c0025")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<manage_charge-response>)))
  "Returns full string definition for message of type '<manage_charge-response>"
  (cl:format cl:nil "int8 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'manage_charge-response)))
  "Returns full string definition for message of type 'manage_charge-response"
  (cl:format cl:nil "int8 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <manage_charge-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <manage_charge-response>))
  "Converts a ROS message object to a list"
  (cl:list 'manage_charge-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'manage_charge)))
  'manage_charge-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'manage_charge)))
  'manage_charge-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_charge)))
  "Returns string type for a service object of type '<manage_charge>"
  "sineva_nav/manage_charge")