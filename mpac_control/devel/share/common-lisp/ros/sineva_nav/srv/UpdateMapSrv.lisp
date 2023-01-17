; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude UpdateMapSrv-request.msg.html

(cl:defclass <UpdateMapSrv-request> (roslisp-msg-protocol:ros-message)
  ((mapDate
    :reader mapDate
    :initarg :mapDate
    :type nav_msgs-msg:OccupancyGrid
    :initform (cl:make-instance 'nav_msgs-msg:OccupancyGrid)))
)

(cl:defclass UpdateMapSrv-request (<UpdateMapSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UpdateMapSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UpdateMapSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<UpdateMapSrv-request> is deprecated: use sineva_nav-srv:UpdateMapSrv-request instead.")))

(cl:ensure-generic-function 'mapDate-val :lambda-list '(m))
(cl:defmethod mapDate-val ((m <UpdateMapSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapDate-val is deprecated.  Use sineva_nav-srv:mapDate instead.")
  (mapDate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UpdateMapSrv-request>) ostream)
  "Serializes a message object of type '<UpdateMapSrv-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mapDate) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UpdateMapSrv-request>) istream)
  "Deserializes a message object of type '<UpdateMapSrv-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mapDate) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UpdateMapSrv-request>)))
  "Returns string type for a service object of type '<UpdateMapSrv-request>"
  "sineva_nav/UpdateMapSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateMapSrv-request)))
  "Returns string type for a service object of type 'UpdateMapSrv-request"
  "sineva_nav/UpdateMapSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UpdateMapSrv-request>)))
  "Returns md5sum for a message object of type '<UpdateMapSrv-request>"
  "e2ab93ba586b17f6c5de94ce88e0aec5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UpdateMapSrv-request)))
  "Returns md5sum for a message object of type 'UpdateMapSrv-request"
  "e2ab93ba586b17f6c5de94ce88e0aec5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UpdateMapSrv-request>)))
  "Returns full string definition for message of type '<UpdateMapSrv-request>"
  (cl:format cl:nil "nav_msgs/OccupancyGrid mapDate~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UpdateMapSrv-request)))
  "Returns full string definition for message of type 'UpdateMapSrv-request"
  (cl:format cl:nil "nav_msgs/OccupancyGrid mapDate~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UpdateMapSrv-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mapDate))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UpdateMapSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'UpdateMapSrv-request
    (cl:cons ':mapDate (mapDate msg))
))
;//! \htmlinclude UpdateMapSrv-response.msg.html

(cl:defclass <UpdateMapSrv-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0))
)

(cl:defclass UpdateMapSrv-response (<UpdateMapSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UpdateMapSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UpdateMapSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<UpdateMapSrv-response> is deprecated: use sineva_nav-srv:UpdateMapSrv-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <UpdateMapSrv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UpdateMapSrv-response>) ostream)
  "Serializes a message object of type '<UpdateMapSrv-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UpdateMapSrv-response>) istream)
  "Deserializes a message object of type '<UpdateMapSrv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UpdateMapSrv-response>)))
  "Returns string type for a service object of type '<UpdateMapSrv-response>"
  "sineva_nav/UpdateMapSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateMapSrv-response)))
  "Returns string type for a service object of type 'UpdateMapSrv-response"
  "sineva_nav/UpdateMapSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UpdateMapSrv-response>)))
  "Returns md5sum for a message object of type '<UpdateMapSrv-response>"
  "e2ab93ba586b17f6c5de94ce88e0aec5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UpdateMapSrv-response)))
  "Returns md5sum for a message object of type 'UpdateMapSrv-response"
  "e2ab93ba586b17f6c5de94ce88e0aec5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UpdateMapSrv-response>)))
  "Returns full string definition for message of type '<UpdateMapSrv-response>"
  (cl:format cl:nil "int8 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UpdateMapSrv-response)))
  "Returns full string definition for message of type 'UpdateMapSrv-response"
  (cl:format cl:nil "int8 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UpdateMapSrv-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UpdateMapSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'UpdateMapSrv-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'UpdateMapSrv)))
  'UpdateMapSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'UpdateMapSrv)))
  'UpdateMapSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateMapSrv)))
  "Returns string type for a service object of type '<UpdateMapSrv>"
  "sineva_nav/UpdateMapSrv")