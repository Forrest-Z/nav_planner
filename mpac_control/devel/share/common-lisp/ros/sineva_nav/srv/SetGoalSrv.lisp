; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude SetGoalSrv-request.msg.html

(cl:defclass <SetGoalSrv-request> (roslisp-msg-protocol:ros-message)
  ((goal_id
    :reader goal_id
    :initarg :goal_id
    :type cl:string
    :initform "")
   (goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (timeout
    :reader timeout
    :initarg :timeout
    :type cl:integer
    :initform 0)
   (maxDistance
    :reader maxDistance
    :initarg :maxDistance
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetGoalSrv-request (<SetGoalSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetGoalSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetGoalSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetGoalSrv-request> is deprecated: use sineva_nav-srv:SetGoalSrv-request instead.")))

(cl:ensure-generic-function 'goal_id-val :lambda-list '(m))
(cl:defmethod goal_id-val ((m <SetGoalSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:goal_id-val is deprecated.  Use sineva_nav-srv:goal_id instead.")
  (goal_id m))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <SetGoalSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:goal-val is deprecated.  Use sineva_nav-srv:goal instead.")
  (goal m))

(cl:ensure-generic-function 'timeout-val :lambda-list '(m))
(cl:defmethod timeout-val ((m <SetGoalSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:timeout-val is deprecated.  Use sineva_nav-srv:timeout instead.")
  (timeout m))

(cl:ensure-generic-function 'maxDistance-val :lambda-list '(m))
(cl:defmethod maxDistance-val ((m <SetGoalSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:maxDistance-val is deprecated.  Use sineva_nav-srv:maxDistance instead.")
  (maxDistance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetGoalSrv-request>) ostream)
  "Serializes a message object of type '<SetGoalSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'goal_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'goal_id))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
  (cl:let* ((signed (cl:slot-value msg 'timeout)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'maxDistance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetGoalSrv-request>) istream)
  "Deserializes a message object of type '<SetGoalSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'goal_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'goal_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timeout) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'maxDistance) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetGoalSrv-request>)))
  "Returns string type for a service object of type '<SetGoalSrv-request>"
  "sineva_nav/SetGoalSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGoalSrv-request)))
  "Returns string type for a service object of type 'SetGoalSrv-request"
  "sineva_nav/SetGoalSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetGoalSrv-request>)))
  "Returns md5sum for a message object of type '<SetGoalSrv-request>"
  "c19bf813310f153659784721f23f0785")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetGoalSrv-request)))
  "Returns md5sum for a message object of type 'SetGoalSrv-request"
  "c19bf813310f153659784721f23f0785")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetGoalSrv-request>)))
  "Returns full string definition for message of type '<SetGoalSrv-request>"
  (cl:format cl:nil "# request message~%string goal_id~%geometry_msgs/Pose goal~%int32 timeout~%float32 maxDistance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetGoalSrv-request)))
  "Returns full string definition for message of type 'SetGoalSrv-request"
  (cl:format cl:nil "# request message~%string goal_id~%geometry_msgs/Pose goal~%int32 timeout~%float32 maxDistance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetGoalSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'goal_id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetGoalSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetGoalSrv-request
    (cl:cons ':goal_id (goal_id msg))
    (cl:cons ':goal (goal msg))
    (cl:cons ':timeout (timeout msg))
    (cl:cons ':maxDistance (maxDistance msg))
))
;//! \htmlinclude SetGoalSrv-response.msg.html

(cl:defclass <SetGoalSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass SetGoalSrv-response (<SetGoalSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetGoalSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetGoalSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<SetGoalSrv-response> is deprecated: use sineva_nav-srv:SetGoalSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <SetGoalSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetGoalSrv-response>) ostream)
  "Serializes a message object of type '<SetGoalSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetGoalSrv-response>) istream)
  "Deserializes a message object of type '<SetGoalSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetGoalSrv-response>)))
  "Returns string type for a service object of type '<SetGoalSrv-response>"
  "sineva_nav/SetGoalSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGoalSrv-response)))
  "Returns string type for a service object of type 'SetGoalSrv-response"
  "sineva_nav/SetGoalSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetGoalSrv-response>)))
  "Returns md5sum for a message object of type '<SetGoalSrv-response>"
  "c19bf813310f153659784721f23f0785")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetGoalSrv-response)))
  "Returns md5sum for a message object of type 'SetGoalSrv-response"
  "c19bf813310f153659784721f23f0785")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetGoalSrv-response>)))
  "Returns full string definition for message of type '<SetGoalSrv-response>"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetGoalSrv-response)))
  "Returns full string definition for message of type 'SetGoalSrv-response"
  (cl:format cl:nil "# response message~%int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetGoalSrv-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetGoalSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetGoalSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetGoalSrv)))
  'SetGoalSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetGoalSrv)))
  'SetGoalSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGoalSrv)))
  "Returns string type for a service object of type '<SetGoalSrv>"
  "sineva_nav/SetGoalSrv")