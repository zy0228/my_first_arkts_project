
import { Hello } from '../../components/Hello'

@Observed class ReactiveData {
  public a: string = 'cao wocao !!!!'

  constructor(a?: string) {
    this.a = a || 'no constructor param'
  }
}

@Builder function GlobalBuilder1($$: {label: string, width: number}) {
  Button($$.label)
    .width($$.width)
    .height(50)
    .fontColor(Color.Orange)
    .fontSize(24)
    .margin(10)
    .backgroundColor(Color.Green)
    .onClick(() => {
      $$.width = 500
    })
}

class TestDataReactive {
  width: number = 100;

  constructor(width: number) {
    this.width = width;
  }
}

@Component
struct Child{
  @Link dataReactive: TestDataReactive
  @ObjectLink fuck: ReactiveData

  label: string = 'This is Child Component'
  @BuilderParam aBuilder: () => void
  @BuilderParam aBuilder1: ($$: {label: string, width: number}) => void

  build() {
    Column() {
      this.aBuilder()
      Divider()
      Button('$dispatch @Link data')
        .fontColor(Color.Pink)
        .width(this.dataReactive.width)
        .onClick(() => {
          this.dataReactive.width = Math.random() * (500 - 100) + 100
        })
      this.aBuilder1({label: this.label, width: this.dataReactive.width})

      Button(this.fuck.a)
        .fontColor(Color.Grey)
        .width(300)
        .backgroundColor(Color.Black)
        .onClick(() => {
          this.fuck.a = 'no constructor param'
        })
    }
  }
}

@Entry
@Component
struct Index {
  @State label: string = 'Hello World'
  @State testRedux: TestDataReactive = new TestDataReactive(200)
  @Provide publicData: number = 300
  @State testObserved: ReactiveData = new ReactiveData()

  @State arrList: number[] = [1, 2, 3]


  onPageShow() {
    let storage = new LocalStorage({propA: 1})
    let A = storage.get('propA')

    let storage1 = storage.link('propA')
    storage1.set('the word')
    console.log(this.testObserved.a)
    console.log("show")
  }

  @Builder componentBuilder() {
    if (true) {
      Button('condition')
    }

    ForEach(this.arrList, (item: number) => {
      Text(`${item}`)
    }, (item: number) => item.toString())
    Text(`${this.label}`)
      .fontSize(40)
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
      Child({aBuilder: this.componentBuilder, aBuilder1: GlobalBuilder1, dataReactive: $testRedux, fuck: this.testObserved})
      Button(`${this.publicData}, ${ this.testObserved.a }`)
        .onClick(() => {
          this.testObserved.a = 'fuck nmp'
        })
    }
  }
}