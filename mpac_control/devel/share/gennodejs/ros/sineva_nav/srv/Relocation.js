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

let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class RelocationRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mapId = null;
      this.flag = null;
    }
    else {
      if (initObj.hasOwnProperty('mapId')) {
        this.mapId = initObj.mapId
      }
      else {
        this.mapId = '';
      }
      if (initObj.hasOwnProperty('flag')) {
        this.flag = initObj.flag
      }
      else {
        this.flag = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RelocationRequest
    // Serialize message field [mapId]
    bufferOffset = _serializer.string(obj.mapId, buffer, bufferOffset);
    // Serialize message field [flag]
    bufferOffset = _serializer.string(obj.flag, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RelocationRequest
    let len;
    let data = new RelocationRequest(null);
    // Deserialize message field [mapId]
    data.mapId = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [flag]
    data.flag = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mapId.length;
    length += object.flag.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/RelocationRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c80659962eba898744da014535f5748';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string mapId
    string flag
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RelocationRequest(null);
    if (msg.mapId !== undefined) {
      resolved.mapId = msg.mapId;
    }
    else {
      resolved.mapId = ''
    }

    if (msg.flag !== undefined) {
      resolved.flag = msg.flag;
    }
    else {
      resolved.flag = ''
    }

    return resolved;
    }
};

class RelocationResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
      this.mapId = null;
      this.pose = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
      if (initObj.hasOwnProperty('mapId')) {
        this.mapId = initObj.mapId
      }
      else {
        this.mapId = '';
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RelocationResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int8(obj.result, buffer, bufferOffset);
    // Serialize message field [mapId]
    bufferOffset = _serializer.string(obj.mapId, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RelocationResponse
    let len;
    let data = new RelocationResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [mapId]
    data.mapId = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mapId.length;
    return length + 61;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/RelocationResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1c544797e03610f92847643a36b0148d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 result
    string mapId
    geometry_msgs/Pose pose
    
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
    const resolved = new RelocationResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    if (msg.mapId !== undefined) {
      resolved.mapId = msg.mapId;
    }
    else {
      resolved.mapId = ''
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    return resolved;
    }
};

module.exports = {
  Request: RelocationRequest,
  Response: RelocationResponse,
  md5sum() { return '82f1b53ec405d751bfebc95a42bfd76d'; },
  datatype() { return 'sineva_nav/Relocation'; }
};
