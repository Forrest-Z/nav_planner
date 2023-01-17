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

class JsonSrvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.flag = null;
      this.dataReq = null;
    }
    else {
      if (initObj.hasOwnProperty('flag')) {
        this.flag = initObj.flag
      }
      else {
        this.flag = '';
      }
      if (initObj.hasOwnProperty('dataReq')) {
        this.dataReq = initObj.dataReq
      }
      else {
        this.dataReq = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JsonSrvRequest
    // Serialize message field [flag]
    bufferOffset = _serializer.string(obj.flag, buffer, bufferOffset);
    // Serialize message field [dataReq]
    bufferOffset = _serializer.string(obj.dataReq, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JsonSrvRequest
    let len;
    let data = new JsonSrvRequest(null);
    // Deserialize message field [flag]
    data.flag = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [dataReq]
    data.dataReq = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.flag.length;
    length += object.dataReq.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/JsonSrvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f2174a0798a1a98bacdaf158498c5491';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # request message
    string flag
    string dataReq
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JsonSrvRequest(null);
    if (msg.flag !== undefined) {
      resolved.flag = msg.flag;
    }
    else {
      resolved.flag = ''
    }

    if (msg.dataReq !== undefined) {
      resolved.dataReq = msg.dataReq;
    }
    else {
      resolved.dataReq = ''
    }

    return resolved;
    }
};

class JsonSrvResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
      this.dataRes = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
      if (initObj.hasOwnProperty('dataRes')) {
        this.dataRes = initObj.dataRes
      }
      else {
        this.dataRes = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JsonSrvResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int32(obj.result, buffer, bufferOffset);
    // Serialize message field [dataRes]
    bufferOffset = _serializer.string(obj.dataRes, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JsonSrvResponse
    let len;
    let data = new JsonSrvResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [dataRes]
    data.dataRes = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.dataRes.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sineva_nav/JsonSrvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e569e7fbed8aa082ed65e56493a1cb29';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # response message
    int32 result
    string dataRes
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JsonSrvResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    if (msg.dataRes !== undefined) {
      resolved.dataRes = msg.dataRes;
    }
    else {
      resolved.dataRes = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: JsonSrvRequest,
  Response: JsonSrvResponse,
  md5sum() { return 'd8d0627554acfa5cf898bc2c61190e8e'; },
  datatype() { return 'sineva_nav/JsonSrv'; }
};
