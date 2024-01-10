# 学习arkTS语言

## 基础语法
arkTS感觉都是采用了各种语法糖，但是本质上还是JS，所以还是会存在一些JS的历史问题，比如this的指向问题，这个问题在TS中也是存在的，所以在使用的时候还是要注意一下
### 自定义组件
```
@Entry // 表示这是入口文件 每个页面都需要有一个入口文件
@Component
strut Main {
  @State label: string = 'Hello World'
  build() {
    Column {
      Text(this.label)
      MyBuilder({label: this.label})
    }
  }
}
```

### @Builder 自定义构造函数
```
@Builder function MyBuilder($$: {label: string}) {
  Column {
    Text($$.label)
  }
}

```

### @BuilderParam 装饰器
在我看来这就是个高阶函数的装饰器
```
@Component
strut Main {
  @State label: string = 'Hello World'

  @BuilderParam builder1: () => void
  @BuilderParam builder2: ($$: {label: string}) => void

  build() {
    Column {
      builder1()
      builder2({label: this.label})
    }
  }
}

@Component Index {
  build() {
    Main({
      builder1: () => {
        Text('builder1')
      },
      builder2: ($$: {label: string}) => {
        Text($$.label)
      }
    })
  }
}
```
### @Style,@Extend 装饰器
这两个装饰器是用来定义样式的，@Style是定义样式，@Extend是继承样式且可以传参数跟绑定事件
```
@Style function style1() {
  .background(Color.Red)
}
@Extend(Text) function superFancyText(size: number,handleClick:() => void) {
  .fontSize(size)
  .onClick(handleClick)
}
```