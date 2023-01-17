; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude Relocation-request.msg.html

(cl:defclass <Relocation-request> (roslisp-msg-protocol:ros-message)
  ((mapId
    :reader mapId
    :initarg :mapId
    :type cl:string
    :initform "")
   (flag
    :reader flag
    :initarg :flag
    :type cl:string
    :initform ""))
)

(cl:defclass Relocation-request (<Relocation-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Relocation-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Relocation-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<Relocation-request> is deprecated: use sineva_nav-srv:Relocation-request instead.")))

(cl:ensure-generic-function 'mapId-val :lambda-list '(m))
(cl:defmethod mapId-val ((m <Relocation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapId-val is deprecated.  Use sineva_nav-srv:mapId instead.")
  (mapId m))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <Relocation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:flag-val is deprecated.  Use sineva_nav-srv:flag instead.")
  (flag m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Relocation-request>) ostream)
  "Serializes a message object of type '<Relocation-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mapId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mapId))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'flag))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'flag))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Relocation-request>) istream)
  "Deserializes a message object of type '<Relocation-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mapId) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mapId) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'flag) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'flag) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Relocation-request>)))
  "Returns string type for a service object of type '<Relocation-request>"
  "sineva_nav/RelocationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Relocation-request)))
  "Returns string type for a service object of type 'Relocation-request"
  "sineva_nav/RelocationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Relocation-request>)))
  "Returns md5sum for a message object of type '<Relocation-request>"
  "82f1b53ec405d751bfebc95a42bfd76d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Relocation-request)))
  "Returns md5sum for a message object of type 'Relocation-request"
  "82f1b53ec405d751bfebc95a42bfd76d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Relocation-request>)))
  "Returns full string definition for message of type '<Relocation-request>"
  (cl:format cl:nil "string mapId~%string flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Relocation-request)))
  "Returns full string definition for message of type 'Relocation-request"
  (cl:format cl:nil "string mapId~%string flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Relocation-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'mapId))
     4 (cl:length (cl:slot-value msg 'flag))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Relocation-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Relocation-request
    (cl:cons ':mapId (mapId msg))
    (cl:cons ':flag (flag msg))
))
;//! \htmlinclude Relocation-response.msg.html

(cl:defclass <Relocation-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0)
   (mapId
    :reader mapId
    :initarg :mapId
    :type cl:string
    :initform "")
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass Relocation-response (<Relocation-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Relocation-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Relocation-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<Relocation-response> is deprecated: use sineva_nav-srv:Relocation-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <Relocation-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))

(cl:ensure-generic-function 'mapId-val :lambda-list '(m))
(cl:defmethod mapId-val ((m <Relocation-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapId-val is deprecated.  Use sineva_nav-srv:mapId instead.")
  (mapId m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Relocation-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:pose-val is deprecated.  Use sineva_nav-srv:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Relocation-response>) ostream)
  "Serializes a message object of type '<Relocation-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mapId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mapId))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Relocation-response>) istream)
  "Deserializes a message object of type '<Relocation-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mapId) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mapId) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Relocation-response>)))
  "Returns string type for a service object of type '<Relocation-response>"
  "sineva_nav/RelocationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Relocation-response)))
  "Returns string type for a service object of type 'Relocation-response"
  "sineva_nav/RelocationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Relocation-response>)))
  "Returns md5sum for a message object of type '<Relocation-response>"
  "82f1b53ec405d751bfebc95a42bfd76d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Relocation-response)))
  "Returns md5sum for a message object of type 'Relocation-response"
  "82f1b53ec405d751bfebc95a42bfd76d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Relocation-response>)))
  "Returns full string definition for message of type '<Relocation-response>"
  (cl:format cl:nil "int8 result~%string mapId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Relocation-response)))
  "Returns full string definition for message of type 'Relocation-response"
  (cl:format cl:nil "int8 result~%string mapId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Relocation-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'mapId))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Relocation-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Relocation-response
    (cl:cons ':result (result msg))
    (cl:cons ':mapId (mapId msg))
    (cl:cons ':pose (pose msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Relocation)))
  'Relocation-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Relocation)))
  'Relocation-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Relocation)))
  "Returns string type for a service object of type '<Relocation>"
  "sineva_nav/Relocation")