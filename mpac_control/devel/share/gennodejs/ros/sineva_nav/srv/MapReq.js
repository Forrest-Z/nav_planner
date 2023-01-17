// Auto-generated. Do not edit!

// (in-package sineva_nav.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let nav_msgs = _finder('nav_msgs');

//-----------------------------------------------------------

class MapReqRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mapRequest = null;
    }
    else {
      if (initObj.hasOwnProperty('mapRequest')) {
        this.mapRequest = initObj.mapRequest
      }
      else {
        this.mapRequest = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MapReqRequest
    // Serialize message field [mapRequest]
    bufferOffset = _serializer.string(obj.mapRequest, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MapReqRequest
    let len;
    let data = new MapReqRequest(null);
    // Deserialize message field [mapRequest]
    data.mapRequest = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mapRequest.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/MapReqRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6158b9b0d6c0c82988875539b3e891d7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string mapRequest
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MapReqRequest(null);
    if (msg.mapRequest !== undefined) {
      resolved.mapRequest = msg.mapRequest;
    }
    else {
      resolved.mapRequest = ''
    }

    return resolved;
    }
};

class MapReqResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
      this.mapDate = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
      if (initObj.hasOwnProperty('mapDate')) {
        this.mapDate = initObj.mapDate
      }
      else {
        this.mapDate = new nav_msgs.msg.OccupancyGrid();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MapReqResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int8(obj.result, buffer, bufferOffset);
    // Serialize message field [mapDate]
    bufferOffset = nav_msgs.msg.OccupancyGrid.serialize(obj.mapDate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MapReqResponse
    let len;
    let data = new MapReqResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [mapDate]
    data.mapDate = nav_msgs.msg.OccupancyGrid.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += nav_msgs.msg.OccupancyGrid.getMessageSize(object.mapDate);
    return length + 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/MapReqResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c40562aaa5646f0846f03a6ba0b2632';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 result
    nav_msgs/OccupancyGrid mapDate
    
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MapReqResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    if (msg.mapDate !== undefined) {
      resolved.mapDate = nav_msgs.msg.OccupancyGrid.Resolve(msg.mapDate)
    }
    else {
      resolved.mapDate = new nav_msgs.msg.OccupancyGrid()
    }

    return resolved;
    }
};

module.exports = {
  Request: MapReqRequest,
  Response: MapReqResponse,
  md5sum() { return 'f620cddd1adb52c04caee6100b1f237e'; },
  datatype() { return 'sineva_nav/MapReq'; }
};
