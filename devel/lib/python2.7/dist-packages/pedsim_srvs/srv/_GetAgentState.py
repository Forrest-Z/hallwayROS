# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from pedsim_srvs/GetAgentStateRequest.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class GetAgentStateRequest(genpy.Message):
  _md5sum = "0c54969886c310134f80d7787e2397f3"
  _type = "pedsim_srvs/GetAgentStateRequest"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """int16 agent_id
"""
  __slots__ = ['agent_id']
  _slot_types = ['int16']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       agent_id

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(GetAgentStateRequest, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.agent_id is None:
        self.agent_id = 0
    else:
      self.agent_id = 0

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.agent_id
      buff.write(_get_struct_h().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 2
      (self.agent_id,) = _get_struct_h().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.agent_id
      buff.write(_get_struct_h().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 2
      (self.agent_id,) = _get_struct_h().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_h = None
def _get_struct_h():
    global _struct_h
    if _struct_h is None:
        _struct_h = struct.Struct("<h")
    return _struct_h
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from pedsim_srvs/GetAgentStateResponse.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import geometry_msgs.msg
import pedsim_msgs.msg
import std_msgs.msg

class GetAgentStateResponse(genpy.Message):
  _md5sum = "b3e40c6ab2052e0c1b449d6d78af2454"
  _type = "pedsim_srvs/GetAgentStateResponse"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """pedsim_msgs/AgentState state

================================================================================
MSG: pedsim_msgs/AgentState
Header header
uint64 id
uint16 type
string social_state
geometry_msgs/Pose pose
geometry_msgs/Twist twist
pedsim_msgs/AgentForce forces

# Use sensors package to control observability

# Social State string constants
string      TYPE_STANDING = "standing"
string      TYPE_INDIVIDUAL_MOVING = "individual_moving"
string      TYPE_WAITING_IN_QUEUE = "waiting_in_queue"
string      TYPE_GROUP_MOVING = "group_moving"


# Agent types
# 0, 1 -> ordinary agents
# 2 -> Robot
# 3 -> standing/elderly agents

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
MSG: pedsim_msgs/AgentForce
# Forces acting on an agent.

# Basic SFM forces.
geometry_msgs/Vector3 desired_force
geometry_msgs/Vector3 obstacle_force
geometry_msgs/Vector3 social_force

# Additional Group Forces
geometry_msgs/Vector3 group_coherence_force
geometry_msgs/Vector3 group_gaze_force
geometry_msgs/Vector3 group_repulsion_force

# Extra stabilization/custom forces.
geometry_msgs/Vector3 random_force
"""
  __slots__ = ['state']
  _slot_types = ['pedsim_msgs/AgentState']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       state

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(GetAgentStateResponse, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.state is None:
        self.state = pedsim_msgs.msg.AgentState()
    else:
      self.state = pedsim_msgs.msg.AgentState()

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.state.header.seq, _x.state.header.stamp.secs, _x.state.header.stamp.nsecs))
      _x = self.state.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_QH().pack(_x.state.id, _x.state.type))
      _x = self.state.social_state
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_34d().pack(_x.state.pose.position.x, _x.state.pose.position.y, _x.state.pose.position.z, _x.state.pose.orientation.x, _x.state.pose.orientation.y, _x.state.pose.orientation.z, _x.state.pose.orientation.w, _x.state.twist.linear.x, _x.state.twist.linear.y, _x.state.twist.linear.z, _x.state.twist.angular.x, _x.state.twist.angular.y, _x.state.twist.angular.z, _x.state.forces.desired_force.x, _x.state.forces.desired_force.y, _x.state.forces.desired_force.z, _x.state.forces.obstacle_force.x, _x.state.forces.obstacle_force.y, _x.state.forces.obstacle_force.z, _x.state.forces.social_force.x, _x.state.forces.social_force.y, _x.state.forces.social_force.z, _x.state.forces.group_coherence_force.x, _x.state.forces.group_coherence_force.y, _x.state.forces.group_coherence_force.z, _x.state.forces.group_gaze_force.x, _x.state.forces.group_gaze_force.y, _x.state.forces.group_gaze_force.z, _x.state.forces.group_repulsion_force.x, _x.state.forces.group_repulsion_force.y, _x.state.forces.group_repulsion_force.z, _x.state.forces.random_force.x, _x.state.forces.random_force.y, _x.state.forces.random_force.z))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.state is None:
        self.state = pedsim_msgs.msg.AgentState()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.state.header.seq, _x.state.header.stamp.secs, _x.state.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.state.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.state.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 10
      (_x.state.id, _x.state.type,) = _get_struct_QH().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.state.social_state = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.state.social_state = str[start:end]
      _x = self
      start = end
      end += 272
      (_x.state.pose.position.x, _x.state.pose.position.y, _x.state.pose.position.z, _x.state.pose.orientation.x, _x.state.pose.orientation.y, _x.state.pose.orientation.z, _x.state.pose.orientation.w, _x.state.twist.linear.x, _x.state.twist.linear.y, _x.state.twist.linear.z, _x.state.twist.angular.x, _x.state.twist.angular.y, _x.state.twist.angular.z, _x.state.forces.desired_force.x, _x.state.forces.desired_force.y, _x.state.forces.desired_force.z, _x.state.forces.obstacle_force.x, _x.state.forces.obstacle_force.y, _x.state.forces.obstacle_force.z, _x.state.forces.social_force.x, _x.state.forces.social_force.y, _x.state.forces.social_force.z, _x.state.forces.group_coherence_force.x, _x.state.forces.group_coherence_force.y, _x.state.forces.group_coherence_force.z, _x.state.forces.group_gaze_force.x, _x.state.forces.group_gaze_force.y, _x.state.forces.group_gaze_force.z, _x.state.forces.group_repulsion_force.x, _x.state.forces.group_repulsion_force.y, _x.state.forces.group_repulsion_force.z, _x.state.forces.random_force.x, _x.state.forces.random_force.y, _x.state.forces.random_force.z,) = _get_struct_34d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.state.header.seq, _x.state.header.stamp.secs, _x.state.header.stamp.nsecs))
      _x = self.state.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_QH().pack(_x.state.id, _x.state.type))
      _x = self.state.social_state
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_34d().pack(_x.state.pose.position.x, _x.state.pose.position.y, _x.state.pose.position.z, _x.state.pose.orientation.x, _x.state.pose.orientation.y, _x.state.pose.orientation.z, _x.state.pose.orientation.w, _x.state.twist.linear.x, _x.state.twist.linear.y, _x.state.twist.linear.z, _x.state.twist.angular.x, _x.state.twist.angular.y, _x.state.twist.angular.z, _x.state.forces.desired_force.x, _x.state.forces.desired_force.y, _x.state.forces.desired_force.z, _x.state.forces.obstacle_force.x, _x.state.forces.obstacle_force.y, _x.state.forces.obstacle_force.z, _x.state.forces.social_force.x, _x.state.forces.social_force.y, _x.state.forces.social_force.z, _x.state.forces.group_coherence_force.x, _x.state.forces.group_coherence_force.y, _x.state.forces.group_coherence_force.z, _x.state.forces.group_gaze_force.x, _x.state.forces.group_gaze_force.y, _x.state.forces.group_gaze_force.z, _x.state.forces.group_repulsion_force.x, _x.state.forces.group_repulsion_force.y, _x.state.forces.group_repulsion_force.z, _x.state.forces.random_force.x, _x.state.forces.random_force.y, _x.state.forces.random_force.z))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.state is None:
        self.state = pedsim_msgs.msg.AgentState()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.state.header.seq, _x.state.header.stamp.secs, _x.state.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.state.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.state.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 10
      (_x.state.id, _x.state.type,) = _get_struct_QH().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.state.social_state = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.state.social_state = str[start:end]
      _x = self
      start = end
      end += 272
      (_x.state.pose.position.x, _x.state.pose.position.y, _x.state.pose.position.z, _x.state.pose.orientation.x, _x.state.pose.orientation.y, _x.state.pose.orientation.z, _x.state.pose.orientation.w, _x.state.twist.linear.x, _x.state.twist.linear.y, _x.state.twist.linear.z, _x.state.twist.angular.x, _x.state.twist.angular.y, _x.state.twist.angular.z, _x.state.forces.desired_force.x, _x.state.forces.desired_force.y, _x.state.forces.desired_force.z, _x.state.forces.obstacle_force.x, _x.state.forces.obstacle_force.y, _x.state.forces.obstacle_force.z, _x.state.forces.social_force.x, _x.state.forces.social_force.y, _x.state.forces.social_force.z, _x.state.forces.group_coherence_force.x, _x.state.forces.group_coherence_force.y, _x.state.forces.group_coherence_force.z, _x.state.forces.group_gaze_force.x, _x.state.forces.group_gaze_force.y, _x.state.forces.group_gaze_force.z, _x.state.forces.group_repulsion_force.x, _x.state.forces.group_repulsion_force.y, _x.state.forces.group_repulsion_force.z, _x.state.forces.random_force.x, _x.state.forces.random_force.y, _x.state.forces.random_force.z,) = _get_struct_34d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_34d = None
def _get_struct_34d():
    global _struct_34d
    if _struct_34d is None:
        _struct_34d = struct.Struct("<34d")
    return _struct_34d
_struct_3I = None
def _get_struct_3I():
    global _struct_3I
    if _struct_3I is None:
        _struct_3I = struct.Struct("<3I")
    return _struct_3I
_struct_QH = None
def _get_struct_QH():
    global _struct_QH
    if _struct_QH is None:
        _struct_QH = struct.Struct("<QH")
    return _struct_QH
class GetAgentState(object):
  _type          = 'pedsim_srvs/GetAgentState'
  _md5sum = '506aed4cf0fa361a55600b1ac6b1f978'
  _request_class  = GetAgentStateRequest
  _response_class = GetAgentStateResponse