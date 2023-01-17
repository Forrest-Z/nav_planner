; Auto-generated. Do not edit!


(cl:in-package sineva_nav-srv)


;//! \htmlinclude manage_map_lidar-request.msg.html

(cl:defclass <manage_map_lidar-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass manage_map_lidar-request (<manage_map_lidar-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <manage_map_lidar-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'manage_map_lidar-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<manage_map_lidar-request> is deprecated: use sineva_nav-srv:manage_map_lidar-request instead.")))

(cl:ensure-generic-function 'mapId-val :lambda-list '(m))
(cl:defmethod mapId-val ((m <manage_map_lidar-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapId-val is deprecated.  Use sineva_nav-srv:mapId instead.")
  (mapId m))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <manage_map_lidar-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:flag-val is deprecated.  Use sineva_nav-srv:flag instead.")
  (flag m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <manage_map_lidar-request>) ostream)
  "Serializes a message object of type '<manage_map_lidar-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <manage_map_lidar-request>) istream)
  "Deserializes a message object of type '<manage_map_lidar-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<manage_map_lidar-request>)))
  "Returns string type for a service object of type '<manage_map_lidar-request>"
  "sineva_nav/manage_map_lidarRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_map_lidar-request)))
  "Returns string type for a service object of type 'manage_map_lidar-request"
  "sineva_nav/manage_map_lidarRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<manage_map_lidar-request>)))
  "Returns md5sum for a message object of type '<manage_map_lidar-request>"
  "af39c21a4fa890c80c400b940fd5dfea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'manage_map_lidar-request)))
  "Returns md5sum for a message object of type 'manage_map_lidar-request"
  "af39c21a4fa890c80c400b940fd5dfea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<manage_map_lidar-request>)))
  "Returns full string definition for message of type '<manage_map_lidar-request>"
  (cl:format cl:nil "# Copyright 2016 The Cartographer Authors~%#~%# Licensed under the Apache License, Version 2.0 (the \"License\");~%# you may not use this file except in compliance with the License.~%# You may obtain a copy of the License at~%#~%#      http://www.apache.org/licenses/LICENSE-2.0~%#~%# Unless required by applicable law or agreed to in writing, software~%# distributed under the License is distributed on an \"AS IS\" BASIS,~%# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.~%# See the License for the specific language governing permissions and~%# limitations under the License.~%~%string mapId~%string flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'manage_map_lidar-request)))
  "Returns full string definition for message of type 'manage_map_lidar-request"
  (cl:format cl:nil "# Copyright 2016 The Cartographer Authors~%#~%# Licensed under the Apache License, Version 2.0 (the \"License\");~%# you may not use this file except in compliance with the License.~%# You may obtain a copy of the License at~%#~%#      http://www.apache.org/licenses/LICENSE-2.0~%#~%# Unless required by applicable law or agreed to in writing, software~%# distributed under the License is distributed on an \"AS IS\" BASIS,~%# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.~%# See the License for the specific language governing permissions and~%# limitations under the License.~%~%string mapId~%string flag~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <manage_map_lidar-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'mapId))
     4 (cl:length (cl:slot-value msg 'flag))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <manage_map_lidar-request>))
  "Converts a ROS message object to a list"
  (cl:list 'manage_map_lidar-request
    (cl:cons ':mapId (mapId msg))
    (cl:cons ':flag (flag msg))
))
;//! \htmlinclude manage_map_lidar-response.msg.html

(cl:defclass <manage_map_lidar-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil)
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

(cl:defclass manage_map_lidar-response (<manage_map_lidar-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <manage_map_lidar-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'manage_map_lidar-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-srv:<manage_map_lidar-response> is deprecated: use sineva_nav-srv:manage_map_lidar-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <manage_map_lidar-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:result-val is deprecated.  Use sineva_nav-srv:result instead.")
  (result m))

(cl:ensure-generic-function 'mapId-val :lambda-list '(m))
(cl:defmethod mapId-val ((m <manage_map_lidar-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:mapId-val is deprecated.  Use sineva_nav-srv:mapId instead.")
  (mapId m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <manage_map_lidar-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-srv:pose-val is deprecated.  Use sineva_nav-srv:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <manage_map_lidar-response>) ostream)
  "Serializes a message object of type '<manage_map_lidar-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mapId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mapId))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <manage_map_lidar-response>) istream)
  "Deserializes a message object of type '<manage_map_lidar-response>"
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<manage_map_lidar-response>)))
  "Returns string type for a service object of type '<manage_map_lidar-response>"
  "sineva_nav/manage_map_lidarResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_map_lidar-response)))
  "Returns string type for a service object of type 'manage_map_lidar-response"
  "sineva_nav/manage_map_lidarResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<manage_map_lidar-response>)))
  "Returns md5sum for a message object of type '<manage_map_lidar-response>"
  "af39c21a4fa890c80c400b940fd5dfea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'manage_map_lidar-response)))
  "Returns md5sum for a message object of type 'manage_map_lidar-response"
  "af39c21a4fa890c80c400b940fd5dfea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<manage_map_lidar-response>)))
  "Returns full string definition for message of type '<manage_map_lidar-response>"
  (cl:format cl:nil "bool result~%string mapId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'manage_map_lidar-response)))
  "Returns full string definition for message of type 'manage_map_lidar-response"
  (cl:format cl:nil "bool result~%string mapId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <manage_map_lidar-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'mapId))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <manage_map_lidar-response>))
  "Converts a ROS message object to a list"
  (cl:list 'manage_map_lidar-response
    (cl:cons ':result (result msg))
    (cl:cons ':mapId (mapId msg))
    (cl:cons ':pose (pose msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'manage_map_lidar)))
  'manage_map_lidar-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'manage_map_lidar)))
  'manage_map_lidar-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'manage_map_lidar)))
  "Returns string type for a service object of type '<manage_map_lidar>"
  "sineva_nav/manage_map_lidar")