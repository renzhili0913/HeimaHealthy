import { CommonConstants } from '../../common/constants/CommonConstants'
@CustomDialog
export default struct DatePickDialog {
  controller:CustomDialogController
  private selectedDate: Date = new Date()
  build() {
    Column(){
      DatePicker({
        start: new Date('2020-1-1'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
        })
      Row({space:CommonConstants.SPACE_12}){
        Button('取消').width(120).backgroundColor($r('app.color.light_gray'))
          .onClick(()=>{
            this.controller.close()
          })
        Button('确定').width(120).backgroundColor($r('app.color.primary_color'))
          .onClick(()=>{
            //保存日期到全局
            AppStorage.SetOrCreate('selectedDate',this.selectedDate.getTime())
            //关闭窗口
            this.controller.close()
          })
      }
    }.padding(CommonConstants.SPACE_12)
  }
}