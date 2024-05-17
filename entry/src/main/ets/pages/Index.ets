import BreakpointType from '../common/bean/BreanpointType'
import BreakpointConstants from '../common/constants/BreakpointConstants'
import { CommonConstants } from '../common/constants/CommonConstants'
import BreakpointSystem from '../common/utils/BreakpointSystem'
import RecordIndex from '../view/record/RecordIndex'
@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private breakpointSystem : BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint:string = BreakpointConstants.BREAKPOINT_SM
  @State isPageShow :boolean= false
  aboutToAppear(){
    this.breakpointSystem.register()
  }
  aboutToDisappear(){
    this.breakpointSystem.unregister()
  }
  onPageShow(){
    this.isPageShow = true
  }
  onPageHide(){
    this.isPageShow = false
  }
  build() {
   Tabs({barPosition:BreakpointConstants.BAR_POSITION.getValue(this.currentBreakpoint)}){
     TabContent(){
       RecordIndex({isPageShow:this.isPageShow})
     }.tabBar(this.TabBuilder($r('app.string.tab_record'),$r('app.media.ic_calendar'),0))
     TabContent(){

     }.tabBar(this.TabBuilder($r('app.string.tab_discover'),$r('app.media.discover'),1))
     TabContent(){

     }.tabBar(this.TabBuilder($r('app.string.tab_user'),$r('app.media.ic_user_portrait'),2))
   }
   .width('100%')
   .height('100%')
   .vertical(BreakpointConstants.BAR_VERTICAL.getValue(this.currentBreakpoint))
    .onChange(index=>{
      this.currentIndex = index
    })
  }

  @Builder TabBuilder(title:ResourceStr,image:ResourceStr,index:number){
    Column({space:CommonConstants.SPACE_8}){
      Image(image).width(22).fillColor(this.selectColor(index))
      Text(title).fontSize(12).fontColor(this.selectColor(index))
    }
    .justifyContent(FlexAlign.Center)
  }

   selectColor(index:number){
    return this.currentIndex===index?$r('app.color.primary_color'):$r('app.color.light_primary_color')
  }
}