; Auto-generated. Do not edit!


(cl:in-package sineva_nav-msg)


;//! \htmlinclude map_lidar_state.msg.html

(cl:defclass <map_lidar_state> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:string
    :initform "")
   (error_code
    :reader error_code
    :initarg :error_code
    :type cl:integer
    :initform 0)
   (info
    :reader info
    :initarg :info
    :type cl:string
    :initform ""))
)

(cl:defclass map_lidar_state (<map_lidar_state>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <map_lidar_state>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'map_lidar_state)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sineva_nav-msg:<map_lidar_state> is deprecated: use sineva_nav-msg:map_lidar_state instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <map_lidar_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:state-val is deprecated.  Use sineva_nav-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <map_lidar_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:error_code-val is deprecated.  Use sineva_nav-msg:error_code instead.")
  (error_code m))

(cl:ensure-generic-function 'info-val :lambda-list '(m))
(cl:defmethod info-val ((m <map_lidar_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sineva_nav-msg:info-val is deprecated.  Use sineva_nav-msg:info instead.")
  (info m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <map_lidar_state>) ostream)
  "Serializes a message object of type '<map_lidar_state>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'state))
  (cl:let* ((signed (cl:slot-value msg 'error_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'info))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'info))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <map_lidar_state>) istream)
  "Deserializes a message object of type '<map_lidar_state>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'state) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_code) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'info) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'info) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<map_lidar_state>)))
  "Returns string type for a message object of type '<map_lidar_state>"
  "sineva_nav/map_lidar_state")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'map_lidar_state)))
  "Returns string type for a message object of type 'map_lidar_state"
  "sineva_nav/map_lidar_state")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<map_lidar_state>)))
  "Returns md5sum for a message object of type '<map_lidar_state>"
  "03fb173e56b331eceea7624eb0d0e80f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'map_lidar_state)))
  "Returns md5sum for a message object of type 'map_lidar_state"
  "03fb173e56b331eceea7624eb0d0e80f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<map_lidar_state>)))
  "Returns full string definition for message of type '<map_lidar_state>"
  (cl:format cl:nil "# Copyright 2016 The Cartographer Authors~%#~%# Licensed under the Apache License, Version 2.0 (the \"License\");~%# you may not use this file except in compliance with the License.~%# You may obtain a copy of the License at~%#~%#      http://www.apache.org/licenses/LICENSE-2.0~%#~%# Unless required by applicable law or agreed to in writing, software~%# distributed under the License is distributed on an \"AS IS\" BASIS,~%# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.~%# See the License for the specific language governing permissions and~%# limitations under the License.~%~%string state~%int32 error_code~%string info~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'map_lidar_state)))
  "Returns full string definition for message of type 'map_lidar_state"
  (cl:format cl:nil "# Copyright 2016 The Cartographer Authors~%#~%# Licensed under the Apache License, Version 2.0 (the \"License\");~%# you may not use this file except in compliance with the License.~%# You may obtain a copy of the License at~%#~%#      http://www.apache.org/licenses/LICENSE-2.0~%#~%# Unless required by applicable law or agreed to in writing, software~%# distributed under the License is distributed on an \"AS IS\" BASIS,~%# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.~%# See the License for the specific language governing permissions and~%# limitations under the License.~%~%string state~%int32 error_code~%string info~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <map_lidar_state>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'state))
     4
     4 (cl:length (cl:slot-value msg 'info))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <map_lidar_state>))
  "Converts a ROS message object to a list"
  (cl:list 'map_lidar_state
    (cl:cons ':state (state msg))
    (cl:cons ':error_code (error_code msg))
    (cl:cons ':info (info msg))
))
