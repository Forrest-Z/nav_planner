;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::map_lidar_state)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'map_lidar_state (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::MAP_LIDAR_STATE")
  (make-package "SINEVA_NAV::MAP_LIDAR_STATE"))

(in-package "ROS")
;;//! \htmlinclude map_lidar_state.msg.html


(defclass sineva_nav::map_lidar_state
  :super ros::object
  :slots (_state _error_code _info ))

(defmethod sineva_nav::map_lidar_state
  (:init
   (&key
    ((:state __state) "")
    ((:error_code __error_code) 0)
    ((:info __info) "")
    )
   (send-super :init)
   (setq _state (string __state))
   (setq _error_code (round __error_code))
   (setq _info (string __info))
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:error_code
   (&optional __error_code)
   (if __error_code (setq _error_code __error_code)) _error_code)
  (:info
   (&optional __info)
   (if __info (setq _info __info)) _info)
  (:serialization-length
   ()
   (+
    ;; string _state
    4 (length _state)
    ;; int32 _error_code
    4
    ;; string _info
    4 (length _info)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _state
       (write-long (length _state) s) (princ _state s)
     ;; int32 _error_code
       (write-long _error_code s)
     ;; string _info
       (write-long (length _info) s) (princ _info s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _state
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _error_code
     (setq _error_code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _info
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _info (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get sineva_nav::map_lidar_state :md5sum-) "03fb173e56b331eceea7624eb0d0e80f")
(setf (get sineva_nav::map_lidar_state :datatype-) "sineva_nav/map_lidar_state")
(setf (get sineva_nav::map_lidar_state :definition-)
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

string state
int32 error_code
string info


")



(provide :sineva_nav/map_lidar_state "03fb173e56b331eceea7624eb0d0e80f")


