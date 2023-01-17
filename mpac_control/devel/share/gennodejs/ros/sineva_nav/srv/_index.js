
"use strict";

let GetStateSrv = require('./GetStateSrv.js')
let manage_charge = require('./manage_charge.js')
let JsonSrv = require('./JsonSrv.js')
let SetPathSrv = require('./SetPathSrv.js')
let BaseCommand = require('./BaseCommand.js')
let MoveStatus = require('./MoveStatus.js')
let StringCommSrv = require('./StringCommSrv.js')
let charge_point = require('./charge_point.js')
let CheckGoalStatusSrv = require('./CheckGoalStatusSrv.js')
let SetPositionsSrv = require('./SetPositionsSrv.js')
let CloseSafeAreaSrv = require('./CloseSafeAreaSrv.js')
let JsonCommSrv = require('./JsonCommSrv.js')
let SetInitialPoseSrv = require('./SetInitialPoseSrv.js')
let SetGoalSrv = require('./SetGoalSrv.js')
let UpdateMapSrv = require('./UpdateMapSrv.js')
let MapReq = require('./MapReq.js')
let EnableSrv = require('./EnableSrv.js')
let SaveMapping = require('./SaveMapping.js')
let manage_map_lidar = require('./manage_map_lidar.js')
let goal_status = require('./goal_status.js')
let CancelGoalSrv = require('./CancelGoalSrv.js')
let Relocation = require('./Relocation.js')

module.exports = {
  GetStateSrv: GetStateSrv,
  manage_charge: manage_charge,
  JsonSrv: JsonSrv,
  SetPathSrv: SetPathSrv,
  BaseCommand: BaseCommand,
  MoveStatus: MoveStatus,
  StringCommSrv: StringCommSrv,
  charge_point: charge_point,
  CheckGoalStatusSrv: CheckGoalStatusSrv,
  SetPositionsSrv: SetPositionsSrv,
  CloseSafeAreaSrv: CloseSafeAreaSrv,
  JsonCommSrv: JsonCommSrv,
  SetInitialPoseSrv: SetInitialPoseSrv,
  SetGoalSrv: SetGoalSrv,
  UpdateMapSrv: UpdateMapSrv,
  MapReq: MapReq,
  EnableSrv: EnableSrv,
  SaveMapping: SaveMapping,
  manage_map_lidar: manage_map_lidar,
  goal_status: goal_status,
  CancelGoalSrv: CancelGoalSrv,
  Relocation: Relocation,
};
