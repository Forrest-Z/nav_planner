; Auto-generated. Do not edit!


(cl:in-package sineva_nav-msg)


;//! \htmlinclude BaseData.msg.html

(cl:defclass <BaseData> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass BaseData (<BaseData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BaseData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BaseData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-msg:<BaseData> is deprecated: use sineva_nav-msg:BaseData instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <BaseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:type-val is deprecated.  Use sineva_nav-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <BaseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:data-val is deprecated.  Use sineva_nav-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BaseData>) ostream)
  "Serializes a message object of type '<BaseData>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BaseData>) istream)
  "Deserializes a message object of type '<BaseData>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BaseData>)))
  "Returns string type for a message object of type '<BaseData>"
  "sineva_nav/BaseData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BaseData)))
  "Returns string type for a message object of type 'BaseData"
  "sineva_nav/BaseData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BaseData>)))
  "Returns md5sum for a message object of type '<BaseData>"
  "fa8c6edfee3919656731e93d6bd477b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BaseData)))
  "Returns md5sum for a message object of type 'BaseData"
  "fa8c6edfee3919656731e93d6bd477b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BaseData>)))
  "Returns full string definition for message of type '<BaseData>"
  (cl:format cl:nil "uint8 type~%uint8[] data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BaseData)))
  "Returns full string definition for message of type 'BaseData"
  (cl:format cl:nil "uint8 type~%uint8[] data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BaseData>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BaseData>))
  "Converts a ROS message object to a list"
  (cl:list 'BaseData
    (cl:cons ':type (type msg))
    (cl:cons ':data (data msg))
))
