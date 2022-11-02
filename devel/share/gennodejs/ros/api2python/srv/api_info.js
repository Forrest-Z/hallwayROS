// Auto-generated. Do not edit!

// (in-package api2python.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let nav_msgs = _finder('nav_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class api_infoRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.robot_pose = null;
      this.robot_vel = null;
      this.reference_path = null;
      this.map = null;
    }
    else {
      if (initObj.hasOwnProperty('robot_pose')) {
        this.robot_pose = initObj.robot_pose
      }
      else {
        this.robot_pose = new geometry_msgs.msg.PoseStamped();
      }
      if (initObj.hasOwnProperty('robot_vel')) {
        this.robot_vel = initObj.robot_vel
      }
      else {
        this.robot_vel = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('reference_path')) {
        this.reference_path = initObj.reference_path
      }
      else {
        this.reference_path = new nav_msgs.msg.Path();
      }
      if (initObj.hasOwnProperty('map')) {
        this.map = initObj.map
      }
      else {
        this.map = new nav_msgs.msg.OccupancyGrid();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type api_infoRequest
    // Serialize message field [robot_pose]
    bufferOffset = geometry_msgs.msg.PoseStamped.serialize(obj.robot_pose, buffer, bufferOffset);
    // Serialize message field [robot_vel]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.robot_vel, buffer, bufferOffset);
    // Serialize message field [reference_path]
    bufferOffset = nav_msgs.msg.Path.serialize(obj.reference_path, buffer, bufferOffset);
    // Serialize message field [map]
    bufferOffset = nav_msgs.msg.OccupancyGrid.serialize(obj.map, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type api_infoRequest
    let len;
    let data = new api_infoRequest(null);
    // Deserialize message field [robot_pose]
    data.robot_pose = geometry_msgs.msg.PoseStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [robot_vel]
    data.robot_vel = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [reference_path]
    data.reference_path = nav_msgs.msg.Path.deserialize(buffer, bufferOffset);
    // Deserialize message field [map]
    data.map = nav_msgs.msg.OccupancyGrid.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseStamped.getMessageSize(object.robot_pose);
    length += nav_msgs.msg.Path.getMessageSize(object.reference_path);
    length += nav_msgs.msg.OccupancyGrid.getMessageSize(object.map);
    return length + 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'api2python/api_infoRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '90cbf6a5fd1cabed47e3738002cf6e7d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/PoseStamped robot_pose
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
    geometry_msgs/Pose origin
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new api_infoRequest(null);
    if (msg.robot_pose !== undefined) {
      resolved.robot_pose = geometry_msgs.msg.PoseStamped.Resolve(msg.robot_pose)
    }
    else {
      resolved.robot_pose = new geometry_msgs.msg.PoseStamped()
    }

    if (msg.robot_vel !== undefined) {
      resolved.robot_vel = geometry_msgs.msg.Twist.Resolve(msg.robot_vel)
    }
    else {
      resolved.robot_vel = new geometry_msgs.msg.Twist()
    }

    if (msg.reference_path !== undefined) {
      resolved.reference_path = nav_msgs.msg.Path.Resolve(msg.reference_path)
    }
    else {
      resolved.reference_path = new nav_msgs.msg.Path()
    }

    if (msg.map !== undefined) {
      resolved.map = nav_msgs.msg.OccupancyGrid.Resolve(msg.map)
    }
    else {
      resolved.map = new nav_msgs.msg.OccupancyGrid()
    }

    return resolved;
    }
};

class api_infoResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.cmd = null;
    }
    else {
      if (initObj.hasOwnProperty('cmd')) {
        this.cmd = initObj.cmd
      }
      else {
        this.cmd = new geometry_msgs.msg.Twist();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type api_infoResponse
    // Serialize message field [cmd]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.cmd, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type api_infoResponse
    let len;
    let data = new api_infoResponse(null);
    // Deserialize message field [cmd]
    data.cmd = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'api2python/api_infoResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a0c47a2b42626c8e0bd2a277053c6c62';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new api_infoResponse(null);
    if (msg.cmd !== undefined) {
      resolved.cmd = geometry_msgs.msg.Twist.Resolve(msg.cmd)
    }
    else {
      resolved.cmd = new geometry_msgs.msg.Twist()
    }

    return resolved;
    }
};

module.exports = {
  Request: api_infoRequest,
  Response: api_infoResponse,
  md5sum() { return '2e0aa5b6b51d31843d46fc8ed1324a8c'; },
  datatype() { return 'api2python/api_info'; }
};
