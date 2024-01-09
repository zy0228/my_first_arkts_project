
import { Hello } from '../../components/Hello'

@Builder function GlobalBuilder1($$: {label: string}) {
  Button($$.label)
    .width(400)
    .height(50)
    .fontColor(Color.Red)
    .fontSize(24)
    .margin(10)
    .backgroundColor(Color.Green)
}

@Component
struct Child{
  label: string = 'Child'
  @BuilderParam aBuilder: () => void
  @BuilderParam aBuilder1: ($$: {label: string}) => void

  build() {
    Column() {
      this.aBuilder()
      Divider()
      this.aBuilder1({label: this.label})
    }
  }
}

@Entry
@Component
struct Index {
  @State label: string = 'Hello World'

  onPageShow() {
    console.log("show")
  }

  @Builder componentBuilder() {
    Text(`${this.label}`)
      .stateStyles({
        focused: {
          .backgroundColor(Color.Blue)
        },
        pressed: {
          .backgroundColor(Color.Orange)
        },
        normal: {
          .backgroundColor(Color.Brown)
        }
      })
    Divider()
  }

  build() {
    Column() {
      Hello({ message: 'Hello, World!' })
      this.componentBuilder()
      Child({aBuilder: this.componentBuilder, aBuilder1: GlobalBuilder1})
    }
  }
}