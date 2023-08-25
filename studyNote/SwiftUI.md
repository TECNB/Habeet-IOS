# SwiftUI

宣告式程式设计的前端IOS编程语言

## 工程结构

ContentView.swift为入口文件

Assets存放静态资源

HabeetApp为启动入口

![image-20230807154634820](https://gitee.com/TECNB/pic-demo/raw/master/image-20230807154634820.png)

### ContentView

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                
        }
        .padding()
    }
}

//產生 ContentView 和 HomeView 的預覽
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
      		  .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro")) //更改预览的设备
            .previewDisplayName("iPhone 12 Pro")	//更改预览的名字
      			.previewInterfaceOrientation(.landscapeLeft) //以橫向模式預覽UI
        HomeView()
    }
}
```

### HabeetApp

```swift
import SwiftUI

@main
struct HabeetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            HomeView()
        }
    }
}
```

## 视图（View）

@ViewBuilder可以解决优化视图之后无返回值的问题

![image-20230809153455860](https://gitee.com/TECNB/pic-demo/raw/master/image-20230809153455860.png)

### Text

```swift
Text("Stay Hungry. Stay Foolish.")
    .fontWeight(.bold)
    .font(.title)	//这是使用系统的预设的字体调整方式
		.font(.system(size: 50))	//这样就可以自己调整大小
		.minimumScaleFactor(0.7)	//这代表你能接受这个元素最小为多大，系统会自动更改
    .lineLimit(1)	//这样就限制字体为一行
		.foregroundColor(.indigo)	//更改字体颜色为紫色
```

### Button

```swift
			//role里面是苹果给的预设，比如警告按钮.destructive
Button(role: .none, action: {
    // 欲執行的動作
}, label: {
  // 按鈕外觀描述（可以使用text（））
    Text("开始")
})
.padding(.top,30)  //文字上方加上一些间距
.foregroundColor(.white)
.background(Color.purple)
.cornerRadius(20) //建立圆角按钮
.buttonStyle(.borderedProminent)  //苹果内置的样式按钮为重点
.buttonStyle(.plain)  //苹果内置的样式按钮为没有任何样式
//简易版本
Button{
    
}label: {
    
}
```

### Image

```swift
Image("user1")//里面为Assets内的图片的名称
    .resizable()//預設上，iOS 會以原始大小來顯示圖片，要在 SwiftUI 中調整圖片大小，則我們可以加入 resizable 修飾器（iOS 會延伸圖片來填滿可用區域）,此延伸模式並沒有考量圖片本身的長寬比
		.scaledToFit()//保持原來圖片的長寬比，則你可以應用 scaledToFit 修飾器
```



### Vertical Stack(VStack 垂直堆叠视图)

作用为把子视图排列成一个垂直的堆栈（默认不可见，相当于css里的display：block）

```swift
VStack(spacing: 20) {
  .
  .
  .
}
```



### Horizontal Stack(HStack 水平堆叠视图)

```swift
HStack {
  .
  .
  .
}
.padding(.horizontal, 20) //左右邊緣加入 20 點的間距

//HStack 視圖實際上提供兩個可選型別的參數，一個是 alignment，另一個則是 spacing
//1、將所有的圖片視圖對齊底部邊緣
//2、在視圖之間加入10 點的間距
HStack(alignment: .bottom, spacing: 10) {
  .
  .
  .
}
```





### ZStack（Z轴堆叠视图）

越靠近下面的，在z轴上越高

```swift
ZStack{
  // 目标视图的内容
  Text("最底部")
  Text("中间")
  Text("最顶部")
}
```

### Rectangle

`Rectangle()` 是 SwiftUI 中的一个视图类型，用于创建一个矩形形状的视图

注意在overlay与Rectangle等视图联系时，在overlay里使用foreach等类似语句，不会报相应的foreach里参数使用错误，而是会报错：Type '() -> ()' cannot conform to 'ShapeStyle'，会导致我们找错报错的方向（卡了半个多小时，QAQ）

```swift
//在下述示例中，Rectangle() 创建一个蓝色的矩形视图
Rectangle()
    .frame(width: 100, height: 50)
    .foregroundColor(Color.blue)
```

### Circle

```swift
Circle()
	.fill(Color.blue)		// 填充为蓝色
	.frame(width: 100, height: 100) // 设置圆形的尺寸
```



### Spacer

「留白」（Spacer ）的 SwiftUI 特殊元件，留白視圖是一個沒有內容的視圖，它在堆疊視圖中占用儘可能多的空間。例如：當你將留白視圖放置在垂直佈局中，它會在堆疊允許的範圍內垂直擴展。

```swift
Spacer()
	.layoutPriority(1)
```



### TextField

输入框

```swift
//下面通过设置textFieldStyle为PlainTextFieldStyle()使得能够自定义输入框的样式
TextField("请输入备注", text: $textInput)
    .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)) // 调整内部空间
    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
    .cornerRadius(22.5) // 圆角边框
    .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式

```

### TabView

轮播图

**注意**这个currentIndex = (currentIndex + 1) % items.count里面的 items.count不能为0否则报错（卡了我半小时，主要是swiftui项目崩溃的日志实在是又长又没有重点😡）

```swift
//下面为实现自动播放功能的轮播图，注意在实验后发现大多数参数不能该
@State private var currentIndex = 0
let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
let items = [
        ("loginNavLogo1", "兑换\n商店积分"),
        ("loginNavLogo2", "发现\n自我进步"),
        ("loginNavLogo3", "建立\n计时标签"),
        ("loginNavLogo4", "建立\n你的目标")
]

//selection实际上就是
// 创建一个TabView，通过绑定的方式来追踪选中的索引
TabView(selection: $currentIndex) {
    // 使用ForEach来遍历items数组的索引
  	//items.indices被用作遍历的集合，它返回了一个表示items数组索引的范围。
    ForEach(items.indices, id: \.self) { index in
        VStack(spacing: 10) {
            Image(items[index].0)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 380)

            HStack {
                Text(items[index].1)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        // 为每个页面分配一个标签，这里使用索引作为标签
        // 在 ForEach 视图内部，每个循环迭代都会创建一个新的 VStack 视图，并通过 .tag(index) 方法将这个 VStack 视图与当前的索引值 index(currentIndex) 相关联。
        .tag(index)
    }
}
// 设置TabView的样式为页面样式，允许用户水平滑动浏览页面
.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
// 设置索引视图的样式，始终显示索引
.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
// 当接收到计时器(timer)的事件时，执行闭包内的操作
.onReceive(timer) {_ in
    // 在控制台输出一条消息，表示计时器触发
    print("Timer triggered")
    // 更新当前选中的索引，实现页面自动切换效果，取余运算以循环显示页面
    currentIndex = (currentIndex + 1) % items.count
}


```

### ScrollView

```swift
//vertical代表竖直方向，showsIndicators代表是否显示滚动条
ScrollView(.vertical, showsIndicators: false) {
    ForEach(tagWithTime.indices, id: \.self) { index in 
        TagItemView(tagTimeIndex:tagTimeIndex)
            .frame(maxWidth: .infinity)
    }
}
```

### Picker

```swift
//下面为时间Picker
.sheet(isPresented: $showScorePicker) {
    Picker("分数", selection: $selectedScore) {
        ForEach(1...8, id: \.self) { score in
            Text("\(score) Point")
        }
    }
    .pickerStyle(WheelPickerStyle())
  	//控制sheet的弹出的高度和允许用户拖拽到的位置
    .presentationDetents([.fraction(0.4),.medium,.large])
    .edgesIgnoringSafeArea(.all)
    
    Button {
        showScorePicker.toggle()
    }label: {
        Text("完成")
            .foregroundColor(Color.white)
    }
        .frame(width: 100,height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top,30)
}
```

### DatePicker

关键在于.datePickerStyle(GraphicalDatePickerStyle())，通过这个修饰符出来的样式是好看的

```swift
//下面为时间Picker
.sheet(isPresented: $showDatePicker) {
    VStack {
        DatePicker(
            selection: $selectedDate,
            in: Date()...
        ) {
            Text("选择时间")
        }
      	//通过这个修饰符出来的样式是好看的
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .presentationDetents([.fraction(0.6),.large])
            .edgesIgnoringSafeArea(.all)

        
        Button {
            showDatePicker.toggle()
        }label: {
            Text("完成")
                .foregroundColor(Color.white)
        }
        .frame(width: 100,height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top,30)
        
    }
    .padding()
    .background(Color.white)
    .cornerRadius(15)
}
```



## 视图修饰符（View Modifier）

本质上就是一个苹果为我们提供好的实例里的方法



注意每次使用视图修饰符时，SwiftUI都会在后台创建一个新的原始视图的修饰版本，所以视图修饰符的前后位置也很关键，视图修饰符不同的位置会改变其样式,同时在使用视图修饰符后返回的值也都有所不同（肯返回some View或者text），而部分视图修饰符又要求了它接受的值，所以顺序不同可能会造成类型的bug



### background

```swift
.background {
    Image("background")
        .resizable()
        .ignoresSafeArea()
}
//渐变色
.background(
		LinearGradient(
        gradient: Gradient(
            colors: [
                Color(red: 142/255, green: 150/255, blue: 255/255),
                Color(red: 108/255, green: 93/255, blue: 211/255)
            ]
        ),
      	//从右往左渐变
        startPoint: .trailing,
        endPoint: .leading
    )
)
```

### 

### padding

padding设置在frame前面可以达到不改变设定宽高，只是内部改变padding

```swift
.padding(.horizontal, 20) //左右加入 20 点的间距
.padding(.top,30)  //在上方加上 30 点的间距
```

### frame

frame只是把一个视图限制在一定的宽度和高度之中，并不会改变视图本身的大小，但是可以利用子视图来撑大父视图，使其大小改变

```swift
.frame(width: 200) //用於將寬度限制為「200 點」
.frame(maxWidth: .infinity)	//设定最大宽度为无限
.frame(width: 100,alignment: .leading)	//并制定对齐方式
```

### boder

```swift
.border(Color.red,width: 2)
```

### opacity

```swift
.opacity(0.5)
```

### multilineTextAlignment

文字对齐方式（主要返回的some View）

```swift
.multilineTextAlignment(.leading)	//左对齐
.multilineTextAlignment(.center)	//居中对齐
.multilineTextAlignment(.trailing)	//右对齐
```

### lineSpacing

行间距，增加文字行与行之间点距离

```swift
.lineSpacing(4.0)
```

### front

```swift
.font(.title)
.font(.title2)
.font(.title3)
.font(.footnote)
```

不同字体在默认状态下的大小（单位为px）

<img src="https://gitee.com/TECNB/pic-demo/raw/master/image-20230807212415287.png" alt="image-20230807212415287" style="zoom:50%;" />

### kerning

文本里文字之间的间距

```swift
.kerning(2.0)  //设置文字之间的间距为2px
.kerning(-1.0)  //设置文字之间的间距为-1px，字体排布更加紧凑
```

### fontWeight

文字字重

```swift
.fontWeight(.black)  //比bold（默认）更大些
.fontWeight(.bold)
```

### alert

按钮下的方法

注意这个$alertIsVisible如果在foreeach里的视图组件使用的话，不要把它作为binding参数传进来，否则alertIsVisible为true后会同时唤出多个alert，导致alert里的参数传递会出错,应该把alertIsVisible作为视图组件的private变量，确保在foreach循环里，每个视图组件的变量alertIsVisible都私有（卡了我一晚上，本来是玩博德之门3的啊啊啊啊啊啊啊啊QAQ）
还有要注意的是，如果想在一个视图里使用多个alert，靠增加.alert的数量是没用的，应该通过返回多个Alert达到增加alert数量的结果

```swift
//primaryButton和secondaryButton好像在IOS15已经取消了
.alert(isPresented: $isShowingAlert) {
    Alert(
        title: Text("确定要删除吗？"), // 弹窗标题
        message: Text("删除后将会从您的标签移除数据"), // 弹窗消息
        primaryButton: .default(Text("确定"), action: {
            // 在确定按钮点击时执行的操作
            deleteTag(tagName: tagName,tagTimeIndex:tagTimeIndex)
                
        }),
        secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
    )
}
//实现多个alert
.alert(isPresented: $time) {
    if timeStop {
        return Alert(
            title: Text("确定要放弃吗？"), // 弹窗标题
            message: Text("本次计时将不会得到任何分数"), // 弹窗消息
            primaryButton: .default(Text("确定"), action: {
                // 在确定按钮点击时执行的操作
                resetCountdown()
              	//记得回收alert
                time = false
            }),
            secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
        )
    } else {
        return Alert(
            title: Text("计时结束"), // 弹窗标题
            message: Text("本次计时获得\(tagWithTime[selectedTagIndex].tagPoint!)Points"), // 弹窗消息
            primaryButton: .default(Text("确定"), action: {
                // 在确定按钮点击时执行的操作
                resetCountdown()
              	//记得回收alert
                time = false
            }),
            secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
        )
    }
}
```

### animation

如果在大的动画里有部分动画不满意，可以直接在那个部分里再加一份动画，或者动画为none，也可以加上不同的id来是SwiftUI意识到这是不同的View，还有在View里加上.transition可以控制不同的动画效果,也可以用.withAnimation精确控制动画出现的时机

```swift
					//动画的类型		//根据@state的值变化后自动产生动画
.animation(.easeInOut, value: ifShowTargetMenu)
```

![image-20230808212241299](https://gitee.com/TECNB/pic-demo/raw/master/image-20230808212241299.png)

### controlSize

任何视图都可以使用，但是只有苹果给的预设

```swift
.controlSize(.large)
```

### layoutPriority

排版的优先顺序，默认都为0

```swift
.layoutPriority(1)
```

### transition

```swift
.transition(.move(edge: .top ).combined(with: .opacity))	//从上面开始出现，并结合透明度的变化（也是动画？）
```

### cornerRadius

```swift
.cornerRadius(22.5)	//此时设置为圆角
```

### toggle

翻转Bool变量的值

```swift
ifShowMenu.toggle()
```

### ignoresSafeArea

在进行背景颜色修改时，手机底部和顶部无法正确上色，可以使用这个Modifier

```swift
ignoresSafeArea()
```

### onTapGesture 

在视图的顶端点击后的动作

```swift
.onTapGesture {
	ifShowMenu.toggle()		//这里是把ifShowMenu这个变量翻转
}
```

### colorMultiply

将整个图片的颜色变暗为黑色

```swift
Image("targetBefore")
    .colorMultiply(.black)
```

### shadow

增加阴影效果

```swift
.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // 添加阴影效果,阴影的颜色是黑色，透明度为 0.2，半径为 10，水平偏移量为 0，垂直偏移量为 5
```

### overlay

alignment：可以控制8个角的放置的位置，下面的示例固定在右下角

注意在overlay与Rectangle等视图联系时，在overlay里使用foreach等类似语句，不会报相应的foreach里参数使用错误，而是会报错：Type '() -> ()' cannot conform to 'ShapeStyle'，会导致我们找错报错的方向（卡了半个多小时，QAQ）

```swift
VStack{
    Text("被重叠的主视图")              
}.overlay(alignment:.bottomTrailing) {
    Text("覆盖的内容")
}
```

### onAppear

注意子组件里的onAppear在父组件是无效的，里面的内容不会执行

```swift
.onAppear {
  // 页面加载时，调用闭包并传递初始日期       
  self.onDateSelected?(self.selectedDate)
}
```

### sheet

通过presentationDetents控制大小（注意presentationDetents要放在sheet里面才有效，以及该修饰符IOS16才适配）

```swift
//下面为时间Picker
.sheet(isPresented: $showScorePicker) {
    Picker("分数", selection: $selectedScore) {
        ForEach(1...8, id: \.self) { score in
            Text("\(score) Point")
        }
    }
    .pickerStyle(WheelPickerStyle())
  	//控制sheet的弹出的高度和允许用户拖拽到的位置
    .presentationDetents([.fraction(0.4),.medium,.large])
    .edgesIgnoringSafeArea(.all)
    
    Button {
        showScorePicker.toggle()
    }label: {
        Text("完成")
            .foregroundColor(Color.white)
    }
        .frame(width: 100,height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top,30)
}
```



## 实践

### 毛玻璃效果

```swift
// 毛玻璃效果
if ifShowMenu {
  	//extraLight: 轻微的模糊效果，适合提供一些轻微的模糊和亮度。
		//light: 适度的模糊效果，较亮。
		//dark: 适度的模糊效果，较暗。
		//regular: 默认的模糊效果，适中的模糊程度。
    VisualEffectView(effect: UIBlurEffect(style: .light))
        .ignoresSafeArea()
           
    Color.white.opacity(0.3) // 透明的白色背景，可以增量毛玻璃的效果
        .ignoresSafeArea()
}
//下面的代码好像是和UIkit进行转化，是必须的
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
```

### 视图宽度固定为设备的一半，并置于左侧

难点在于直接使用frame固定尺寸的话，是达不到置于左侧的效果的

同时下面的例子还使得图片固定在左上角

```swift
// 抽屉式导航菜单
if ifShowMenu {
    DrawerMenu(isDrawerOpen: $ifShowMenu)
}
struct DrawerMenu: View {
    @Binding var isDrawerOpen: Bool
    var body: some View {
      	//GeometryReader也是一个视图
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image("Avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .alignmentGuide(HorizontalAlignment.leading) { _ in
                        geometry.size.width / 2 // Align to the left half of the screen
                    }
                    .padding(.leading,30).padding(.bottom,10)
              	Spacer()
            }
            .frame(width: geometry.size.width / 2, height: geometry.size.height+40) // Set VStack height to screen height
            .background(Color.white)
        }
    }
}

```

### 两种导航方式

#### NavigationStack

这种方法会在左上角留下back的返回字样

```swift
//按钮驱动版
NavigationStack{
  ZStack{
      Button{
          ifShowTarget=true
      }label: {
          //目标
          HStack{
              Image("targetBefore")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30)
                  .padding(.leading,5)
              Text("目标")
                  .frame(width: 120,alignment: .leading)
          }
      }
    //NavigationLink
    NavigationLink("", destination: TargetView(), isActive: $ifShowTarget)
  }
}
//直接点击跳转版
NavigationStack{
  ZStack{
    //NavigationLink
    NavigationLink(destination: TargetView()){
			Text("点击跳转")	
    }
  }
}
```

#### fullScreenCover

这种方法是在当前页面直接开一个新的视图，比较符合常规的导航

```swift
Button{
    ifShowTarget=true
}label: {
    //目标
    HStack{
        Image("targetBefore")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .padding(.leading,5)
        Text("目标")
            .frame(width: 120,alignment: .leading)
    }
}

if ifShowTarget{
    NullView()
        .fullScreenCover(isPresented: $ifShowTarget, content: {
            // 在此处放置其他您希望在全屏覆盖视图上显示的内容
            TargetView()
        })
}
```

### API网络请求

#### POST请求

第一步是建立好结构体接收传回来的参数，可以通过postman获取到传回来的JSON数据，根据数据进行书写

第二步建立urlRequest，并给出链接的设定，包括请求方式（httpMethod），请求头（header），请求参数（httpBody），其中请求参数这里需要转化为Data类型的数据，如果是直接传入String则使用userEmail.data(using: .utf8)转化，如果是json数据则进行转化：

1、let requestData = ["userEmail": userEmail]

2、let jsonData = try JSONSerialization.data(withJSONObject: requestData)



第三步是创建 URLSession 数据任务，传回来的数据也要通过解码：

JSONDecoder().decode(ResponseData.self, from: data)
最后还有处理各种出错情况

![image-20230814212122622](https://gitee.com/TECNB/pic-demo/raw/master/image-20230814212122622.png)

注意下面的例子只是将类型粗糙的分类，具体怎么请求最主要要是要看后端的api的需求



#### 例子1

在大体上该例子常用于获取数组类型的数据

##### JSON格式

该格式里的data里最外围是[ ]

```json
{
    "code": "00000",
    "message": "一切 ok",
    "data": [
        {
            "id": null,
            "userId": null,
            "userEmail": null,
            "targetName": "测试1",
            "targetDescribe": "hhh",
            "targetColor": null,
            "targetPoint": "3",
            "deadline": null,
            "status": "0",
            "deadlineString": null,
            "ifPoints": null,
            "ifTargetNull": null,
            "ifTargetUpdate": null,
            "targetId": "1692785063700615169"
        },
        {
            "id": null,
            "userId": null,
            "userEmail": null,
            "targetName": "测试2",
            "targetDescribe": "hhh",
            "targetColor": null,
            "targetPoint": "7",
            "deadline": null,
            "status": "0",
            "deadlineString": null,
            "ifPoints": null,
            "ifTargetNull": null,
            "ifTargetUpdate": null,
            "targetId": "1692785123469447170"
        }
    ],
    "ok": true
}
```

##### 代码

在细节上该例子讲参数写死，并返回值，且传给后端的数据为text( let jsonData = userEmail.data(using: .utf8) )

```swift
// TagDataManager.swift
import Foundation

// 响应数据结构体，用于解码服务器响应的 JSON 数据
struct ResponseData: Decodable {
    let data: [TagWithTime]  // 包含标签数组的数据字段
}

// 标签结构体，用于解码标签数据
struct TagWithTime: Decodable, Identifiable {
    let id: String  // 标签的唯一标识符，服务器返回的是字符串类型
    let tagName: String  // 标签名称
    let tagDescribe: String  // 标签描述
    let tagHour: String  // 标签时间的小时部分（字符串类型）
    let tagMinute: String  // 标签时间的分钟部分（字符串类型）
    let tagPoint: String  // 标签的积分值（字符串类型）
    // 其他字段省略，如果需要可以添加
}

// 标签数据管理类
class TagDataManager {
    // 获取标签数据的方法
    func fetchTagData(completion: @escaping ([TagWithTime]?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/get") else {
            completion(nil, nil)  // 处理 URL 创建错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = "3489044730@qq.com"
        
        do {
            // 将请求参数转换为 JSON 数据
            let jsonData = userEmail.data(using: .utf8)
            
            // 创建一个 URL 请求
            var request = URLRequest(url: url)
            request.httpMethod = "POST"  // 设置请求方法为 POST
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData  // 设置请求体为 JSON 数据
            
            // 创建 URLSession 数据任务
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        // 解码服务器响应的 JSON 数据
                        let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: data)
                        completion(decodedResponse.data, nil)  // 将解码后的标签数据传递给回调闭包
                    } catch {
                        print("JSON decoding error: \(error)")
                        completion(nil, error)  // 处理解码错误情况
                    }
                } else if let error = error {
                    completion(nil, error)  // 处理网络请求错误情况
                }
            }.resume()  // 启动数据任务
        } catch {
            completion(nil, error)  // 处理其他错误情况
        }
    }
}
//TagView.swift
import SwiftUI

struct TagView: View {
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=2
    @State private var ifDelete:Bool=false
    
    @State private var tagWithTime: [TagWithTime] = []
    @State private var ifshowTagDetailBNull = false //判断标签里是否有数据没有数据
    
    let tagDataManager = TagDataManager()
    var body: some View {
        ZStack{
            // 目标视图的内容
            VStack{
                //第一行的Nav
                NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
              	//获取的标签数据的展示处
                ForEach(tagWithTime, id: \.id) { tag in
  TagItemView(ifDelete:$ifDelete,isShowingAlert:$isShowingAlert,tagName:tag.tagName,tagDescribe:tag.tagDescribe)
                }
                Spacer()
            }
          //在页面出现时就调用获取标签数据的方法fetchTagData()
        }.onAppear {
             fetchTagData()
        }
    }
    func fetchTagData() {
            tagDataManager.fetchTagData { fetchedData, error in
                if let fetchedData = fetchedData {
                    ifshowTagDetailBNull = fetchedData.isEmpty
                    tagWithTime = fetchedData
                } else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
}
```

#### 例子2

在大体上该例子常用于删除数据

##### JSON格式

该格式就是后端返回的值全是null

```swift
{
    "code": "00000",
    "message": "一切 ok",
    "data": {
        "id": null,
        "userId": null,
        "picUrl": null,
        "tagName": null,
        "tagDescribe": null,
        "tagColor": null,
        "tagPoint": null,
        "tagHour": null,
        "tagMinute": null,
        "creatTime": null,
        "userEmail": null,
        "ifRepeat": null,
        "ifTagNull": null,
        "ifTagUpdate": null,
        "tagId": null
    },
    "ok": true
}
```

##### 代码

在细节上该例子不返回任何参数，这里data明明由{ }包裹，但是却使用[TagWithTime]类型解密，还没有报错的原因在于，该方法的并不需要访问里面的数据，completion也不返回[TagWithTime]，，所以可以这么使用，不能使用[TagWithTime]类型解密的例子为例子4

```swift
// TagDataManager.swift
import Foundation

struct TagResponseData: Decodable {
    let data: [TagWithTime]
}

struct TagWithTime: Decodable, Identifiable {
    let id: String?  // 注意这里的 id 是 String 类型，因为服务器返回的数据是 String
    let tagName: String?
    let tagDescribe: String?
    let tagHour: String?
    let tagMinute: String?
    let tagPoint: String?
    let ifTagNull:String?
}

class TagDataManager {
    // 删除标签的方法
    func deleteTag(tagName: String, completion: @escaping (Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/delete") else {
            completion(nil) // 处理错误情况
            return
        }
        // 准备请求参数
        let tagName = tagName
        // 将请求参数转换为 JSON 数据
        let jsonData = tagName.data(using: .utf8)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据
        
        // 创建 URLSession 数据任务
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }.resume() // 启动数据任务
    }
}

//TagItemView.swift
import SwiftUI

struct TagItemView: View {
    let tagDataManager = TagDataManager()
    @Binding var tagWithTime:[TagWithTime]
    let tagTimeIndex:Int
    
    var body: some View {
        HStack{
            if ifDelete{
                Button{
                    isShowingAlert = true // 点击按钮时设置弹窗显示状态为 true
                }label: {
                    Image("x")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12,height: 12)
                }.alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("确定要删除吗？"), // 弹窗标题
                        message: Text("删除后将会从您的标签移除数据"), // 弹窗消息
                        primaryButton: .default(Text("确定"), action: {
                            // 在确定按钮点击时执行的操作
                            deleteTag(tagName: tagName,tagTimeIndex:tagTimeIndex)
                        }),
                        secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
                    )
                }
            }else{
              
            }
        }
    }
    func deleteTag(tagName:String,tagTimeIndex:Int){
        tagDataManager.deleteTag(tagName: tagName) { error in
            if error == nil {
                deleteSuccess=true
                tagNum-=1
                if tagNum==0{
                    ifshowTagDetailBNull=true
                }
                tagWithTime.remove(at: tagTimeIndex)
                print("删除标签成功")
            } else {
                print("删除标签失败")
            }
        }
    }
}
```

#### 例子3

在大体上该例子用于检验用户是否注册，利用completion返回Int，方便用户直接跳转到登录界面或者注册界面

##### JSON格式

该格式就是后端的代码就是return null

```JSON
//用户注册过
{
    "code": "00000",
    "message": "一切 ok",
    "data": {
        "userId": null,
        "userName": null,
        "picData": null,
        "picUrl": null,
        "userEmail": "3489044730@qq.com",
        "userPassword": null,
        "userCode": null,
        "completeTarget": null,
        "point": null,
        "ifUpdate": null,
        "openId": null
    },
    "ok": true
}

//用户没有注册过
//直接没有任何返回值
```



##### 代码

在细节上该例子传入的参数是动态的，返回简单参数如(Int)，利用completion返回起来简单，且使用时直接调用方法

```swift
//UserDataManager.swift
import Foundation

struct UserResponseData: Decodable {
    let code: String?
}

class UserDataManager{
    func checkEmail(email: String, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/home")
        else {
            completion(12) // URL错误的情况下的备用值
            return
        }
        // 准备请求参数
        let userEmail = email
        // 将请求参数转换为 JSON 数据
        let jsonData =  userEmail.data(using: .utf8)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(UserResponseData.self, from: data)
                    if let code = decodedData.code {
                        DispatchQueue.main.async {
                            if code == "nil" {
                                completion(12)
                            } else {
                                completion(11)
                            }
                        }
                    }
                } catch {
                    print(error)
                    completion(12) // 错误情况
                }
            }
        }.resume()
        
    }
}
//HomeView.swift
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var userData: UserData
  	let userDataManager = UserDataManager() // 实例化UserDataManager

    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Button{
              	//isValidQQEmailFormat为检验QQ邮箱的合法性
                let isValidQQEmail = isValidQQEmailFormat(email: userData.userEmail)
                if isValidQQEmail{
                  	//这里使用了API请求的checkEmail方法
                  	//并直接返回了retrurnShowWhichView的值，方便用户直接跳转到登录界面或者注册界面
                    userDataManager.checkEmail(email: userData.userEmail) { retrurnShowWhichView in
                        showWhichView = retrurnShowWhichView
                        timerTriggered = true
                    }
                }else{
                    ifshowTextAlert=true
                }
            }label: {
                HStack(){
                    Text("继续")
                }
            }
        }.padding(15)
            .overlay {
                if ifshowTextAlert{
                    TextAlertView(textContant:$textContant,ifshowTextAlert:$ifshowTextAlert)
                        
                }
            }
    }
}
```



#### 例子4

大体上该例子作用于获取该用户的账户信息，一般不是数组

##### JSON格式

注意json返回的数据不是数组，且要获取里面的数据时时，不要为结构体或者类加上[]

```swift
{
    "code": "00000",
    "message": "一切 ok",
    "data": {
        "id": null,
        "userId": null,
        "point": null,
        "pointType": null,
        "pointName": null,
        "pointDescribe": null,
        "pointDate": null,
        "userEmail": "3489044730@qq.com",
        "userTimeP": "过去一天",
        "pointAll": "0",
        "progress": "0",
        "pointInsistence": "0",
        "pointAverage": "0.0",
        "completeTarget": "0",
        "completeTargetRate": "0.0",
        "ifProgress": null
    },
    "ok": true
}
```

##### 代码

在细节上该例子解析出来的数据放在类里面，而不是数组，注意拆包和初始化时候的使用可选项

```swift
//StoreDataManager.swift
import Foundation

struct PointRecordResponseData: Decodable {
    let data: PointRecordData
}
//这里用结构体也可以
class PointRecordData:Decodable{
    let userTimeP, pointAll, progress: String
    let pointInsistence, pointAverage, completeTarget, completeTargetRate: String
    
}

class UserDataManager{
    // 获取用户目标完成情况的方法
    func fetchPointRecordData(userTimeP:String,completion: @escaping (PointRecordData?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/pointRecord/get") else {
            completion(nil, nil) // 处理错误情况
            return
        }
        // 准备请求参数
        let userEmail = "3489044730@qq.com"
        let userTimeP=userTimeP
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "userTimeP": userTimeP]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
            
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据
            
        // 创建 URLSession 数据任务
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // 解码服务器响应的数据
                    let decodedResponse = try JSONDecoder().decode(PointRecordResponseData.self, from: data)
                        completion(decodedResponse.data, nil)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume() // 启动数据任务
    }
}
//UserView.swift
import SwiftUI

struct UserView: View {
    let userDataManager = UserDataManager() // 实例化UserDataManager
    
    @State private var userTimeP:String="过去一周"
    
    @State private var pointRecordData:PointRecordData?
    let pointAll:String="10"
    var body: some View {
        ZStack{
            // 目标视图的内容
            VStack{
                ZStack{
                    VStack(alignment: .leading){
                        Text("获取分数")
                        HStack{
                            Text((pointRecordData?.pointAll) ?? "0")
                        }
                        Text("努力的\(String(userTimeP.suffix(2)))！")
                    }
                }
                ZStack{
                    VStack(alignment: .leading){
                        Text("进步")
                        HStack{
                            Text((pointRecordData?.progress) ?? "0")
                        }
                    }
                }
                
                HStack{
                    VStack{
                        VStack(alignment: .leading){
                            HStack{
                                Text("\((pointRecordData?.pointInsistence) ?? "0")\n连续得分")
                            }
                        }
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text("\((pointRecordData?.completeTargetRate) ?? "0.0")%")
                                }
                            }
                        }
                    }
                    VStack{
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text((pointRecordData?.pointAverage) ?? "0.0")
                                }
                            }
                        }
                        
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text("\((pointRecordData?.completeTarget) ?? "0")个目标")
                                }
                            }
                        }
                    }
                }
            }
            if  ifShowUserMenu{
                //下面是targetMenu,使用fetchPointRecordData()方法
                if userTimeP=="过去一周"{
                    VStack{
                        Button{
                            userTimeP="过去一天"
                            fetchPointRecordData()
                        }label: {
                            Text("过去一天")
                        }
                        Button{
                            userTimeP="过去一月"
                            fetchPointRecordData()
                        }label: {
                            Text("过去一月")
                        }
                    }
                }
            }
        }
    }
    func fetchPointRecordData() {
        userDataManager.fetchPointRecordData(userTimeP: userTimeP) { fetchedData, error in
            if let fetchedData = fetchedData {
                pointRecordData=fetchedData
                print((pointRecordData?.pointAll)!)
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

```





### 自定义文字弹窗提示

因为swiftui中只有alert，且这个视图在官方的规定下是必定要有按钮的，所以为了满足项目的需求，我进行了自定义的文字弹窗提示，该弹窗还会在几秒后自动消失

```swift
//需要使用时只需要overlay在最外部的视图就行
struct TextAlertView: View {
    //这里控制了视图的计时消失
    @State private var isTextVisible = true
    
    @Binding var textContant:String
    //这里的变量ifshowTextAlert使得该视图能在需要时多次出现
    @Binding var ifshowTextAlert:Bool
    var body: some View {
        VStack {
            if isTextVisible {
                Text(textContant)
                    .foregroundColor(Color.white)
                    .padding([.top,.bottom],10)
                    .padding([.leading,.trailing],15)
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            withAnimation {
                                isTextVisible = false
                            }
                            ifshowTextAlert=false
                        }
                    }
            }
        }
    }
}
```

### foreach两种方式获得index

1、利用Array包装数组获取到index,该方法获取元素使用类似target.targetName的方式

```swift
ForEach(Array(targetNoTime.enumerated()), id: \.element.id) { (index, target) in
    TargetItemView(targetName: target.targetName!,
                   targetDescribe: target.targetDescribe!,
                   targetId: target.targetId!,
                   targetPoint:target.targetPoint! ,
                   targetStatus: target.status!,
                   targetTimeIndex:index
    )
}
```

2、使用数组方法中的.indices，获取到index，该方法获取元素使用类似tagWithTime[index].tagName的方式

```swift
ForEach(tagWithTime.indices, id: \.self) { index in
    TagItemView(tagName: tagWithTime[index].tagName!,
                tagDescribe:tagWithTime[index].tagDescribe!,
                tagWithTime:$tagWithTime,
                tagTimeIndex:index)
}
```

自定义横向日期显示

```swift
import SwiftUI

struct TargetNav1View: View {
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // 日期格式化器，用于获取星期几的缩写
        return formatter
    }()
    
    @State private var selectedDayIndex = 0 // 当前选中的VStack索引
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(0..<30) { index in
                    VStack {
                        Text(self.dayName(for: index))
                            .foregroundColor(self.selectedDayIndex == index ? .black : .secondary)
                            .font(.system(size: 12)) // 设置星期几文本的字体大小
                        Text(self.dayNumber(for: index))
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(rgba: (207, 200, 255, 1)))
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: self.gradientColors(for: index)
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(22.5)
                            .onTapGesture { // 添加点击手势
                                self.selectedDayIndex = index // 更新选中的索引
                            }
                    }
                    .cornerRadius(22.5) // 设置VStack的圆角
                }
            }
            .padding(.top, 20) // 设置顶部内边距
        }.padding([.leading,.trailing],20)
    }
    
    private func dayName(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        return dateFormatter.string(from: currentDate) // 获取星期几的缩写文本
    }
    
    private func dayNumber(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        let day = calendar.component(.day, from: currentDate) // 获取日期的天数部分
        return "\(day)" // 将天数转换为字符串
    }
    
    private func gradientColors(for index: Int) -> [Color] {
        if self.selectedDayIndex == index {
            return [
                Color(red: 142/255, green: 150/255, blue: 255/255),
                Color(red: 108/255, green: 93/255, blue: 211/255)
            ] // 如果选中，返回选中时的渐变色
        } else {
            return [
                Color.clear,
                Color.clear
            ] // 如果未选中，返回透明颜色
        }
    }
}

```

### 自定义日期比较器

难点有两个，第一点是仅关注日期部分，忽略时间的影响，解决方法是把传进来的时间设置为0小时、0分钟、0秒，来忽略小时和分钟对日期差的干扰，并且用calendar.dateComponents(_:from:to:)来计算目标日期和选定日期的月份和日子的差异，第二点在于进入目标页面时间差的初值问题，解决方法是在获取数据时，直接调用求时间差的方法

```swift
//TargetNav1View.swift
import SwiftUI

struct TargetNav1View: View {
    let selectedDate: Date=Date() // 接收初始日期的参数
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // 日期格式化器，用于获取星期几的缩写
        return formatter
    }()
    
    @State private var selectedDayIndex = 0 // 当前选中的VStack索引
    
    var onDateSelected: ((Date) -> Void)? // 用于接收选中日期的闭包
    // 初始化时执行计算逻辑

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(0..<30) { index in
                    VStack {
                        Text(self.dayName(for: index))
                            .foregroundColor(
                                self.selectedDayIndex == index ? .black : .secondary
                            )
                            .font(.system(size: 12)) // 设置星期几文本的字体大小
                        Text(self.dayNumber(for: index))
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(rgba: (207, 200, 255, 1)))
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: self.gradientColors(for: index)
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(22.5)
                        
                            // 添加点击手势
                            .onTapGesture {
                                self.selectedDayIndex = index // 更新选中的索引
                                if let selectedDate = self.calendar.date(byAdding: .day, value: index, to: Date()) {
                                    self.onDateSelected?(selectedDate) // 调用闭包，并传递选中的日期
                                }
                                
                            }
                    }
                    .cornerRadius(22.5) // 设置VStack的圆角
                }
            }
            .padding(.top, 20) // 设置顶部内边距
        }.padding([.leading,.trailing],20)
    }
    
    private func dayName(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        return dateFormatter.string(from: currentDate) // 获取星期几的缩写文本
    }
    
    private func dayNumber(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        let day = calendar.component(.day, from: currentDate) // 获取日期的天数部分
        return "\(day)" // 将天数转换为字符串
    }
    
    private func gradientColors(for index: Int) -> [Color] {
        if self.selectedDayIndex == index {
            return [
                Color(red: 142/255, green: 150/255, blue: 255/255),
                Color(red: 108/255, green: 93/255, blue: 211/255)
            ] // 如果选中，返回选中时的渐变色
        } else {
            return [
                Color.clear,
                Color.clear
            ] // 如果未选中，返回透明颜色
        }
    }
}

//TargetView.swift
//这里只是部分代码，在网页一开始初始化的代码没有不一样，所以只给个关键部分
TargetNav1View(onDateSelected: { selectedDate in
    for _ in 0..<targetWithTime.count {
        targetDateInfo.append(TargetDateInfo(dayDifference: 0, timeString: ""))
    }
    
    let calendar = Calendar.current
    
    for index in 0..<self.targetWithTime.count {
        print(index)
        let dateFormatter = DateFormatter()
        // 给出将String类型转化为Date类型的格式
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        // 将deadline字符串转换为日期对象
        if let deadlineDate = dateFormatter.date(from: self.targetWithTime[index].deadline!),
            let startDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate) {
            
            print("startDate:",startDate)
            
            // 获取目标日期的月份和日子
            let deadlineComponents = calendar.dateComponents([.month, .day], from: deadlineDate)
            
            // 获取选定日期的月份和日子
            let selectedComponents = calendar.dateComponents([.month, .day], from: startDate)
              
            // 用calendar.dateComponents(_:from:to:)来计算目标日期和选定日期的月份和日子的差异。这样，您就可以得到只有月份和日子的差异，而不考虑时间部分的影响。
            if let dayDifference = calendar.dateComponents([.day], from: selectedComponents, to: deadlineComponents).day {
                self.dayDifference = dayDifference
                print("index:",index)
                targetDateInfo[index].dayDifference = dayDifference
                targetDateInfo[index].timeString = ""
                
                if dayDifference < 0 {
                    // 相差小于0天，显示截止时间的月份和日子
                    let monthDayFormatter = DateFormatter()
                    monthDayFormatter.dateFormat = "MM.dd"
                    let monthDayString = monthDayFormatter.string(from: deadlineDate)
                    self.monthDayString = monthDayString
                    targetDateInfo[index].timeString = monthDayString
                    print("Month and Day: \(monthDayString)")
                } else if dayDifference == 0 {
                    // 相差等于0天，显示截止时间的时间部分
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm"
                    let timeString = timeFormatter.string(from: deadlineDate)
                    self.timeString = timeString
                    targetDateInfo[index].timeString = timeString
                    print("Time: \(timeString)")
                } else if dayDifference > 0 {
                    print("Day difference: \(dayDifference)")
                }
            }
        }
    }
})

```



### 三种Picker

```swift
//一列Picker
.sheet(isPresented: $showScorePicker) {
    Picker("分数", selection: $selectedScore) {
        ForEach(1...8, id: \.self) { score in
            Text("\(score) Point")
        }
    }
    .pickerStyle(WheelPickerStyle())
  	//控制sheet的弹出的高度和允许用户拖拽到的位置
    .presentationDetents([.fraction(0.4),.medium,.large])
    .edgesIgnoringSafeArea(.all)
    
    Button {
        showScorePicker.toggle()
    }label: {
        Text("完成")
            .foregroundColor(Color.white)
    }
        .frame(width: 100,height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top,30)
}
//两列Picker
.sheet(isPresented: $showDatePicker) {
    VStack {
        DatePicker(
            selection: $selectedDate,
            in: Date()...
        ) {
            Text("选择时间")
        }
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .presentationDetents([.fraction(0.6), .large])
        .edgesIgnoringSafeArea(.all)
        
        Button {
            showDatePicker.toggle()
            deadlineString = dateFormatter.string(from: selectedDate)
        } label: {
            Text("完成")
                .foregroundColor(Color.white)
        }
        .frame(width: 100, height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top, 30)
    }
    .padding()
    .background(Color.white)
    .cornerRadius(15)
}

//DatePicker
.sheet(isPresented: $showDatePicker) {
    VStack {
        DatePicker(
            selection: $selectedDate,
            in: Date()...
        ) {
            Text("选择时间")
        }
      	//通过这个修饰符出来的样式是好看的
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .presentationDetents([.fraction(0.6),.large])
            .edgesIgnoringSafeArea(.all)

        
        Button {
            showDatePicker.toggle()
        }label: {
            Text("完成")
                .foregroundColor(Color.white)
        }
        .frame(width: 100,height: 40)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(.top,30)
        
    }
    .padding()
    .background(Color.white)
    .cornerRadius(15)
}
```



### 崩溃总结

因为swiftui的崩溃日志实在是难以读懂，所以根据经验总结了一下崩溃的原因

首先是数组越界问题，比如说常见的remove之后，还在用index去访问数组的元素，就会导致数组越界，所以看来还是避免使用index下标去访问数组元素，还要注意获取数据和使用数据的先后

其次是拆包问题，常见于处理后端数据的时候，后端传进来的数据可能为空，但是我们并没有使用可选型去接收这个参数，就会导致崩溃 的产生

### 点击更换样式

利用onTapGesture通过点击更换index，再使用三元运算符判断更改样式

```swift
struct TargetNav1View: View {
    let selectedDate: Date=Date() // 接收初始日期的参数
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // 日期格式化器，用于获取星期几的缩写
        return formatter
    }()
    
    @State private var selectedDayIndex = 0 // 当前选中的VStack索引
    
    var onDateSelected: ((Date) -> Void)? // 用于接收选中日期的闭包
    // 初始化时执行计算逻辑

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(0..<30) { index in
                    VStack {
                        Text(self.dayName(for: index))
                            .foregroundColor(
                                self.selectedDayIndex == index ? .black : .secondary
                            )
                            .font(.system(size: 12)) // 设置星期几文本的字体大小
                        Text(self.dayNumber(for: index))
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(rgba: (207, 200, 255, 1)))
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: self.gradientColors(for: index)
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(22.5)
                        
                            // 添加点击手势
                            .onTapGesture {
                                self.selectedDayIndex = index // 更新选中的索引
                                if let selectedDate = self.calendar.date(byAdding: .day, value: index, to: Date()) {
                                    self.onDateSelected?(selectedDate) // 调用闭包，并传递选中的日期
                                }
                                
                            }
                    }
                    .cornerRadius(22.5) // 设置VStack的圆角
                }
            }
            .padding(.top, 20) // 设置顶部内边距
        }.padding([.leading,.trailing],20)
    }
    
    private func dayName(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        return dateFormatter.string(from: currentDate) // 获取星期几的缩写文本
    }
    
    private func dayNumber(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        let day = calendar.component(.day, from: currentDate) // 获取日期的天数部分
        return "\(day)" // 将天数转换为字符串
    }
    
    private func gradientColors(for index: Int) -> [Color] {
        if self.selectedDayIndex == index {
            return [
                Color(red: 142/255, green: 150/255, blue: 255/255),
                Color(red: 108/255, green: 93/255, blue: 211/255)
            ] // 如果选中，返回选中时的渐变色
        } else {
            return [
                Color.clear,
                Color.clear
            ] // 如果未选中，返回透明颜色
        }
    }
}
```

### 获取到数据后再显示页面

这个例子运用的场景，在页面一加载就需要显示的数据，那么这个时候异步执行的网络请求方法，还没有获取到数据，这时候视图上获取数据就会获取不到，或者直接数据越界（因为我们一般数据设置为空数组[ ]），

有三种方法解决，第一种比如说为数据赋初值，这样项目就不会崩溃了，但是就像前面说的这时候还没有获取到数据，那么页面就会一闪而过一个奇怪的数据，

所以使用第二种方法，在异步执行的网络请求方法完成后，在方法里赋值isDataLoaded代表数据加载完成，并把isDataLoaded作为if的条件，为true再显示页面，虽然其实页面会显示的慢一点，但是这点时间用户看不出来，是比较好的选择，

还有第三种方法，比如说之前我在微信小程序里，通过在该页面的前一个页面，提前获取到数据，然后再传递给该页面，就可以到达一样的效果，唯一比较麻烦的是一般这样出现在登录界面，就需要进行多种数据的获取，会导致一定的卡顿

```swift
if isDataLoaded{
  //数据加载完成后显示页面
}

func fetchTagData() {
    tagDataManager.fetchTagData { fetchedData, error in
        if let fetchedData = fetchedData {
            tagWithTime = fetchedData
            tagNum=tagWithTime.count
            if tagWithTime[0].ifTagNull=="1"{
                ifshowTagDetailBNull=true
            }
            print(tagWithTime)
            isDataLoaded = true  // 数据加载完成
            
        } else {
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
        }
    }
}
```

### 自定义倒计时器

```swift
func startCountdown() {
    // 计算初始的剩余时间（秒数）
    let hoursInSeconds = (Int(tagWithTime[selectedTagIndex].tagHour!) ?? 1) * 3600
    let minutesInSeconds = (Int(tagWithTime[selectedTagIndex].tagMinute!) ?? 30) * 60
    remainingTimeInSeconds = TimeInterval(hoursInSeconds + minutesInSeconds)

    // 创建定时器
    countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        if remainingTimeInSeconds > 0 {
            remainingTimeInSeconds -= 1
        } else {
            timer.invalidate() // 倒计时结束，停止定时器
            // 进行倒计时结束后的操作，例如显示提示信息
            time=true
            timeStop=false
            finishTag(tagName: tagWithTime[selectedTagIndex].tagName!)
            userData.point+=Int(tagWithTime[selectedTagIndex].tagPoint!)!
        }
    }
}
```





## swiftui基础

### 数组

可以通过[结构体]的方式，来定义数组

注意在通过targetDateInfo[index].dayDifference去添加数组的时候，需要先初始化好targetDateInfo，不然index会使targetDateInfo越界，之前在Vue里面经常直接使用push的方法，所以忘记了这点

```swift
struct TargetDateInfo {
     var dayDifference: Int
     var timeString: String
 }
@State private var targetDateInfo:[TargetDateInfo]=[]

//初始化数组
for _ in 0..<targetWithTime.count {
    targetDateInfo.append(TargetDateInfo(dayDifference: 0, timeString: ""))
}

for index in 0..<self.targetWithTime.count {
                    
    let dateFormatter = DateFormatter()
    //给出将String类型转化为Date类型的格式
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    // 将deadline字符串转换为日期对象
    if let deadlineDate = dateFormatter.date(from: self.targetWithTime[index].deadline!),
       
        // 将选中日期的时间部分设置为0小时、0分钟、0秒
       // 这样就可以忽略小时和分钟对日期差的干扰
        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate) {
        
        print("startDate:",startDate)
        let calendar = Calendar.current
        
        // 计算日期差异，仅关注日期部分
        // 这里获取到的是包含天数的完整天数相差信息(components)
        let components = calendar.dateComponents([.day], from: startDate, to: deadlineDate)
        
        // 这里获取到的才是天数差(components.day)
        if let dayDifference = components.day {
            self.dayDifference=dayDifference
            print("index:",index)
            targetDateInfo[index].dayDifference=dayDifference
            targetDateInfo[index].timeString=""
            if dayDifference <= 0 {
                // 相差小于0天，显示截止时间的时间部分
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                let timeString = timeFormatter.string(from: deadlineDate)
                self.timeString=timeString
                targetDateInfo[index].timeString=timeString
                print("Time: \(timeString)")
            } else {
                print("Day difference: \(dayDifference)")
            }
        }
    }
}
```



### 状态（@State、@StateObject）

@StateObject在跟踪类/结构体内的属性变化时使用

SwiftUI的状态能够使body在状态改变时重新渲染（相当于Vue里{{state}}）

```swift
struct ContentView: View {
    @State private var alertIsVisible:Bool=false
    var body: some View {
        VStack {
            Button(action: {
                self.alertIsVisible=true
            }) {
                Text("点我")
            }
          		//注意这个$alertIsVisible前面的$意味着binding(双向绑定)
          	 .alert(isPresented: $alertIsVisible , content: {
                return Alert(title: Text("你好"),message: 
                             Text("这是弹窗"),dismissButton: .
                             default(Text("好好好 ")))
            })
        }
        .padding()
    }
}
```



### 绑定（@Binding）

其实就是绑定传入的值

```swift
DrawerMenu(isDrawerOpen: $ifShowMenu, ifShowTarget: $ifShowTarget)
struct DrawerMenu: View {
    @Binding var isDrawerOpen: Bool
    @Binding var ifShowTarget:Bool
    var body: some View {
      //DrawerMenu视图里的内容
    }
}
```

### 全局变量（@EnvironmentObject）

定义一个实现ObservableObject协议的类，需要跟踪的数值使用@Published 修饰

```swift
//  UserDataManager.swift
class UserData: ObservableObject {
    @Published var userEmail: String = ""
}
```



通过.envrionmentObject(对象)将一个对象放置到环境中

```swift
//  HabeetApp.swift
@main
struct HabeetApp: App {
    @StateObject private var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
```

在view中使用这个对象,@EnvironmentObject修饰对象

```swift
//  HomeView.swift

struct HomeView: View {
  @EnvironmentObject private var userData: UserData
  var body: some View {
    TextField("请输入邮箱", text: $userData.userEmail)
  }
}

```



注意，如果预览没有.envrionmentObject()设置环境中的对象，程序就会崩溃，包括导航到需要用的视图
```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}

```



### 单元测试（Unit Text）

```swift
import XCTest
@testable import Habeet

final class HabeetTests: XCTestCase {
    //在一开始启动时，game可能为空，但是setup里game肯定是有值的，所以定义为可选类型（！）
    var game:Game!

    override func setUpWithError() throws {
        game=Game()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        game=nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      	//断言测试（Assert）
        XCTAssertEqual(game.points(sliderValue: 50), 999)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
		//性能实例一般用不到
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

```

### 项目结构

```sql
ProjectRoot
├── Views
│   ├── ContentView.swift
│   ├── MainContent.swift
│   ├── DrawerMenu.swift
│   ├── TargetView.swift
│   └── ...other view files
├── Extensions
│   ├── Color+Extensions.swift
│   ├── View+Extensions.swift
├──   └── ...other extension files
├── Helpers
│   ├── Constants.swift
│   └── ...other helper files
└── Models
    ├── Target.swift
    └── ...other model files
```



## 快捷键

建立新的 Swift 文件：command+N

将视图包含进 VStack、HStack、ZStack：选中视图+command（Embed in xxx）

要將存放代码的 VStack、HStack、ZStack 提取出来（新的stuck）：选中视图+command  (Extract Subview)

插入不同视图：command+Shift+L（选中后可以用鼠标拖拽到不同位置，同时不同位置也可以达成自动创建Stack的效果）

移动代码到 上一行/下一行：option+command+[ / ]

实机调试：command+R

刷新预览：option+command+P

查看视图内属性的详情：option+点击

只构建项目不调试：command+B

进行单元测试：command+U

