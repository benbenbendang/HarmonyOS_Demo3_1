import promptAction from '@ohos.promptAction';

@Entry
@Component
struct HomePage {
  @State temperature: number = 35.5
  @State humidity: number = 50
  @State livingRoomLight: boolean = false
  @State airCondition: boolean = false
  @State humidifier: boolean = false
  @State curtain: boolean = false

  build() {
    Scroll() {
      Column() {
        // 顶部标题栏
        Row() {
          Text("智能家具控制")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 20 })
          Blank().layoutWeight(1)
          Image($r('app.media.icon_settings'))
            .width(26).height(26)
            .margin({ right: 20 })
            .onClick(() => promptAction.showToast({ message: "设置" }))
        }
        .height(56)
        .backgroundColor('#3B82F6') // 蓝色主题色
        .alignItems(VerticalAlign.Center)

        // 温湿度卡片
        Row({ space: 50 }) {
          Column() {
            Image($r('app.media.icon_temp')).width(40).height(40)
            Text(`${this.temperature}°C`)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 6 })
            Text("温度").fontSize(14).fontColor('#555')
          }.alignItems(HorizontalAlign.Center)

          Column() {
            Image($r('app.media.icon_drop')).width(40).height(40)
            Text(`${this.humidity}%`)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 6 })
            Text("湿度").fontSize(14).fontColor('#555')
          }.alignItems(HorizontalAlign.Center)
        }
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#93C5FD' }) // 淡蓝色边框
        .borderRadius(16)
        .padding(24)
        .margin({ top: 20, left: 20, right: 20 })
        .shadow({ radius: 8, color: '#22000000', offsetX: 0, offsetY: 4 })

        // 快速场景
        Text("快速场景")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 24, left: 20, bottom: 10 })

        Row({ space: 20 }) {
          this.buildScene("居家", $r('app.media.icon_home'), '#10B981')   // 绿色
          this.buildScene("离家", $r('app.media.icon_run'), '#3B82F6')   // 蓝色
          this.buildScene("睡眠", $r('app.media.icon_sleep'), '#EC4899') // 粉色
        }
        .margin({ left: 20, right: 20 })

        // 设备开关列表
        this.buildDeviceRow("客厅灯", $r('app.media.icon_light'), this.livingRoomLight, (v: boolean) => this.livingRoomLight = v)
        this.buildDeviceRow("空调", $r('app.media.icon_ac'), this.airCondition, (v: boolean) => this.airCondition = v)
        this.buildDeviceRow("加湿器", $r('app.media.icon_humidifier'), this.humidifier, (v: boolean) => this.humidifier = v)
        this.buildDeviceRow("窗帘", $r('app.media.icon_curtain'), this.curtain, (v: boolean) => this.curtain = v)
      }
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [
          ['#E0F2FE', 0.0], // 浅蓝
          ['#F9FAFB', 1.0]  // 浅灰白
        ]
      })


    }
    .scrollable(ScrollDirection.Vertical)
  }

  // 快速场景组件
  @Builder
  buildScene(label: string, icon: Resource, bgColor: string) {
    Column() {
      Image(icon).width(44).height(44)
      Text(label).fontSize(14).margin({ top: 6 }).fontColor(Color.White)
    }
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .padding(16)
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: 3 })
  }

  // 设备行
  @Builder
  buildDeviceRow(label: string, icon: Resource, state: boolean, onChange: (v: boolean) => void) {
    Row() {
      Image(icon).width(28).height(28).margin({ right: 14 })
      Text(label).fontSize(18).fontWeight(FontWeight.Medium)
      Blank().layoutWeight(1)
      Toggle({ type: ToggleType.Switch, isOn: state })
        .onChange((value: boolean) => {
          onChange(value)
          promptAction.showToast({ message: `${label} 已${value ? "开启" : "关闭"}` })
        })
    }
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#BFDBFE' }) // 淡蓝描边
    .borderRadius(12)
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .margin({ top: 12, left: 20, right: 20 })
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 2 })
  }
}
