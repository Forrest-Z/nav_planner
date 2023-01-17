// Generated by gencpp from file sineva_nav/SetPathSrv.msg
// DO NOT EDIT!


#ifndef SINEVA_NAV_MESSAGE_SETPATHSRV_H
#define SINEVA_NAV_MESSAGE_SETPATHSRV_H

#include <ros/service_traits.h>


#include <sineva_nav/SetPathSrvRequest.h>
#include <sineva_nav/SetPathSrvResponse.h>


namespace sineva_nav
{

struct SetPathSrv
{

typedef SetPathSrvRequest Request;
typedef SetPathSrvResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct SetPathSrv
} // namespace sineva_nav


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::sineva_nav::SetPathSrv > {
  static const char* value()
  {
    return "00b963a59692bf94c8192290a3afedc1";
  }

  static const char* value(const ::sineva_nav::SetPathSrv&) { return value(); }
};

template<>
struct DataType< ::sineva_nav::SetPathSrv > {
  static const char* value()
  {
    return "sineva_nav/SetPathSrv";
  }

  static const char* value(const ::sineva_nav::SetPathSrv&) { return value(); }
};


// service_traits::MD5Sum< ::sineva_nav::SetPathSrvRequest> should match 
// service_traits::MD5Sum< ::sineva_nav::SetPathSrv > 
template<>
struct MD5Sum< ::sineva_nav::SetPathSrvRequest>
{
  static const char* value()
  {
    return MD5Sum< ::sineva_nav::SetPathSrv >::value();
  }
  static const char* value(const ::sineva_nav::SetPathSrvRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::sineva_nav::SetPathSrvRequest> should match 
// service_traits::DataType< ::sineva_nav::SetPathSrv > 
template<>
struct DataType< ::sineva_nav::SetPathSrvRequest>
{
  static const char* value()
  {
    return DataType< ::sineva_nav::SetPathSrv >::value();
  }
  static const char* value(const ::sineva_nav::SetPathSrvRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::sineva_nav::SetPathSrvResponse> should match 
// service_traits::MD5Sum< ::sineva_nav::SetPathSrv > 
template<>
struct MD5Sum< ::sineva_nav::SetPathSrvResponse>
{
  static const char* value()
  {
    return MD5Sum< ::sineva_nav::SetPathSrv >::value();
  }
  static const char* value(const ::sineva_nav::SetPathSrvResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::sineva_nav::SetPathSrvResponse> should match 
// service_traits::DataType< ::sineva_nav::SetPathSrv > 
template<>
struct DataType< ::sineva_nav::SetPathSrvResponse>
{
  static const char* value()
  {
    return DataType< ::sineva_nav::SetPathSrv >::value();
  }
  static const char* value(const ::sineva_nav::SetPathSrvResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SINEVA_NAV_MESSAGE_SETPATHSRV_H