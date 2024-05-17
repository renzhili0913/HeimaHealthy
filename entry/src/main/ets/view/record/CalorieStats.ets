import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct CalorieStats {
  @Prop intake:number//摄入量
  @Prop expend:number//运动消耗量
  recommend:number=CommonConstants.RECOMMEND_CALORIE //推荐量
  remainCalorie(){
    //还可以吃的量
    return this.recommend - this.intake +this.expend
  }
  build() {
    Row({space:CommonConstants.SPACE_6}){
      this.StatsBuilder({label:'饮食摄入',value:this.intake})
      Stack(){
        Progress({value:this.intake, total: this.recommend, type: ProgressType.Ring}).width(120)
          .style({strokeWidth:CommonConstants.DEFAULT_10})
          .color($r('app.color.primary_color'))
        this.StatsBuilder({label:'还可以吃',value:this.remainCalorie(),tips:`推荐${this.recommend}`})
      }
      this.StatsBuilder({label:'运动消耗',value:this.expend})

    }.width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({top:40,bottom:45})
  }

  @Builder StatsBuilder($$:{label:string,value:number,tips?:string}){
    Column({space:CommonConstants.SPACE_6}){
      Text($$.label).fontColor($r('app.color.gray')).fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text($$.value.toFixed()).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_700)
      if ($$.tips){
        Text($$.tips).fontSize(12).fontColor($r('app.color.light_gray')).fontWeight(CommonConstants.FONT_WEIGHT_700)
      }
    }
  }
}