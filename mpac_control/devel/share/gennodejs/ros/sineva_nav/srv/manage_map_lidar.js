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

class manage_map_lidarRequest {
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
    // Serializes a message object of type manage_map_lidarRequest
    // Serialize message field [mapId]
    bufferOffset = _serializer.string(obj.mapId, buffer, bufferOffset);
    // Serialize message field [flag]
    bufferOffset = _serializer.string(obj.flag, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type manage_map_lidarRequest
    let len;
    let data = new manage_map_lidarRequest(null);
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
    return 'sineva_nav/manage_map_lidarRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c80659962eba898744da014535f5748';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Copyright 2016 The Cartographer Authors
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #      http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
    
    string mapId
    string flag
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new manage_map_lidarRequest(null);
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

class manage_map_lidarResponse {
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
        this.result = false;
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
    // Serializes a message object of type manage_map_lidarResponse
    // Serialize message field [result]
    bufferOffset = _serializer.bool(obj.result, buffer, bufferOffset);
    // Serialize message field [mapId]
    bufferOffset = _serializer.string(obj.mapId, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type manage_map_lidarResponse
    let len;
    let data = new manage_map_lidarResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.bool(buffer, bufferOffset);
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
    return 'sineva_nav/manage_map_lidarResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '29612251d79506cf4df2e11bbf13f61d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool result
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
    const resolved = new manage_map_lidarResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = false
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
  Request: manage_map_lidarRequest,
  Response: manage_map_lidarResponse,
  md5sum() { return 'af39c21a4fa890c80c400b940fd5dfea'; },
  datatype() { return 'sineva_nav/manage_map_lidar'; }
};
