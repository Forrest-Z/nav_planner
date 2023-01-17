
(cl:in-package :asdf)

(defsystem "sineva_nav-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "BaseData" :depends-on ("_package_BaseData"))
    (:file "_package_BaseData" :depends-on ("_package"))
    (:file "SlamStatus" :depends-on ("_package_SlamStatus"))
    (:file "_package_SlamStatus" :depends-on ("_package"))
    (:file "base_sensor_data" :depends-on ("_package_base_sensor_data"))
    (:file "_package_base_sensor_data" :depends-on ("_package"))
    (:file "calib_status" :depends-on ("_package_calib_status"))
    (:file "_package_calib_status" :depends-on ("_package"))
    (:file "map_lidar_state" :depends-on ("_package_map_lidar_state"))
    (:file "_package_map_lidar_state" :depends-on ("_package"))
    (:file "pose2D" :depends-on ("_package_pose2D"))
    (:file "_package_pose2D" :depends-on ("_package"))
    (:file "position" :depends-on ("_package_position"))
    (:file "_package_position" :depends-on ("_package"))
  ))