// Generated by gencpp from file pedsim_srvs/GetAllAgentsStateRequest.msg
// DO NOT EDIT!


#ifndef PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATEREQUEST_H
#define PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATEREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace pedsim_srvs
{
template <class ContainerAllocator>
struct GetAllAgentsStateRequest_
{
  typedef GetAllAgentsStateRequest_<ContainerAllocator> Type;

  GetAllAgentsStateRequest_()
    : agent_ids()  {
    }
  GetAllAgentsStateRequest_(const ContainerAllocator& _alloc)
    : agent_ids(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<int16_t, typename ContainerAllocator::template rebind<int16_t>::other >  _agent_ids_type;
  _agent_ids_type agent_ids;





  typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> const> ConstPtr;

}; // struct GetAllAgentsStateRequest_

typedef ::pedsim_srvs::GetAllAgentsStateRequest_<std::allocator<void> > GetAllAgentsStateRequest;

typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateRequest > GetAllAgentsStateRequestPtr;
typedef boost::shared_ptr< ::pedsim_srvs::GetAllAgentsStateRequest const> GetAllAgentsStateRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator1> & lhs, const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator2> & rhs)
{
  return lhs.agent_ids == rhs.agent_ids;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator1> & lhs, const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace pedsim_srvs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "6ae2c87e95de54a27053702cd22ee2c9";
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x6ae2c87e95de54a2ULL;
  static const uint64_t static_value2 = 0x7053702cd22ee2c9ULL;
};

template<class ContainerAllocator>
struct DataType< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "pedsim_srvs/GetAllAgentsStateRequest";
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int16[] agent_ids\n"
;
  }

  static const char* value(const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.agent_ids);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GetAllAgentsStateRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::pedsim_srvs::GetAllAgentsStateRequest_<ContainerAllocator>& v)
  {
    s << indent << "agent_ids[]" << std::endl;
    for (size_t i = 0; i < v.agent_ids.size(); ++i)
    {
      s << indent << "  agent_ids[" << i << "]: ";
      Printer<int16_t>::stream(s, indent + "  ", v.agent_ids[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // PEDSIM_SRVS_MESSAGE_GETALLAGENTSSTATEREQUEST_H
