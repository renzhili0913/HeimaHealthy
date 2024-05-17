import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct SearchHeader {
  build() {
    Row({space:CommonConstants.SPACE_8}){
      Search({placeholder:'搜索饮食或运动信息'}).textFont({size:18}).layoutWeight(1)
      Badge({count:1,position:BadgePosition.RightTop,maxCount:100,style:{color:Color.White,fontSize:8,badgeSize:12,badgeColor:Color.Red}}){
        Image($r('app.media.ic_public_email')).width(24)
      }
    }.width(CommonConstants.THOUSANDTH_940)
  }
}