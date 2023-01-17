; Auto-generated. Do not edit!


(cl:in-package sineva_nav-msg)


;//! \htmlinclude calib_status.msg.html

(cl:defclass <calib_status> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass calib_status (<calib_status>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <calib_status>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'calib_status)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-msg:<calib_status> is deprecated: use sineva_nav-msg:calib_status instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <calib_status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:status-val is deprecated.  Use sineva_nav-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <calib_status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:data-val is deprecated.  Use sineva_nav-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <calib_status>) ostream)
  "Serializes a message object of type '<calib_status>"
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <calib_status>) istream)
  "Deserializes a message object of type '<calib_status>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<calib_status>)))
  "Returns string type for a message object of type '<calib_status>"
  "sineva_nav/calib_status")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'calib_status)))
  "Returns string type for a message object of type 'calib_status"
  "sineva_nav/calib_status")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<calib_status>)))
  "Returns md5sum for a message object of type '<calib_status>"
  "d1b06abf01a800329a56a7f3daa01cee")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'calib_status)))
  "Returns md5sum for a message object of type 'calib_status"
  "d1b06abf01a800329a56a7f3daa01cee")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<calib_status>)))
  "Returns full string definition for message of type '<calib_status>"
  (cl:format cl:nil "int8 status~%float32[] data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'calib_status)))
  "Returns full string definition for message of type 'calib_status"
  (cl:format cl:nil "int8 status~%float32[] data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <calib_status>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <calib_status>))
  "Converts a ROS message object to a list"
  (cl:list 'calib_status
    (cl:cons ':status (status msg))
    (cl:cons ':data (data msg))
))
