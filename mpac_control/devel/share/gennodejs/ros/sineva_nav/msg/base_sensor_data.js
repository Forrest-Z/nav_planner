// Auto-generated. Do not edit!

// (in-package sineva_nav.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class base_sensor_data {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.power = null;
      this.iEncoder_l = null;
      this.iEncoder_r = null;
      this.iVoltage = null;
      this.iCurrent = null;
      this.quantity = null;
      this.batTemp = null;
      this.capicity = null;
      this.iLeftMotor = null;
      this.iRightMotor = null;
      this.iScram = null;
      this.iCrash = null;
      this.ioStatus = null;
      this.iCharge = null;
      this.iShutdown = null;
      this.iReset = null;
      this.iAuto = null;
      this.iLift = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('power')) {
        this.power = initObj.power
      }
      else {
        this.power = 0.0;
      }
      if (initObj.hasOwnProperty('iEncoder_l')) {
        this.iEncoder_l = initObj.iEncoder_l
      }
      else {
        this.iEncoder_l = 0;
      }
      if (initObj.hasOwnProperty('iEncoder_r')) {
        this.iEncoder_r = initObj.iEncoder_r
      }
      else {
        this.iEncoder_r = 0;
      }
      if (initObj.hasOwnProperty('iVoltage')) {
        this.iVoltage = initObj.iVoltage
      }
      else {
        this.iVoltage = 0;
      }
      if (initObj.hasOwnProperty('iCurrent')) {
        this.iCurrent = initObj.iCurrent
      }
      else {
        this.iCurrent = 0;
      }
      if (initObj.hasOwnProperty('quantity')) {
        this.quantity = initObj.quantity
      }
      else {
        this.quantity = 0;
      }
      if (initObj.hasOwnProperty('batTemp')) {
        this.batTemp = initObj.batTemp
      }
      else {
        this.batTemp = 0;
      }
      if (initObj.hasOwnProperty('capicity')) {
        this.capicity = initObj.capicity
      }
      else {
        this.capicity = 0;
      }
      if (initObj.hasOwnProperty('iLeftMotor')) {
        this.iLeftMotor = initObj.iLeftMotor
      }
      else {
        this.iLeftMotor = 0;
      }
      if (initObj.hasOwnProperty('iRightMotor')) {
        this.iRightMotor = initObj.iRightMotor
      }
      else {
        this.iRightMotor = 0;
      }
      if (initObj.hasOwnProperty('iScram')) {
        this.iScram = initObj.iScram
      }
      else {
        this.iScram = 0;
      }
      if (initObj.hasOwnProperty('iCrash')) {
        this.iCrash = initObj.iCrash
      }
      else {
        this.iCrash = 0;
      }
      if (initObj.hasOwnProperty('ioStatus')) {
        this.ioStatus = initObj.ioStatus
      }
      else {
        this.ioStatus = 0;
      }
      if (initObj.hasOwnProperty('iCharge')) {
        this.iCharge = initObj.iCharge
      }
      else {
        this.iCharge = 0;
      }
      if (initObj.hasOwnProperty('iShutdown')) {
        this.iShutdown = initObj.iShutdown
      }
      else {
        this.iShutdown = 0;
      }
      if (initObj.hasOwnProperty('iReset')) {
        this.iReset = initObj.iReset
      }
      else {
        this.iReset = 0;
      }
      if (initObj.hasOwnProperty('iAuto')) {
        this.iAuto = initObj.iAuto
      }
      else {
        this.iAuto = 0;
      }
      if (initObj.hasOwnProperty('iLift')) {
        this.iLift = initObj.iLift
      }
      else {
        this.iLift = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type base_sensor_data
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [power]
    bufferOffset = _serializer.float32(obj.power, buffer, bufferOffset);
    // Serialize message field [iEncoder_l]
    bufferOffset = _serializer.int32(obj.iEncoder_l, buffer, bufferOffset);
    // Serialize message field [iEncoder_r]
    bufferOffset = _serializer.int32(obj.iEncoder_r, buffer, bufferOffset);
    // Serialize message field [iVoltage]
    bufferOffset = _serializer.int16(obj.iVoltage, buffer, bufferOffset);
    // Serialize message field [iCurrent]
    bufferOffset = _serializer.int16(obj.iCurrent, buffer, bufferOffset);
    // Serialize message field [quantity]
    bufferOffset = _serializer.int8(obj.quantity, buffer, bufferOffset);
    // Serialize message field [batTemp]
    bufferOffset = _serializer.int8(obj.batTemp, buffer, bufferOffset);
    // Serialize message field [capicity]
    bufferOffset = _serializer.int8(obj.capicity, buffer, bufferOffset);
    // Serialize message field [iLeftMotor]
    bufferOffset = _serializer.int8(obj.iLeftMotor, buffer, bufferOffset);
    // Serialize message field [iRightMotor]
    bufferOffset = _serializer.int8(obj.iRightMotor, buffer, bufferOffset);
    // Serialize message field [iScram]
    bufferOffset = _serializer.int8(obj.iScram, buffer, bufferOffset);
    // Serialize message field [iCrash]
    bufferOffset = _serializer.int8(obj.iCrash, buffer, bufferOffset);
    // Serialize message field [ioStatus]
    bufferOffset = _serializer.int8(obj.ioStatus, buffer, bufferOffset);
    // Serialize message field [iCharge]
    bufferOffset = _serializer.int8(obj.iCharge, buffer, bufferOffset);
    // Serialize message field [iShutdown]
    bufferOffset = _serializer.int8(obj.iShutdown, buffer, bufferOffset);
    // Serialize message field [iReset]
    bufferOffset = _serializer.int8(obj.iReset, buffer, bufferOffset);
    // Serialize message field [iAuto]
    bufferOffset = _serializer.int8(obj.iAuto, buffer, bufferOffset);
    // Serialize message field [iLift]
    bufferOffset = _serializer.int8(obj.iLift, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type base_sensor_data
    let len;
    let data = new base_sensor_data(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [power]
    data.power = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [iEncoder_l]
    data.iEncoder_l = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [iEncoder_r]
    data.iEncoder_r = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [iVoltage]
    data.iVoltage = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [iCurrent]
    data.iCurrent = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [quantity]
    data.quantity = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [batTemp]
    data.batTemp = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [capicity]
    data.capicity = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iLeftMotor]
    data.iLeftMotor = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iRightMotor]
    data.iRightMotor = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iScram]
    data.iScram = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iCrash]
    data.iCrash = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ioStatus]
    data.ioStatus = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iCharge]
    data.iCharge = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iShutdown]
    data.iShutdown = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iReset]
    data.iReset = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iAuto]
    data.iAuto = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [iLift]
    data.iLift = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sineva_nav/base_sensor_data';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '34841bb51091b10dfad93c5e9e27dde1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 power
    int32 iEncoder_l
    int32 iEncoder_r
    int16 iVoltage
    int16 iCurrent
    int8 quantity
    int8 batTemp
    int8 capicity
    int8 iLeftMotor
    int8 iRightMotor
    int8 iScram
    int8 iCrash
    int8 ioStatus
    int8 iCharge
    int8 iShutdown
    int8 iReset
    int8 iAuto
    int8 iLift
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new base_sensor_data(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.power !== undefined) {
      resolved.power = msg.power;
    }
    else {
      resolved.power = 0.0
    }

    if (msg.iEncoder_l !== undefined) {
      resolved.iEncoder_l = msg.iEncoder_l;
    }
    else {
      resolved.iEncoder_l = 0
    }

    if (msg.iEncoder_r !== undefined) {
      resolved.iEncoder_r = msg.iEncoder_r;
    }
    else {
      resolved.iEncoder_r = 0
    }

    if (msg.iVoltage !== undefined) {
      resolved.iVoltage = msg.iVoltage;
    }
    else {
      resolved.iVoltage = 0
    }

    if (msg.iCurrent !== undefined) {
      resolved.iCurrent = msg.iCurrent;
    }
    else {
      resolved.iCurrent = 0
    }

    if (msg.quantity !== undefined) {
      resolved.quantity = msg.quantity;
    }
    else {
      resolved.quantity = 0
    }

    if (msg.batTemp !== undefined) {
      resolved.batTemp = msg.batTemp;
    }
    else {
      resolved.batTemp = 0
    }

    if (msg.capicity !== undefined) {
      resolved.capicity = msg.capicity;
    }
    else {
      resolved.capicity = 0
    }

    if (msg.iLeftMotor !== undefined) {
      resolved.iLeftMotor = msg.iLeftMotor;
    }
    else {
      resolved.iLeftMotor = 0
    }

    if (msg.iRightMotor !== undefined) {
      resolved.iRightMotor = msg.iRightMotor;
    }
    else {
      resolved.iRightMotor = 0
    }

    if (msg.iScram !== undefined) {
      resolved.iScram = msg.iScram;
    }
    else {
      resolved.iScram = 0
    }

    if (msg.iCrash !== undefined) {
      resolved.iCrash = msg.iCrash;
    }
    else {
      resolved.iCrash = 0
    }

    if (msg.ioStatus !== undefined) {
      resolved.ioStatus = msg.ioStatus;
    }
    else {
      resolved.ioStatus = 0
    }

    if (msg.iCharge !== undefined) {
      resolved.iCharge = msg.iCharge;
    }
    else {
      resolved.iCharge = 0
    }

    if (msg.iShutdown !== undefined) {
      resolved.iShutdown = msg.iShutdown;
    }
    else {
      resolved.iShutdown = 0
    }

    if (msg.iReset !== undefined) {
      resolved.iReset = msg.iReset;
    }
    else {
      resolved.iReset = 0
    }

    if (msg.iAuto !== undefined) {
      resolved.iAuto = msg.iAuto;
    }
    else {
      resolved.iAuto = 0
    }

    if (msg.iLift !== undefined) {
      resolved.iLift = msg.iLift;
    }
    else {
      resolved.iLift = 0
    }

    return resolved;
    }
};

module.exports = base_sensor_data;
