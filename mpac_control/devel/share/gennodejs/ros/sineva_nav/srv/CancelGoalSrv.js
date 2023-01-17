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


//-----------------------------------------------------------

class CancelGoalSrvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.goal_id = null;
    }
    else {
      if (initObj.hasOwnProperty('goal_id')) {
        this.goal_id = initObj.goal_id
      }
      else {
        this.goal_id = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CancelGoalSrvRequest
    // Serialize message field [goal_id]
    bufferOffset = _serializer.string(obj.goal_id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CancelGoalSrvRequest
    let len;
    let data = new CancelGoalSrvRequest(null);
    // Deserialize message field [goal_id]
    data.goal_id = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.goal_id.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/CancelGoalSrvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1390c9c033b60649917fd23f66f91703';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # request message
    string goal_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CancelGoalSrvRequest(null);
    if (msg.goal_id !== undefined) {
      resolved.goal_id = msg.goal_id;
    }
    else {
      resolved.goal_id = ''
    }

    return resolved;
    }
};

class CancelGoalSrvResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CancelGoalSrvResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int32(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CancelGoalSrvResponse
    let len;
    let data = new CancelGoalSrvResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/CancelGoalSrvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '034a8e20d6a306665e3a5b340fab3f09';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # response message
    int32 result
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CancelGoalSrvResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: CancelGoalSrvRequest,
  Response: CancelGoalSrvResponse,
  md5sum() { return '69b4ce7997dd89357a2ebdc1827d4b0d'; },
  datatype() { return 'sineva_nav/CancelGoalSrv'; }
};
