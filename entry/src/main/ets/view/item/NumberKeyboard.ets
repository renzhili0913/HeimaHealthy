import { CommonConstants } from '../../common/constants/CommonConstants'
@Styles function  keyBoxStyle(){
  .backgroundColor(Color.White)
  .height(60)
  .borderRadius(8)
}
@Component
export default struct NumberKeyboard {
  numbers : string[] = ['1','2','3','4','5','6','7','8','9','0','.']
  @Link amount: number
  @Link value: string
  build() {
    Grid(){
      ForEach(this.numbers,(i)=>{
        GridItem(){
          Text(i).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
        }.keyBoxStyle()
        .onClick(()=>this.clickNumber(i))
      })
      GridItem(){
        Text('删除').fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
      }.keyBoxStyle()
      .onClick(()=>this.clickDel())
    }.width('100%')
    .height(280)
    .backgroundColor($r('app.color.index_page_background'))
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding(8)
    .margin({top:10})
  }
  clickNumber(num:string){
    let val = this.value + num
    let firstIndex = val.indexOf('.')
    let lastIndex = val.lastIndexOf('.')
    if (firstIndex !== lastIndex || (lastIndex!= -1 && lastIndex < val.length -2)) {
      return
    }
    let amount = this.parseFloat(val)

    if (amount >= 999.9) {
      this.amount = 999.0
      this.value = '999'
    }else {
      this.amount = amount
      this.value = val
    }
  }
  clickDel(){
    if (this.value.length<=0) {
      this.value = ''
      this.amount = 0
      return
    }
    this.value = this.value.substring(0,this.value.length-1)
    this.amount = this.parseFloat(this.value)
  }
  parseFloat(str:string){
    if (!str){
      return 0
    }
    if (str.endsWith('.')) {
      str = str.substring(0,str.length - 1)
    }
    return parseFloat(str)
  }
}