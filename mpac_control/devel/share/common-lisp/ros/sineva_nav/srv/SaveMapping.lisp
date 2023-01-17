; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude SaveMapping-request.msg.html

(cl:defclass <SaveMapping-request> (roslisp-msg-protocol:ros-message)
  ((save_signal
    :reader save_signal
    :initarg :save_signal
    :type cl:string
    :initform "")
   (save_path
    :reader save_path
    :initarg :save_path
    :type cl:string
    :initform ""))
)

(cl:defclass SaveMapping-request (<SaveMapping-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveMapping-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveMapping-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SaveMapping-request> is deprecated: use sineva_nav-srv:SaveMapping-request instead.")))

(cl:ensure-generic-function 'save_signal-val :lambda-list '(m))
(cl:defmethod save_signal-val ((m <SaveMapping-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:save_signal-val is deprecated.  Use sineva_nav-srv:save_signal instead.")
  (save_signal m))

(cl:ensure-generic-function 'save_path-val :lambda-list '(m))
(cl:defmethod save_path-val ((m <SaveMapping-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:save_path-val is deprecated.  Use sineva_nav-srv:save_path instead.")
  (save_path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveMapping-request>) ostream)
  "Serializes a message object of type '<SaveMapping-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'save_signal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'save_signal))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'save_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'save_path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveMapping-request>) istream)
  "Deserializes a message object of type '<SaveMapping-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'save_signal) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'save_signal) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'save_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'save_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveMapping-request>)))
  "Returns string type for a service object of type '<SaveMapping-request>"
  "sineva_nav/SaveMappingRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveMapping-request)))
  "Returns string type for a service object of type 'SaveMapping-request"
  "sineva_nav/SaveMappingRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveMapping-request>)))
  "Returns md5sum for a message object of type '<SaveMapping-request>"
  "5fe2de99ca88e365b15343be61af7c60")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveMapping-request)))
  "Returns md5sum for a message object of type 'SaveMapping-request"
  "5fe2de99ca88e365b15343be61af7c60")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveMapping-request>)))
  "Returns full string definition for message of type '<SaveMapping-request>"
  (cl:format cl:nil "string save_signal~%string save_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveMapping-request)))
  "Returns full string definition for message of type 'SaveMapping-request"
  (cl:format cl:nil "string save_signal~%string save_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveMapping-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'save_signal))
     4 (cl:length (cl:slot-value msg 'save_path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveMapping-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveMapping-request
    (cl:cons ':save_signal (save_signal msg))
    (cl:cons ':save_path (save_path msg))
))
;//! \htmlinclude SaveMapping-response.msg.html

(cl:defclass <SaveMapping-response> (roslisp-msg-protocol:ros-message)
  ((success_flag
    :reader success_flag
    :initarg :success_flag
    :type cl:integer
    :initform 0))
)

(cl:defclass SaveMapping-response (<SaveMapping-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveMapping-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveMapping-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SaveMapping-response> is deprecated: use sineva_nav-srv:SaveMapping-response instead.")))

(cl:ensure-generic-function 'success_flag-val :lambda-list '(m))
(cl:defmethod success_flag-val ((m <SaveMapping-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:success_flag-val is deprecated.  Use sineva_nav-srv:success_flag instead.")
  (success_flag m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveMapping-response>) ostream)
  "Serializes a message object of type '<SaveMapping-response>"
  (cl:let* ((signed (cl:slot-value msg 'success_flag)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveMapping-response>) istream)
  "Deserializes a message object of type '<SaveMapping-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'success_flag) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveMapping-response>)))
  "Returns string type for a service object of type '<SaveMapping-response>"
  "sineva_nav/SaveMappingResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveMapping-response)))
  "Returns string type for a service object of type 'SaveMapping-response"
  "sineva_nav/SaveMappingResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveMapping-response>)))
  "Returns md5sum for a message object of type '<SaveMapping-response>"
  "5fe2de99ca88e365b15343be61af7c60")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveMapping-response)))
  "Returns md5sum for a message object of type 'SaveMapping-response"
  "5fe2de99ca88e365b15343be61af7c60")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveMapping-response>)))
  "Returns full string definition for message of type '<SaveMapping-response>"
  (cl:format cl:nil "int64 success_flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveMapping-response)))
  "Returns full string definition for message of type 'SaveMapping-response"
  (cl:format cl:nil "int64 success_flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveMapping-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveMapping-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveMapping-response
    (cl:cons ':success_flag (success_flag msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SaveMapping)))
  'SaveMapping-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SaveMapping)))
  'SaveMapping-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveMapping)))
  "Returns string type for a service object of type '<SaveMapping>"
  "sineva_nav/SaveMapping")