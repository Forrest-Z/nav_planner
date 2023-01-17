; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude SetPositionsSrv-request.msg.html

(cl:defclass <SetPositionsSrv-request> (roslisp-msg-protocol:ros-message)
  ((positions
    :reader positions
    :initarg :positions
    :type (cl:vector sineva_nav-msg:position)
   :initform (cl:make-array 0 :element-type 'sineva_nav-msg:position :initial-element (cl:make-instance 'sineva_nav-msg:position))))
)

(cl:defclass SetPositionsSrv-request (<SetPositionsSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetPositionsSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetPositionsSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetPositionsSrv-request> is deprecated: use sineva_nav-srv:SetPositionsSrv-request instead.")))

(cl:ensure-generic-function 'positions-val :lambda-list '(m))
(cl:defmethod positions-val ((m <SetPositionsSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:positions-val is deprecated.  Use sineva_nav-srv:positions instead.")
  (positions m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetPositionsSrv-request>) ostream)
  "Serializes a message object of type '<SetPositionsSrv-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'positions))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'positions))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetPositionsSrv-request>) istream)
  "Deserializes a message object of type '<SetPositionsSrv-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'positions) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'positions)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'sineva_nav-msg:position))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetPositionsSrv-request>)))
  "Returns string type for a service object of type '<SetPositionsSrv-request>"
  "sineva_nav/SetPositionsSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPositionsSrv-request)))
  "Returns string type for a service object of type 'SetPositionsSrv-request"
  "sineva_nav/SetPositionsSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetPositionsSrv-request>)))
  "Returns md5sum for a message object of type '<SetPositionsSrv-request>"
  "4b4524857e30c20d60b58e736d911c02")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetPositionsSrv-request)))
  "Returns md5sum for a message object of type 'SetPositionsSrv-request"
  "4b4524857e30c20d60b58e736d911c02")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetPositionsSrv-request>)))
  "Returns full string definition for message of type '<SetPositionsSrv-request>"
  (cl:format cl:nil "# request message~%sineva_nav/position[] positions~%~%================================================================================~%MSG: sineva_nav/position~%string id~%float32 x~%float32 y~%float32 r~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetPositionsSrv-request)))
  "Returns full string definition for message of type 'SetPositionsSrv-request"
  (cl:format cl:nil "# request message~%sineva_nav/position[] positions~%~%================================================================================~%MSG: sineva_nav/position~%string id~%float32 x~%float32 y~%float32 r~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetPositionsSrv-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'positions) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetPositionsSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetPositionsSrv-request
    (cl:cons ':positions (positions msg))
))
;//! \htmlinclude SetPositionsSrv-response.msg.html

(cl:defclass <SetPositionsSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass SetPositionsSrv-response (<SetPositionsSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetPositionsSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetPositionsSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetPositionsSrv-response> is deprecated: use sineva_nav-srv:SetPositionsSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <SetPositionsSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetPositionsSrv-response>) ostream)
  "Serializes a message object of type '<SetPositionsSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetPositionsSrv-response>) istream)
  "Deserializes a message object of type '<SetPositionsSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetPositionsSrv-response>)))
  "Returns string type for a service object of type '<SetPositionsSrv-response>"
  "sineva_nav/SetPositionsSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPositionsSrv-response)))
  "Returns string type for a service object of type 'SetPositionsSrv-response"
  "sineva_nav/SetPositionsSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetPositionsSrv-response>)))
  "Returns md5sum for a message object of type '<SetPositionsSrv-response>"
  "4b4524857e30c20d60b58e736d911c02")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetPositionsSrv-response)))
  "Returns md5sum for a message object of type 'SetPositionsSrv-response"
  "4b4524857e30c20d60b58e736d911c02")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetPositionsSrv-response>)))
  "Returns full string definition for message of type '<SetPositionsSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetPositionsSrv-response)))
  "Returns full string definition for message of type 'SetPositionsSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetPositionsSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetPositionsSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetPositionsSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetPositionsSrv)))
  'SetPositionsSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetPositionsSrv)))
  'SetPositionsSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPositionsSrv)))
  "Returns string type for a service object of type '<SetPositionsSrv>"
  "sineva_nav/SetPositionsSrv")