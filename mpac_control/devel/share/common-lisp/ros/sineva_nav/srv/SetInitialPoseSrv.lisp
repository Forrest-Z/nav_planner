; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude SetInitialPoseSrv-request.msg.html

(cl:defclass <SetInitialPoseSrv-request> (roslisp-msg-protocol:ros-message)
  ((initialpose
    :reader initialpose
    :initarg :initialpose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass SetInitialPoseSrv-request (<SetInitialPoseSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetInitialPoseSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetInitialPoseSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetInitialPoseSrv-request> is deprecated: use sineva_nav-srv:SetInitialPoseSrv-request instead.")))

(cl:ensure-generic-function 'initialpose-val :lambda-list '(m))
(cl:defmethod initialpose-val ((m <SetInitialPoseSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:initialpose-val is deprecated.  Use sineva_nav-srv:initialpose instead.")
  (initialpose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetInitialPoseSrv-request>) ostream)
  "Serializes a message object of type '<SetInitialPoseSrv-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'initialpose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetInitialPoseSrv-request>) istream)
  "Deserializes a message object of type '<SetInitialPoseSrv-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'initialpose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetInitialPoseSrv-request>)))
  "Returns string type for a service object of type '<SetInitialPoseSrv-request>"
  "sineva_nav/SetInitialPoseSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInitialPoseSrv-request)))
  "Returns string type for a service object of type 'SetInitialPoseSrv-request"
  "sineva_nav/SetInitialPoseSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetInitialPoseSrv-request>)))
  "Returns md5sum for a message object of type '<SetInitialPoseSrv-request>"
  "f79b49745aeb97ecd996566018ba09e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetInitialPoseSrv-request)))
  "Returns md5sum for a message object of type 'SetInitialPoseSrv-request"
  "f79b49745aeb97ecd996566018ba09e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetInitialPoseSrv-request>)))
  "Returns full string definition for message of type '<SetInitialPoseSrv-request>"
  (cl:format cl:nil "# request message~%geometry_msgs/Pose initialpose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetInitialPoseSrv-request)))
  "Returns full string definition for message of type 'SetInitialPoseSrv-request"
  (cl:format cl:nil "# request message~%geometry_msgs/Pose initialpose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetInitialPoseSrv-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'initialpose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetInitialPoseSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetInitialPoseSrv-request
    (cl:cons ':initialpose (initialpose msg))
))
;//! \htmlinclude SetInitialPoseSrv-response.msg.html

(cl:defclass <SetInitialPoseSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass SetInitialPoseSrv-response (<SetInitialPoseSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetInitialPoseSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetInitialPoseSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetInitialPoseSrv-response> is deprecated: use sineva_nav-srv:SetInitialPoseSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <SetInitialPoseSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetInitialPoseSrv-response>) ostream)
  "Serializes a message object of type '<SetInitialPoseSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetInitialPoseSrv-response>) istream)
  "Deserializes a message object of type '<SetInitialPoseSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetInitialPoseSrv-response>)))
  "Returns string type for a service object of type '<SetInitialPoseSrv-response>"
  "sineva_nav/SetInitialPoseSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInitialPoseSrv-response)))
  "Returns string type for a service object of type 'SetInitialPoseSrv-response"
  "sineva_nav/SetInitialPoseSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetInitialPoseSrv-response>)))
  "Returns md5sum for a message object of type '<SetInitialPoseSrv-response>"
  "f79b49745aeb97ecd996566018ba09e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetInitialPoseSrv-response)))
  "Returns md5sum for a message object of type 'SetInitialPoseSrv-response"
  "f79b49745aeb97ecd996566018ba09e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetInitialPoseSrv-response>)))
  "Returns full string definition for message of type '<SetInitialPoseSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetInitialPoseSrv-response)))
  "Returns full string definition for message of type 'SetInitialPoseSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetInitialPoseSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetInitialPoseSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetInitialPoseSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetInitialPoseSrv)))
  'SetInitialPoseSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetInitialPoseSrv)))
  'SetInitialPoseSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetInitialPoseSrv)))
  "Returns string type for a service object of type '<SetInitialPoseSrv>"
  "sineva_nav/SetInitialPoseSrv")