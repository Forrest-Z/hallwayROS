// Generated by gencpp from file pedsim_srvs/GetAllAgentsStateResponse.msg
// DO NOT EDIT!


#ifndef PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATERESPONSE_H
#define PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATERESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <pedsim_msgs/AgentStates.h>

namespace pedsim_srvs
{
template <class ContainerAllocator>
struct GetAllAgentsStateResponse_
{
  typedef GetAllAgentsStateResponse_<ContainerAllocator> Type;

  GetAllAgentsStateResponse_()
    : agent_states()  {
    }
  GetAllAgentsStateResponse_(const ContainerAllocator& _alloc)
    : agent_states(_alloc)  {
  (void)_alloc;
    }



   typedef  ::pedsim_msgs::AgentStates_<ContainerAllocator>  _agent_states_type;
  _agent_states_type agent_states;





  typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> const> ConstPtr;

}; // struct GetAllAgentsStateResponse_

typedef ::pedsim_srvs::GetAllAgentsStateResponse_<std::allocator<void> > GetAllAgentsStateResponse;

typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateResponse > GetAllAgentsStateResponsePtr;
typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateResponse const> GetAllAgentsStateResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator1> & lhs, const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator2> & rhs)
{
  return lhs.agent_states == rhs.agent_states;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator1> & lhs, const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace pedsim_srvs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "24869d0a05b36ba71cbe2bf6556f2fc9";
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x24869d0a05b36ba7ULL;
  static const uint64_t static_value2 = 0x1cbe2bf6556f2fc9ULL;
};

template<class ContainerAllocator>
struct DataType< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "pedsim_srvs/GetAllAgentsStateResponse";
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "pedsim_msgs/AgentStates agent_states\n"
"\n"
"\n"
"================================================================================\n"
"MSG: pedsim_msgs/AgentStates\n"
"Header header\n"
"pedsim_msgs/AgentState[] agent_states\n"
"\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: pedsim_msgs/AgentState\n"
"Header header\n"
"uint64 id\n"
"uint16 type\n"
"string social_state\n"
"geometry_msgs/Pose pose\n"
"geometry_msgs/Twist twist\n"
"pedsim_msgs/AgentForce forces\n"
"\n"
"# Use sensors package to control observability\n"
"\n"
"# Social State string constants\n"
"string      TYPE_STANDING = \"standing\"\n"
"string      TYPE_INDIVIDUAL_MOVING = \"individual_moving\"\n"
"string      TYPE_WAITING_IN_QUEUE = \"waiting_in_queue\"\n"
"string      TYPE_GROUP_MOVING = \"group_moving\"\n"
"\n"
"\n"
"# Agent types\n"
"# 0, 1 -> ordinary agents\n"
"# 2 -> Robot\n"
"# 3 -> standing/elderly agents\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Pose\n"
"# A representation of pose in free space, composed of position and orientation. \n"
"Point position\n"
"Quaternion orientation\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Quaternion\n"
"# This represents an orientation in free space in quaternion form.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"float64 w\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Twist\n"
"# This expresses velocity in free space broken into its linear and angular parts.\n"
"Vector3  linear\n"
"Vector3  angular\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Vector3\n"
"# This represents a vector in free space. \n"
"# It is only meant to represent a direction. Therefore, it does not\n"
"# make sense to apply a translation to it (e.g., when applying a \n"
"# generic rigid transformation to a Vector3, tf2 will only apply the\n"
"# rotation). If you want your data to be translatable too, use the\n"
"# geometry_msgs/Point message instead.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"================================================================================\n"
"MSG: pedsim_msgs/AgentForce\n"
"# Forces acting on an agent.\n"
"\n"
"# Basic SFM forces.\n"
"geometry_msgs/Vector3 desired_force\n"
"geometry_msgs/Vector3 obstacle_force\n"
"geometry_msgs/Vector3 social_force\n"
"\n"
"# Additional Group Forces\n"
"geometry_msgs/Vector3 group_coherence_force\n"
"geometry_msgs/Vector3 group_gaze_force\n"
"geometry_msgs/Vector3 group_repulsion_force\n"
"\n"
"# Extra stabilization/custom forces.\n"
"geometry_msgs/Vector3 random_force\n"
;
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.agent_states);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GetAllAgentsStateResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::pedsim_srvs::GetAllAgentsStateResponse_<ContainerAllocator>& v)
  {
    s << indent << "agent_states: ";
    s << std::endl;
    Printer< ::pedsim_msgs::AgentStates_<ContainerAllocator> >::stream(s, indent + "  ", v.agent_states);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATERESPONSE_H
