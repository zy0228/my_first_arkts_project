@Extend(Text) function sass(size: number, onClick: () => void) {
  .backgroundColor(Color.Red)
  .fontSize(size)
  .onClick(onClick)
}

@Component
export struct Hello {
  @Consume publicData: number;
  @Prop message: string;

  @Styles less() {
    .backgroundColor(Color.Black)
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row() {
      Text(this.message)
        .less()
        .sass(50, () => {
          this.message = 'xixixii '
        })
      Button(`${this.publicData}`)
        .onClick(() => {
          this.publicData = 100
        })
    }
  }
}