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

class SaveMappingRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.save_signal = null;
      this.save_path = null;
    }
    else {
      if (initObj.hasOwnProperty('save_signal')) {
        this.save_signal = initObj.save_signal
      }
      else {
        this.save_signal = '';
      }
      if (initObj.hasOwnProperty('save_path')) {
        this.save_path = initObj.save_path
      }
      else {
        this.save_path = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SaveMappingRequest
    // Serialize message field [save_signal]
    bufferOffset = _serializer.string(obj.save_signal, buffer, bufferOffset);
    // Serialize message field [save_path]
    bufferOffset = _serializer.string(obj.save_path, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SaveMappingRequest
    let len;
    let data = new SaveMappingRequest(null);
    // Deserialize message field [save_signal]
    data.save_signal = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [save_path]
    data.save_path = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.save_signal.length;
    length += object.save_path.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/SaveMappingRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a93006a36ccce7a0204e14031f918ad0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string save_signal
    string save_path
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SaveMappingRequest(null);
    if (msg.save_signal !== undefined) {
      resolved.save_signal = msg.save_signal;
    }
    else {
      resolved.save_signal = ''
    }

    if (msg.save_path !== undefined) {
      resolved.save_path = msg.save_path;
    }
    else {
      resolved.save_path = ''
    }

    return resolved;
    }
};

class SaveMappingResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success_flag = null;
    }
    else {
      if (initObj.hasOwnProperty('success_flag')) {
        this.success_flag = initObj.success_flag
      }
      else {
        this.success_flag = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SaveMappingResponse
    // Serialize message field [success_flag]
    bufferOffset = _serializer.int64(obj.success_flag, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SaveMappingResponse
    let len;
    let data = new SaveMappingResponse(null);
    // Deserialize message field [success_flag]
    data.success_flag = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/SaveMappingResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7ecda9a0a03e2798b5a7d47d1b1b5b52';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 success_flag
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SaveMappingResponse(null);
    if (msg.success_flag !== undefined) {
      resolved.success_flag = msg.success_flag;
    }
    else {
      resolved.success_flag = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: SaveMappingRequest,
  Response: SaveMappingResponse,
  md5sum() { return '5fe2de99ca88e365b15343be61af7c60'; },
  datatype() { return 'sineva_nav/SaveMapping'; }
};
