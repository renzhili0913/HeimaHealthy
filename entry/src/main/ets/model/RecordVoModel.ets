
import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import RecordPO from '../common/bean/RecordPO'
import DbUtil from '../common/utils/DbUtil'
const CREATE_TABLE_SQL: string = `
 CREATE TABLE IF NOT EXISTS record (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   type_id INTEGER NOT NULL,
   item_id INTEGER NOT NULL,
   amount DOUBLE NOT NULL,
   create_time INTEGER NOT NULL
 )
 `
const COLUMNS: ColumnInfo[] = [
  {name: 'id', columnName: 'id', type: ColumnType.LONG},
  {name: 'typeId', columnName: 'type_id', type: ColumnType.LONG},
  {name: 'itemId', columnName: 'item_id', type: ColumnType.LONG},
  {name: 'amount', columnName: 'amount', type: ColumnType.DOUBLE},
  {name: 'createTime', columnName: 'create_time', type: ColumnType.LONG}
]
const TABLE_NAME = 'record'
const ID_COLUMN = 'id'
const CREATE_TIME = 'create_time'
class RecordVoModel{
  getCreateTableSql():string{
   return CREATE_TABLE_SQL
  }

  instant(record:RecordPO): Promise<number>{
    return DbUtil.insert(TABLE_NAME,record,COLUMNS)
  }
  deleteById(id:number): Promise<number>{
    //删除条件，根据id删除
    let predicates :relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(ID_COLUMN,id)
    //删除
    return DbUtil.delete(predicates)
  }
  updateById(id:number,record:RecordPO): Promise<number>{
    //修改条件
    let predicates :relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(ID_COLUMN,id)
    return DbUtil.update(predicates,record,COLUMNS)
  }
  queryByDate(date:number):Promise<RecordPO[]>{
    //查询条件，根据创建时间查询
    let predicates :relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(CREATE_TIME,date)
    return DbUtil.queryForList<RecordPO>(predicates,COLUMNS)
  }
}
let recordVoModel = new RecordVoModel()
export default recordVoModel as RecordVoModel