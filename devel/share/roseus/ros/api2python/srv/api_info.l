;; Auto-generated. Do not edit!


(when (boundp 'api2python::api_info)
  (if (not (find-package "API2PYTHON"))
    (make-package "API2PYTHON"))
  (shadow 'api_info (find-package "API2PYTHON")))
(unless (find-package "API2PYTHON::API_INFO")
  (make-package "API2PYTHON::API_INFO"))
(unless (find-package "API2PYTHON::API_INFOREQUEST")
  (make-package "API2PYTHON::API_INFOREQUEST"))
(unless (find-package "API2PYTHON::API_INFORESPONSE")
  (make-package "API2PYTHON::API_INFORESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass api2python::api_infoRequest
  :super ros::object
  :slots (_robot_pose _robot_vel _reference_path _map ))

(defmethod api2python::api_infoRequest
  (:init
   (&key
    ((:robot_pose __robot_pose) (instance geometry_msgs::PoseStamped :init))
    ((:robot_vel __robot_vel) (instance geometry_msgs::Twist :init))
    ((:reference_path __reference_path) (instance nav_msgs::Path :init))
    ((:map __map) (instance nav_msgs::OccupancyGrid :init))
    )
   (send-super :init)
   (setq _robot_pose __robot_pose)
   (setq _robot_vel __robot_vel)
   (setq _reference_path __reference_path)
   (setq _map __map)
   self)
  (:robot_pose
   (&rest __robot_pose)
   (if (keywordp (car __robot_pose))
       (send* _robot_pose __robot_pose)
     (progn
       (if __robot_pose (setq _robot_pose (car __robot_pose)))
       _robot_pose)))
  (:robot_vel
   (&rest __robot_vel)
   (if (keywordp (car __robot_vel))
       (send* _robot_vel __robot_vel)
     (progn
       (if __robot_vel (setq _robot_vel (car __robot_vel)))
       _robot_vel)))
  (:reference_path
   (&rest __reference_path)
   (if (keywordp (car __reference_path))
       (send* _reference_path __reference_path)
     (progn
       (if __reference_path (setq _reference_path (car __reference_path)))
       _reference_path)))
  (:map
   (&rest __map)
   (if (keywordp (car __map))
       (send* _map __map)
     (progn
       (if __map (setq _map (car __map)))
       _map)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/PoseStamped _robot_pose
    (send _robot_pose :serialization-length)
    ;; geometry_msgs/Twist _robot_vel
    (send _robot_vel :serialization-length)
    ;; nav_msgs/Path _reference_path
    (send _reference_path :serialization-length)
    ;; nav_msgs/OccupancyGrid _map
    (send _map :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PoseStamped _robot_pose
       (send _robot_pose :serialize s)
     ;; geometry_msgs/Twist _robot_vel
       (send _robot_vel :serialize s)
     ;; nav_msgs/Path _reference_path
       (send _reference_path :serialize s)
     ;; nav_msgs/OccupancyGrid _map
       (send _map :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PoseStamped _robot_pose
     (send _robot_pose :deserialize buf ptr-) (incf ptr- (send _robot_pose :serialization-length))
   ;; geometry_msgs/Twist _robot_vel
     (send _robot_vel :deserialize buf ptr-) (incf ptr- (send _robot_vel :serialization-length))
   ;; nav_msgs/Path _reference_path
     (send _reference_path :deserialize buf ptr-) (incf ptr- (send _reference_path :serialization-length))
   ;; nav_msgs/OccupancyGrid _map
     (send _map :deserialize buf ptr-) (incf ptr- (send _map :serialization-length))
   ;;
   self)
  )

(defclass api2python::api_infoResponse
  :super ros::object
  :slots (_cmd ))

(defmethod api2python::api_infoResponse
  (:init
   (&key
    ((:cmd __cmd) (instance geometry_msgs::Twist :init))
    )
   (send-super :init)
   (setq _cmd __cmd)
   self)
  (:cmd
   (&rest __cmd)
   (if (keywordp (car __cmd))
       (send* _cmd __cmd)
     (progn
       (if __cmd (setq _cmd (car __cmd)))
       _cmd)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Twist _cmd
    (send _cmd :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Twist _cmd
       (send _cmd :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Twist _cmd
     (send _cmd :deserialize buf ptr-) (incf ptr- (send _cmd :serialization-length))
   ;;
   self)
  )

(defclass api2python::api_info
  :super ros::object
  :slots ())

(setf (get api2python::api_info :md5sum-) "2e0aa5b6b51d31843d46fc8ed1324a8c")
(setf (get api2python::api_info :datatype-) "api2python/api_info")
(setf (get api2python::api_info :request) api2python::api_infoRequest)
(setf (get api2python::api_info :response) api2python::api_infoResponse)

(defmethod api2python::api_infoRequest
  (:response () (instance api2python::api_infoResponse :init)))

(setf (get api2python::api_infoRequest :md5sum-) "2e0aa5b6b51d31843d46fc8ed1324a8c")
(setf (get api2python::api_infoRequest :datatype-) "api2python/api_infoRequest")
(setf (get api2python::api_infoRequest :definition-)
      "geometry_msgs/PoseStamped robot_pose
geometry_msgs/Twist robot_vel
nav_msgs/Path reference_path
nav_msgs/OccupancyGrid map      #地图

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

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

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: nav_msgs/OccupancyGrid
# This represents a 2-D grid map, in which each cell represents the probability of
# occupancy.

Header header 

#MetaData for the map
MapMetaData info

# The map data, in row-major order, starting with (0,0).  Occupancy
# probabilities are in the range [0,100].  Unknown is -1.
int8[] data

================================================================================
MSG: nav_msgs/MapMetaData
# This hold basic information about the characterists of the OccupancyGrid

# The time at which the map was loaded
time map_load_time
# The map resolution [m/cell]
float32 resolution
# Map width [cells]
uint32 width
# Map height [cells]
uint32 height
# The origin of the map [m, m, rad].  This is the real-world pose of the
# cell (0,0) in the map.
---
geometry_msgs/Twist cmd

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")

(setf (get api2python::api_infoResponse :md5sum-) "2e0aa5b6b51d31843d46fc8ed1324a8c")
(setf (get api2python::api_infoResponse :datatype-) "api2python/api_infoResponse")
(setf (get api2python::api_infoResponse :definition-)
      "geometry_msgs/PoseStamped robot_pose
geometry_msgs/Twist robot_vel
nav_msgs/Path reference_path
nav_msgs/OccupancyGrid map      #地图

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

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

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: nav_msgs/OccupancyGrid
# This represents a 2-D grid map, in which each cell represents the probability of
# occupancy.

Header header 

#MetaData for the map
MapMetaData info

# The map data, in row-major order, starting with (0,0).  Occupancy
# probabilities are in the range [0,100].  Unknown is -1.
int8[] data

================================================================================
MSG: nav_msgs/MapMetaData
# This hold basic information about the characterists of the OccupancyGrid

# The time at which the map was loaded
time map_load_time
# The map resolution [m/cell]
float32 resolution
# Map width [cells]
uint32 width
# Map height [cells]
uint32 height
# The origin of the map [m, m, rad].  This is the real-world pose of the
# cell (0,0) in the map.
---
geometry_msgs/Twist cmd

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")



(provide :api2python/api_info "2e0aa5b6b51d31843d46fc8ed1324a8c")


