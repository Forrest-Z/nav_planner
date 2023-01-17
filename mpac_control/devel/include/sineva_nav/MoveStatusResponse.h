// Generated by gencpp from file sineva_nav/MoveStatusResponse.msg
// DO NOT EDIT!


#ifndef SINEVA_NAV_MESSAGE_MOVESTATUSRESPONSE_H
#define SINEVA_NAV_MESSAGE_MOVESTATUSRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace sineva_nav
{
template <class ContainerAllocator>
struct MoveStatusResponse_
{
  typedef MoveStatusResponse_<ContainerAllocator> Type;

  MoveStatusResponse_()
    : result(0)  {
    }
  MoveStatusResponse_(const ContainerAllocator& _alloc)
    : result(0)  {
  (void)_alloc;
    }



   typedef int8_t _result_type;
  _result_type result;





  typedef boost::shared_ptr< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> const> ConstPtr;

}; // struct MoveStatusResponse_

typedef ::sineva_nav::MoveStatusResponse_<std::allocator<void> > MoveStatusResponse;

typedef boost::shared_ptr< ::sineva_nav::MoveStatusResponse > MoveStatusResponsePtr;
typedef boost::shared_ptr< ::sineva_nav::MoveStatusResponse const> MoveStatusResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::sineva_nav::MoveStatusResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::sineva_nav::MoveStatusResponse_<ContainerAllocator1> & lhs, const ::sineva_nav::MoveStatusResponse_<ContainerAllocator2> & rhs)
{
  return lhs.result == rhs.result;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::sineva_nav::MoveStatusResponse_<ContainerAllocator1> & lhs, const ::sineva_nav::MoveStatusResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace sineva_nav

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4414c67819626a1b8e0f043a9a0d6c9a";
  }

  static const char* value(const ::sineva_nav::MoveStatusResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4414c67819626a1bULL;
  static const uint64_t static_value2 = 0x8e0f043a9a0d6c9aULL;
};

template<class ContainerAllocator>
struct DataType< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "sineva_nav/MoveStatusResponse";
  }

  static const char* value(const ::sineva_nav::MoveStatusResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# response message\n"
"int8 result\n"
"\n"
;
  }

  static const char* value(const ::sineva_nav::MoveStatusResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct MoveStatusResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::sineva_nav::MoveStatusResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::sineva_nav::MoveStatusResponse_<ContainerAllocator>& v)
  {
    s << indent << "result: ";
    Printer<int8_t>::stream(s, indent + "  ", v.result);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SINEVA_NAV_MESSAGE_MOVESTATUSRESPONSE_H