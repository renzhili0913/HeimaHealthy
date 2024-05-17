import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct NutrientStats {
  @Prop carbon:number
  @Prop protein:number
  @Prop fat:number
  recommendCarbon:number=CommonConstants.RECOMMEND_CARBON //推荐量
  recommendProtein:number=CommonConstants.RECOMMEND_PROTEIN //推荐量
  recommendFat:number=CommonConstants.RECOMMEND_FAT //推荐量

  build() {
    Row({space:CommonConstants.SPACE_6}){
      this.StatsBuilder({label:'碳水化合物（克）',value:this.carbon,recommend:this.recommendCarbon,color:$r('app.color.carbon_color')})
      this.StatsBuilder({label:'蛋白质（克）',value:this.protein,recommend:this.recommendProtein,color:$r('app.color.protein_color')})
      this.StatsBuilder({label:'脂肪（克）',value:this.fat,recommend:this.recommendFat,color:$r('app.color.fat_color')})
    }.width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({top:40,bottom:45})
  }

  @Builder StatsBuilder($$:{label:string,value:number,recommend:number,color:ResourceStr}){
    Column({space:CommonConstants.SPACE_6}){
      Stack(){
        Progress({value:$$.value, total: $$.recommend, type: ProgressType.Ring}).width(95)
          .style({strokeWidth:CommonConstants.DEFAULT_6})
          .color($$.color)
        Column({space:CommonConstants.SPACE_6}){
          Text('摄入推荐').fontSize(12).fontColor($r('app.color.light_gray'))
          Text(`${$$.value.toFixed()}/${$$.recommend.toFixed()}`).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
        }
      }
      Text($$.label).fontSize(12).fontColor($r('app.color.light_gray'))
    }
  }
}