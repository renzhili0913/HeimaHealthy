import RecordPO from '../common/bean/RecordPO'
import DateUtil from '../common/utils/DateUtil'
import RecordItemModel from '../model/RecordItemModel'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import RecordVoModel from '../model/RecordVoModel'
import GroupInfo from '../viewmodel/GroupInfo'
import RecordType from '../viewmodel/RecordType'
import RecordVo from '../viewmodel/RecordVo'
import StatsInfo from '../viewmodel/StatsInfo'
class RecordService{
    insert(typeId:number,itemId:number,amount:number){
      let createTime = (AppStorage.Get('selectedDate') || DateUtil.beginTimeOfDay(new Date())) as number
      return RecordVoModel.instant({typeId,itemId,amount,createTime})
    }
  deleteById(id:number){
    return RecordVoModel.deleteById(id)
  }
  async query(date:number):Promise<RecordVo[]>{
    let rps = await RecordVoModel.queryByDate(date)

    return rps.map(rp=>{
      let rv = {id:rp.id,typeId:rp.typeId,amount:rp.amount} as RecordVo
      rv.recordItem = RecordItemModel.getById(rp.itemId,rp.typeId !== RecordTypeEnum.WORKOUT)
      rv.calorie = rp.amount * rv.recordItem.calorie
      return rv
    })
  }
  calculateStatsInfo(recordVos:RecordVo[]):StatsInfo{
    let statsInfo = new StatsInfo()
    if (!recordVos || recordVos.length <= 0) {
        return statsInfo
    }
    recordVos.forEach(r=>{
      if (r.typeId === RecordTypeEnum.WORKOUT) {
        //代表运动
        statsInfo.expend += r.calorie
      }else {
        statsInfo.intake += r.calorie
        statsInfo.carbon += r.recordItem.carbon
        statsInfo.protein += r.recordItem.protein
        statsInfo.fat += r.recordItem.fat
      }
    })
    return statsInfo
  }
  calculateGroupInfo(recordVos:RecordVo[]):GroupInfo<RecordType,RecordVo>[]{
    let groups =  RecordTypes.map(recordType=>new GroupInfo(recordType,[]))
    if (!recordVos || recordVos.length <= 0){
      return groups
    }
    recordVos.forEach(r=>{
      groups[r.typeId].items.push(r)
      groups[r.typeId].calorie += r.calorie
    })
    return groups


  }
}
let recordService = new RecordService()
export default recordService as RecordService