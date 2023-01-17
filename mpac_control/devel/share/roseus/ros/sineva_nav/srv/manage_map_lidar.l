;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::manage_map_lidar)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'manage_map_lidar (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::MANAGE_MAP_LIDAR")
  (make-package "SINEVA_NAV::MANAGE_MAP_LIDAR"))
(unless (find-package "SINEVA_NAV::MANAGE_MAP_LIDARREQUEST")
  (make-package "SINEVA_NAV::MANAGE_MAP_LIDARREQUEST"))
(unless (find-package "SINEVA_NAV::MANAGE_MAP_LIDARRESPONSE")
  (make-package "SINEVA_NAV::MANAGE_MAP_LIDARRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass sineva_nav::manage_map_lidarRequest
  :super ros::object
  :slots (_mapId _flag ))

(defmethod sineva_nav::manage_map_lidarRequest
  (:init
   (&key
    ((:mapId __mapId) "")
    ((:flag __flag) "")
    )
   (send-super :init)
   (setq _mapId (string __mapId))
   (setq _flag (string __flag))
   self)
  (:mapId
   (&optional __mapId)
   (if __mapId (setq _mapId __mapId)) _mapId)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:serialization-length
   ()
   (+
    ;; string _mapId
    4 (length _mapId)
    ;; string _flag
    4 (length _flag)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _mapId
       (write-long (length _mapId) s) (princ _mapId s)
     ;; string _flag
       (write-long (length _flag) s) (princ _flag s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _mapId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mapId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _flag
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _flag (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::manage_map_lidarResponse
  :super ros::object
  :slots (_result _mapId _pose ))

(defmethod sineva_nav::manage_map_lidarResponse
  (:init
   (&key
    ((:result __result) nil)
    ((:mapId __mapId) "")
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _result __result)
   (setq _mapId (string __mapId))
   (setq _pose __pose)
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:mapId
   (&optional __mapId)
   (if __mapId (setq _mapId __mapId)) _mapId)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; bool _result
    1
    ;; string _mapId
    4 (length _mapId)
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _result
       (if _result (write-byte -1 s) (write-byte 0 s))
     ;; string _mapId
       (write-long (length _mapId) s) (princ _mapId s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _result
     (setq _result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mapId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mapId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(defclass sineva_nav::manage_map_lidar
  :super ros::object
  :slots ())

(setf (get sineva_nav::manage_map_lidar :md5sum-) "af39c21a4fa890c80c400b940fd5dfea")
(setf (get sineva_nav::manage_map_lidar :datatype-) "sineva_nav/manage_map_lidar")
(setf (get sineva_nav::manage_map_lidar :request) sineva_nav::manage_map_lidarRequest)
(setf (get sineva_nav::manage_map_lidar :response) sineva_nav::manage_map_lidarResponse)

(defmethod sineva_nav::manage_map_lidarRequest
  (:response () (instance sineva_nav::manage_map_lidarResponse :init)))

(setf (get sineva_nav::manage_map_lidarRequest :md5sum-) "af39c21a4fa890c80c400b940fd5dfea")
(setf (get sineva_nav::manage_map_lidarRequest :datatype-) "sineva_nav/manage_map_lidarRequest")
(setf (get sineva_nav::manage_map_lidarRequest :definition-)
      "# Copyright 2016 The Cartographer Authors
#
# Licensed under the Apache License, Version 2.0 (the \"License\");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an \"AS IS\" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

string mapId
string flag
---
bool result
string mapId
geometry_msgs/Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")

(setf (get sineva_nav::manage_map_lidarResponse :md5sum-) "af39c21a4fa890c80c400b940fd5dfea")
(setf (get sineva_nav::manage_map_lidarResponse :datatype-) "sineva_nav/manage_map_lidarResponse")
(setf (get sineva_nav::manage_map_lidarResponse :definition-)
      "# Copyright 2016 The Cartographer Authors
#
# Licensed under the Apache License, Version 2.0 (the \"License\");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an \"AS IS\" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

string mapId
string flag
---
bool result
string mapId
geometry_msgs/Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")



(provide :sineva_nav/manage_map_lidar "af39c21a4fa890c80c400b940fd5dfea")


