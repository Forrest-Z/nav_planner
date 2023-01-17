; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude MapReq-request.msg.html

(cl:defclass <MapReq-request> (roslisp-msg-protocol:ros-message)
  ((mapRequest
    :reader mapRequest
    :initarg :mapRequest
    :type cl:string
    :initform ""))
)

(cl:defclass MapReq-request (<MapReq-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MapReq-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MapReq-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<MapReq-request> is deprecated: use sineva_nav-srv:MapReq-request instead.")))

(cl:ensure-generic-function 'mapRequest-val :lambda-list '(m))
(cl:defmethod mapRequest-val ((m <MapReq-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapRequest-val is deprecated.  Use sineva_nav-srv:mapRequest instead.")
  (mapRequest m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MapReq-request>) ostream)
  "Serializes a message object of type '<MapReq-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mapRequest))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mapRequest))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MapReq-request>) istream)
  "Deserializes a message object of type '<MapReq-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mapRequest) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mapRequest) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MapReq-request>)))
  "Returns string type for a service object of type '<MapReq-request>"
  "sineva_nav/MapReqRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapReq-request)))
  "Returns string type for a service object of type 'MapReq-request"
  "sineva_nav/MapReqRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MapReq-request>)))
  "Returns md5sum for a message object of type '<MapReq-request>"
  "f620cddd1adb52c04caee6100b1f237e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MapReq-request)))
  "Returns md5sum for a message object of type 'MapReq-request"
  "f620cddd1adb52c04caee6100b1f237e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MapReq-request>)))
  "Returns full string definition for message of type '<MapReq-request>"
  (cl:format cl:nil "string mapRequest~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MapReq-request)))
  "Returns full string definition for message of type 'MapReq-request"
  (cl:format cl:nil "string mapRequest~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MapReq-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'mapRequest))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MapReq-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MapReq-request
    (cl:cons ':mapRequest (mapRequest msg))
))
;//! \htmlinclude MapReq-response.msg.html

(cl:defclass <MapReq-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0)
   (mapDate
    :reader mapDate
    :initarg :mapDate
    :type nav_msgs-msg:OccupancyGrid
    :initform (cl:make-instance 'nav_msgs-msg:OccupancyGrid)))
)

(cl:defclass MapReq-response (<MapReq-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MapReq-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MapReq-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<MapReq-response> is deprecated: use sineva_nav-srv:MapReq-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <MapReq-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))

(cl:ensure-generic-function 'mapDate-val :lambda-list '(m))
(cl:defmethod mapDate-val ((m <MapReq-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapDate-val is deprecated.  Use sineva_nav-srv:mapDate instead.")
  (mapDate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MapReq-response>) ostream)
  "Serializes a message object of type '<MapReq-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mapDate) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MapReq-response>) istream)
  "Deserializes a message object of type '<MapReq-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mapDate) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MapReq-response>)))
  "Returns string type for a service object of type '<MapReq-response>"
  "sineva_nav/MapReqResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapReq-response)))
  "Returns string type for a service object of type 'MapReq-response"
  "sineva_nav/MapReqResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MapReq-response>)))
  "Returns md5sum for a message object of type '<MapReq-response>"
  "f620cddd1adb52c04caee6100b1f237e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MapReq-response)))
  "Returns md5sum for a message object of type 'MapReq-response"
  "f620cddd1adb52c04caee6100b1f237e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MapReq-response>)))
  "Returns full string definition for message of type '<MapReq-response>"
  (cl:format cl:nil "int8 result~%nav_msgs/OccupancyGrid mapDate~%~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MapReq-response)))
  "Returns full string definition for message of type 'MapReq-response"
  (cl:format cl:nil "int8 result~%nav_msgs/OccupancyGrid mapDate~%~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MapReq-response>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mapDate))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MapReq-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MapReq-response
    (cl:cons ':result (result msg))
    (cl:cons ':mapDate (mapDate msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MapReq)))
  'MapReq-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MapReq)))
  'MapReq-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapReq)))
  "Returns string type for a service object of type '<MapReq>"
  "sineva_nav/MapReq")