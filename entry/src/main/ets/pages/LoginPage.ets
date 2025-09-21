import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State passwordVisible: boolean = false
  @State error: string = ''

  build() {
    Column({ space: 20 }) {
      // 头像
      Image($r('app.media.ycw'))
        .width(100).height(100)
        .borderRadius(50)
        .margin({ top: 60, bottom: 40 })

      // 用户名输入
      this.buildInputRow("用户名", "请输入用户名", (val: string) => this.username = val)

      // 密码输入
      this.buildPasswordRow()

      // 错误提示
      if (this.error) {
        Text(this.error)
          .fontColor(Color.Red)
          .fontSize(14)
          .margin({ top: 8 })
      }

      // 登录 + 注册按钮
      Row({ space: 20 }) {
        Button('登录')
          .width(120).height(40)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .borderRadius(20)
          .onClick(() => this.handleLogin())

        Button('注册')
          .width(120).height(40)
          .backgroundColor('#42C02E')
          .fontColor(Color.White)
          .borderRadius(20)
          .onClick(() => promptAction.showToast({ message: '注册功能待实现' }))
      }
      .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FB')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  // 用户名输入行
  @Builder
  buildInputRow(label: string, placeholder: string, onChange: (val: string) => void) {
    Row({ space: 10 }) {
      Text(label + "：")
        .width(80) // 固定宽度，防止换行
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.End)

      TextInput({ placeholder: placeholder })
        .width(220) // 统一宽度
        .height(40)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .padding({ left: 10 })
        .onChange(onChange)
    }
  }

  // 密码输入行（带小眼睛）
  @Builder
  buildPasswordRow() {
    Row({ space: 10 }) {
      Text("密码：")
        .width(80)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.End)

      TextInput({ placeholder: "请输入密码" })
        .width(220) // 与用户名输入框相同
        .height(40)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .padding({ left: 10 })
        .type(this.passwordVisible ? InputType.Normal : InputType.Password)
        .onChange((val: string) => this.password = val)

      // 眼睛图标（需要在 resources/base/media/ 里放两张图）
      Image(this.passwordVisible ? $r('app.media.eye_open') : $r('app.media.eye_close'))
        .width(24).height(24)
        .margin({ left: 8 })
        .onClick(() => this.passwordVisible = !this.passwordVisible)
    }
  }

  // 登录逻辑
  handleLogin() {
    if (!this.username || !this.password) {
      this.error = '请输入用户名和密码'
      return
    }
    this.error = ''
    if (this.username === 'admin' && this.password === '123456') {
      router.pushUrl({ url: 'pages/HomePage' })
    } else {
      this.error = '用户名或密码错误'
      promptAction.showToast({ message: '用户名或密码错误' })
    }
  }
}
