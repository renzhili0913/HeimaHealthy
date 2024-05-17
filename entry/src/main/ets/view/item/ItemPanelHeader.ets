import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil'
@Component
export default struct ItemPanelHeader {
  build() {
    Row(){
      Text(DateUtil.formatDate(AppStorage.Get('selectedDate'))||DateUtil.formatDate(DateUtil.beginTimeOfDay(new Date()))).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
      Image($r('app.media.ic_public_spinner')).width(20).fillColor(Color.Black)
    }.width(CommonConstants.THOUSANDTH_940)
    .justifyContent(FlexAlign.Center)
  }
}