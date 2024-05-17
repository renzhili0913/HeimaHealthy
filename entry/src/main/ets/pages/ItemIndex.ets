import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import RecordService from '../service/RecordService'
import ItemCard from '../view/item/ItemCard'
import ItemList from '../view/item/ItemList'
import ItemPanelHeader from '../view/item/ItemPanelHeader'
import NumberKeyboard from '../view/item/NumberKeyboard'
import RecordItem from '../viewmodel/RecordItem'
import RecordType from '../viewmodel/RecordType'
@Entry
@Component
struct ItemIndex {
  @State showPanel: boolean = false
  @State amount: number = 1
  @State value: string = ""
  @State item: RecordItem = null
  @State type: RecordType = RecordTypes[0]
  @State isFood : boolean = true
  onPanelShow(item :RecordItem){
    this.showPanel = true
    this.value = ''
    this.amount = 1
    this.item = item
  }
  onPageShow(){
   let params : any =  router.getParams()
    this.type = params.type
    this.isFood = this.type.id !== RecordTypeEnum.WORKOUT
  }
  build() {
      Column() {
        this.Header()
        ItemList({showPanel:this.onPanelShow.bind(this),isFood:this.isFood}).layoutWeight(1)
        Panel(this.showPanel){
          ItemPanelHeader()
          if (this.item){
            ItemCard({amount:this.amount,item:$item})
          }
          NumberKeyboard({amount:$amount,value:$value})
          Row({space:CommonConstants.SPACE_6}){
            Button('取消').width(120).type(ButtonType.Normal).backgroundColor($r('app.color.light_gray')).borderRadius(6).onClick(()=>this.showPanel = false)
            Button('提交').width(120).type(ButtonType.Normal).backgroundColor($r('app.color.primary_color')).borderRadius(6)
              .onClick(()=>{
                RecordService.insert(this.type.id,this.item.id,this.amount)
                  .then(()=>{
                    this.showPanel = false
                  })

            })
          }.margin({top:6})
        }
        .mode(PanelMode.Full)
        .dragBar(false)
        .backgroundMask($r('app.color.light_gray'))
        .backgroundColor(Color.White)
      }
      .width('100%')
  }

  @Builder Header(){
    Row(){
      Image($r('app.media.ic_public_back')).width(24).onClick(()=>{
        router.back()
      })
      Blank()
      Text(this.type.name)
        .fontSize(18)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
    }.width(CommonConstants.THOUSANDTH_940)
    .height(32)
  }
}