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

class MoveStatusRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.moveStatus = null;
      this.info = null;
    }
    else {
      if (initObj.hasOwnProperty('moveStatus')) {
        this.moveStatus = initObj.moveStatus
      }
      else {
        this.moveStatus = 0;
      }
      if (initObj.hasOwnProperty('info')) {
        this.info = initObj.info
      }
      else {
        this.info = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MoveStatusRequest
    // Serialize message field [moveStatus]
    bufferOffset = _serializer.int32(obj.moveStatus, buffer, bufferOffset);
    // Serialize message field [info]
    bufferOffset = _serializer.string(obj.info, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveStatusRequest
    let len;
    let data = new MoveStatusRequest(null);
    // Deserialize message field [moveStatus]
    data.moveStatus = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [info]
    data.info = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.info.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/MoveStatusRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '87093d7d38674a4ba71454924641f57f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # request message
    int32 moveStatus
    string info
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveStatusRequest(null);
    if (msg.moveStatus !== undefined) {
      resolved.moveStatus = msg.moveStatus;
    }
    else {
      resolved.moveStatus = 0
    }

    if (msg.info !== undefined) {
      resolved.info = msg.info;
    }
    else {
      resolved.info = ''
    }

    return resolved;
    }
};

class MoveStatusResponse {
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
    // Serializes a message object of type MoveStatusResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int8(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MoveStatusResponse
    let len;
    let data = new MoveStatusResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/MoveStatusResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4414c67819626a1b8e0f043a9a0d6c9a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # response message
    int8 result
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MoveStatusResponse(null);
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
  Request: MoveStatusRequest,
  Response: MoveStatusResponse,
  md5sum() { return 'f6729728149600a4ea80caa7ab1e5015'; },
  datatype() { return 'sineva_nav/MoveStatus'; }
};
