; Auto-generated. Do not edit!


(cl:in-package api2python-srv)


;//! \htmlinclude api_info-request.msg.html

(cl:defclass <api_info-request> (roslisp-msg-protocol:ros-message)
  ((robot_pose
    :reader robot_pose
    :initarg :robot_pose
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped))
   (robot_vel
    :reader robot_vel
    :initarg :robot_vel
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (reference_path
    :reader reference_path
    :initarg :reference_path
    :type nav_msgs-msg:Path
    :initform (cl:make-instance 'nav_msgs-msg:Path))
   (map
    :reader map
    :initarg :map
    :type nav_msgs-msg:OccupancyGrid
    :initform (cl:make-instance 'nav_msgs-msg:OccupancyGrid)))
)

(cl:defclass api_info-request (<api_info-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <api_info-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'api_info-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name api2python-srv:<api_info-request> is deprecated: use api2python-srv:api_info-request instead.")))

(cl:ensure-generic-function 'robot_pose-val :lambda-list '(m))
(cl:defmethod robot_pose-val ((m <api_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader api2python-srv:robot_pose-val is deprecated.  Use api2python-srv:robot_pose instead.")
  (robot_pose m))

(cl:ensure-generic-function 'robot_vel-val :lambda-list '(m))
(cl:defmethod robot_vel-val ((m <api_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader api2python-srv:robot_vel-val is deprecated.  Use api2python-srv:robot_vel instead.")
  (robot_vel m))

(cl:ensure-generic-function 'reference_path-val :lambda-list '(m))
(cl:defmethod reference_path-val ((m <api_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader api2python-srv:reference_path-val is deprecated.  Use api2python-srv:reference_path instead.")
  (reference_path m))

(cl:ensure-generic-function 'map-val :lambda-list '(m))
(cl:defmethod map-val ((m <api_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader api2python-srv:map-val is deprecated.  Use api2python-srv:map instead.")
  (map m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <api_info-request>) ostream)
  "Serializes a message object of type '<api_info-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'robot_pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'robot_vel) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'reference_path) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'map) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <api_info-request>) istream)
  "Deserializes a message object of type '<api_info-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'robot_pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'robot_vel) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'reference_path) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'map) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<api_info-request>)))
  "Returns string type for a service object of type '<api_info-request>"
  "api2python/api_infoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'api_info-request)))
  "Returns string type for a service object of type 'api_info-request"
  "api2python/api_infoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<api_info-request>)))
  "Returns md5sum for a message object of type '<api_info-request>"
  "2e0aa5b6b51d31843d46fc8ed1324a8c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'api_info-request)))
  "Returns md5sum for a message object of type 'api_info-request"
  "2e0aa5b6b51d31843d46fc8ed1324a8c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<api_info-request>)))
  "Returns full string definition for message of type '<api_info-request>"
  (cl:format cl:nil "geometry_msgs/PoseStamped robot_pose~%geometry_msgs/Twist robot_vel~%nav_msgs/Path reference_path~%nav_msgs/OccupancyGrid map      #地图~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'api_info-request)))
  "Returns full string definition for message of type 'api_info-request"
  (cl:format cl:nil "geometry_msgs/PoseStamped robot_pose~%geometry_msgs/Twist robot_vel~%nav_msgs/Path reference_path~%nav_msgs/OccupancyGrid map      #地图~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: nav_msgs/OccupancyGrid~%# This represents a 2-D grid map, in which each cell represents the probability of~%# occupancy.~%~%Header header ~%~%#MetaData for the map~%MapMetaData info~%~%# The map data, in row-major order, starting with (0,0).  Occupancy~%# probabilities are in the range [0,100].  Unknown is -1.~%int8[] data~%~%================================================================================~%MSG: nav_msgs/MapMetaData~%# This hold basic information about the characterists of the OccupancyGrid~%~%# The time at which the map was loaded~%time map_load_time~%# The map resolution [m/cell]~%float32 resolution~%# Map width [cells]~%uint32 width~%# Map height [cells]~%uint32 height~%# The origin of the map [m, m, rad].  This is the real-world pose of the~%# cell (0,0) in the map.~%geometry_msgs/Pose origin~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <api_info-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'robot_pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'robot_vel))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'reference_path))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'map))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <api_info-request>))
  "Converts a ROS message object to a list"
  (cl:list 'api_info-request
    (cl:cons ':robot_pose (robot_pose msg))
    (cl:cons ':robot_vel (robot_vel msg))
    (cl:cons ':reference_path (reference_path msg))
    (cl:cons ':map (map msg))
))
;//! \htmlinclude api_info-response.msg.html

(cl:defclass <api_info-response> (roslisp-msg-protocol:ros-message)
  ((cmd
    :reader cmd
    :initarg :cmd
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist)))
)

(cl:defclass api_info-response (<api_info-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <api_info-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'api_info-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name api2python-srv:<api_info-response> is deprecated: use api2python-srv:api_info-response instead.")))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <api_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader api2python-srv:cmd-val is deprecated.  Use api2python-srv:cmd instead.")
  (cmd m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <api_info-response>) ostream)
  "Serializes a message object of type '<api_info-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cmd) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <api_info-response>) istream)
  "Deserializes a message object of type '<api_info-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cmd) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<api_info-response>)))
  "Returns string type for a service object of type '<api_info-response>"
  "api2python/api_infoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'api_info-response)))
  "Returns string type for a service object of type 'api_info-response"
  "api2python/api_infoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<api_info-response>)))
  "Returns md5sum for a message object of type '<api_info-response>"
  "2e0aa5b6b51d31843d46fc8ed1324a8c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'api_info-response)))
  "Returns md5sum for a message object of type 'api_info-response"
  "2e0aa5b6b51d31843d46fc8ed1324a8c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<api_info-response>)))
  "Returns full string definition for message of type '<api_info-response>"
  (cl:format cl:nil "geometry_msgs/Twist cmd~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'api_info-response)))
  "Returns full string definition for message of type 'api_info-response"
  (cl:format cl:nil "geometry_msgs/Twist cmd~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <api_info-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cmd))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <api_info-response>))
  "Converts a ROS message object to a list"
  (cl:list 'api_info-response
    (cl:cons ':cmd (cmd msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'api_info)))
  'api_info-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'api_info)))
  'api_info-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'api_info)))
  "Returns string type for a service object of type '<api_info>"
  "api2python/api_info")