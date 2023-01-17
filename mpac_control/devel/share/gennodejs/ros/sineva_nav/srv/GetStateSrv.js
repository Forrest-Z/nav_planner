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

class GetStateSrvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.state_id = null;
    }
    else {
      if (initObj.hasOwnProperty('state_id')) {
        this.state_id = initObj.state_id
      }
      else {
        this.state_id = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetStateSrvRequest
    // Serialize message field [state_id]
    bufferOffset = _serializer.string(obj.state_id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetStateSrvRequest
    let len;
    let data = new GetStateSrvRequest(null);
    // Deserialize message field [state_id]
    data.state_id = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.state_id.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/GetStateSrvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9cb8f8d3f4e2485d86cc83b3a2c1c80e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # request message
    string state_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetStateSrvRequest(null);
    if (msg.state_id !== undefined) {
      resolved.state_id = msg.state_id;
    }
    else {
      resolved.state_id = ''
    }

    return resolved;
    }
};

class GetStateSrvResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.goal_id = null;
      this.status_code = null;
    }
    else {
      if (initObj.hasOwnProperty('goal_id')) {
        this.goal_id = initObj.goal_id
      }
      else {
        this.goal_id = '';
      }
      if (initObj.hasOwnProperty('status_code')) {
        this.status_code = initObj.status_code
      }
      else {
        this.status_code = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetStateSrvResponse
    // Serialize message field [goal_id]
    bufferOffset = _serializer.string(obj.goal_id, buffer, bufferOffset);
    // Serialize message field [status_code]
    bufferOffset = _serializer.int32(obj.status_code, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetStateSrvResponse
    let len;
    let data = new GetStateSrvResponse(null);
    // Deserialize message field [goal_id]
    data.goal_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [status_code]
    data.status_code = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.goal_id.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/GetStateSrvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '20302303840f9550e869dd96dba66a06';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # response message
    string goal_id
    int32 status_code
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetStateSrvResponse(null);
    if (msg.goal_id !== undefined) {
      resolved.goal_id = msg.goal_id;
    }
    else {
      resolved.goal_id = ''
    }

    if (msg.status_code !== undefined) {
      resolved.status_code = msg.status_code;
    }
    else {
      resolved.status_code = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: GetStateSrvRequest,
  Response: GetStateSrvResponse,
  md5sum() { return '702496c6638c59bcef5d602cda36b30f'; },
  datatype() { return 'sineva_nav/GetStateSrv'; }
};
