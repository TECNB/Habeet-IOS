//
//  Timer.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var ifShowTargetMenu:Bool=false
    @State private var ifShowTagMenu:Bool=false
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int = 0
    @State private var ifDelete:Bool=false
    
    //下面为获取目标数据所需要的变量
    @State private var targetTime: [TargetTime] = []
    @State private var targetNoTime: [TargetTime] = []
    @State private var targetWithTime: [TargetTime] = []
    @State private var targetCompleted: [TargetTime] = []
    @State private var targetExpire: [TargetTime] = []
    
    @State private var ifshowTargetMenuNull:Bool=false
    
    @State private var targetNoTimeNum:Int=99
    @State private var targetWithTimeNum:Int=99
    @State private var targetCompletedNum:Int=99
    @State private var targetExpireNum:Int=99
    
    @State private var tagNum:Int=0
    @State private var tagWithTime: [TagWithTime] = []
    @State private var selectedTagIndex = 0
    @State private var ifshowTagDetailBNull = false //判断标签里是否有数据没有数据

    
    @State private var dayDifference:Int=0
    @State private var timeString:String="0"
    @State private var monthDayString:String="0"
    
    @State private var selectedDate:Date=Date()
    
    @State private var textContant:String="完成目标"
    
    struct TargetDateInfo {
        var dayDifference: Int
        var timeString: String
    }
    @State private var targetDateInfo:[TargetView.TargetDateInfo]=[]
    
    @State private var deleteSuccess:Bool=false
    
    @State private var isDataLoaded = false
    
    @State private var ifBegin=false
    @State private var time=false
    @State private var timeStop=false
    @State private var remainingTimeInSeconds: TimeInterval = 0
    @State private var countdownTimer: Timer?

    
    let targetDataManager = TargetDataManager()
    let tagDataManager = TagDataManager()
    
    var body: some View {
        
        ZStack{
            if isDataLoaded {
                VStack {
                    if ifShowMenu{
                        HStack{
                            
                        }.frame(height: 45.8)
                        
                    }else{
                        //这里是第一行的Nav
                        NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
                            .padding(.top,50)
                        
                    }
                    
                    //这是第二行的目标Nav
                    HStack(spacing: 250.0){
                        Text("目标")
                            .padding(.leading, 20.0)
                            .frame(height: 40)
                        if ifShowTargetMenu{
                            Button{
                                // 切换 ifShowTargetMenu 的状态
                                ifShowTargetMenu.toggle()
                            }label: {
                                Image("arrowUp")
                                    .padding(.trailing, 20.0)
                                
                            }
                            
                        }else{
                            Button{
                                // 切换 ifShowTargetMenu 的状态
                                ifShowTargetMenu.toggle()
                            }label: {
                                Image("arrowDown")
                                    .padding(.trailing, 20.0)
                                
                            }
                        }
                    }
                    .background(Color(red: 250/255, green: 250/255, blue: 255/255))
                    .cornerRadius(22.5)
                    .frame(width: 350.0, height: 60.0)
                    .animation(.easeInOut, value: ifShowTargetMenu)
                    
                    
                    Spacer()
                    // 添加一个背景为白色的视图，放在目标下方，覆盖住学习的VStack
                    Rectangle()
                        .fill(Color.white)
                        .overlay {
                            //这是主要的计时View
                            VStack{
                                Image("Progress")
                                    .frame(width: 330,height: 280)
                                //下面为tagMenu的选择按钮
                                Button{
                                    if ifshowTagDetailBNull==true{
                                        textContant="没有标签，快去建立吧"
                                    }else{
                                        ifShowTagMenu.toggle()
                                    }
                                }label: {
                                    if ifshowTagDetailBNull==true{
                                        
                                    }else{
                                        Text(tagWithTime[selectedTagIndex].tagName ?? "")  //动态
                                            .font(.system(size: 14))
                                            .foregroundColor(.indigo)
                                            .padding([.leading, .trailing], 15)
                                            .padding([.top, .bottom], 6)
                                            .background(Color(rgba: (207, 200, 255, 1)))
                                            .cornerRadius(20) // 调整圆角半径，适应你的需求
                                            .padding(.top,-10)

                                    }
                                }
                                
                                Text(formatTime(remainingTimeInSeconds))
                                    .foregroundColor(.indigo)
                                    .font(.system(size: 50))
                                
                                Text("开始学习吧")
                                    .frame(height: 40)
                                    .padding(.top,-30).padding(.bottom,40)
                                if ifBegin{
                                    Button{
                                        ifBegin.toggle()
                                        time=true
                                        timeStop=true
                                    }label: {
                                        Text("结束")
                                            .bold()
                                            .font(.title2)
                                            .frame(width: 100,height: 30)
                                    }
                                    .cornerRadius(22) //建立圆角按钮
                                    .frame(width: 300,height: 100)
                                    .buttonStyle(.borderedProminent)
                                    .padding(.bottom,20)

                                }else{
                                    Button{
                                        ifBegin.toggle()
                                        startCountdown()
                                        
                                    }label: {
                                        Text("开始")
                                            .bold()
                                            .font(.title2)
                                            .frame(width: 100,height: 30)
                                    }
                                    .cornerRadius(22) //建立圆角按钮
                                    .frame(width: 300,height: 100)
                                    .buttonStyle(.borderedProminent)
                                    .padding(.bottom,20)
                                }
                                
                            }
                            .background(Color(red: 250/255, green: 250/255, blue: 255/255))
                            .cornerRadius(22.5)
                            .frame(width: 320,height: 600.0)
                            .padding(.bottom,20)
                            
                            
                            if ifShowTargetMenu{
                                //下面是targetMenu
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack{
                                        ForEach(Array(targetNoTime.enumerated()), id: \.element.id) { (index, target) in
                                            TargetMenuItem(targetName: target.targetName!, targetId: target.targetId!,targetPoint:target.targetPoint! ,targetStatus: target.status!,target: $targetNoTime, targetDateInfo: $targetDateInfo[index],targetIndex:index,deleteSuccess:$deleteSuccess,targetNoTimeNum:$targetNoTimeNum,targetWithTimeNum:$targetWithTimeNum,ifshowTargetMenuNull:$ifshowTargetMenuNull,textContant:$textContant)
                                        }
                                        ForEach(Array(targetWithTime.enumerated()), id: \.element.id) { (index, target) in
                                            TargetMenuItem(targetName:target.targetName!,targetId:target.targetId!,targetPoint:target.targetPoint!,targetStatus:target.status!,target: $targetWithTime, targetDateInfo: $targetDateInfo[index],targetIndex:index,deleteSuccess:$deleteSuccess,targetNoTimeNum:$targetNoTimeNum,targetWithTimeNum:$targetWithTimeNum,ifshowTargetMenuNull:$ifshowTargetMenuNull,textContant:$textContant)
                                        }
                                    }
                                }.padding([.top, .leading],25) .background(Color.white)
                                    .cornerRadius(20)
                                    .frame(width: 320,alignment: .top)
                                    .frame(maxHeight: 190)
                                    .padding(.bottom,490)
                            }
                        }.animation(.easeInOut, value: ifShowTargetMenu)
                        .padding(.bottom,40)
                }.overlay(alignment:.bottom) {
                    if ifShowTagMenu{
                        VStack{
                            ScrollView(.horizontal,showsIndicators: false){
                                
                                HStack() {
                                    
                                    ForEach(Array(tagWithTime.enumerated()), id: \.element.id) { (index, tag) in
                                        Text(tag.tagName ?? "")
                                            .foregroundColor(Color.indigo)
                                            .padding([.leading, .trailing], 20)
                                            .padding([.top, .bottom], 6)
                                            .background(selectedTagIndex == index ? Color.white : Color.init(rgba: (207, 200, 255, 1)))
                                            .cornerRadius(22.5)
                                            .onTapGesture {
                                                selectedTagIndex = index
                                                // 计算初始的剩余时间（秒数）
                                                let hoursInSeconds = (Int(tagWithTime[selectedTagIndex].tagHour!) ?? 1) * 3600
                                                let minutesInSeconds = (Int(tagWithTime[selectedTagIndex].tagMinute!) ?? 30) * 60
                                                remainingTimeInSeconds = TimeInterval(hoursInSeconds + minutesInSeconds)
                                            }
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                                .frame(alignment: .leading)
                            }.padding([.leading,.trailing],35)
                            
                            
                            HStack(spacing: 80){
                                VStack(alignment: .leading){
                                    HStack{
                                        Image("countDownAfter")
                                        Text("\(tagWithTime[selectedTagIndex].tagHour ?? "")小时\(tagWithTime[selectedTagIndex].tagMinute ?? "")分钟")
                                            .foregroundColor(Color.indigo)
                                    }
                                    HStack{
                                        Image("Coin")
                                        Text(tagWithTime[selectedTagIndex].tagDescribe ?? "")
                                            .foregroundColor(Color.indigo)
                                    }
                                }
                                Button(action: {
                                    ifShowTagMenu.toggle()
                                }) {
                                    Text("确定")
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 80, height: 30)
                                .background(Color.indigo)
                                .cornerRadius(22.5)
                            }
                            .frame(width: 320, height: 80)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .frame(width: 395, height: 180)
                        .background(Color.indigo)
                        .cornerRadius(22.5)
                    }
                                    
                }.ignoresSafeArea()
            }
            
            // 毛玻璃效果
            if ifShowMenu {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .ignoresSafeArea()
                Color.white.opacity(0.3) // 透明的白色背景
                    .ignoresSafeArea()
                    .onTapGesture {
                        ifShowMenu.toggle()
                    }
            }
            
            // 抽屉式导航菜单
            if ifShowMenu {
                GeometryReader { geometry in
                    DrawerMenu(isDrawerOpen: $ifShowMenu, ifShowTarget: $ifShowTarget, showWhichView: $showWhichView)
                }
            }
        }.onAppear(){
            let maxCount = max(targetNoTimeNum, targetWithTimeNum)
            //注意这里为了不报错，使用了偷懒的写法，直接给初值附上了99
            for _ in 0..<maxCount {
                targetDateInfo.append(TargetView.TargetDateInfo(dayDifference: 0, timeString: ""))
            }
            fetchTargetData()
            fetchTagData()
            
        }
        
        .alert(isPresented: $time) {
            if timeStop{
                return Alert(
                    title: Text("确定要放弃吗？"), // 弹窗标题
                    message: Text("本次计时将不会得到任何分数"), // 弹窗消息
                    primaryButton: .default(Text("确定"), action: {
                        // 在确定按钮点击时执行的操作
                        resetCountdown()
                        time=false
                    }),
                    secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
                )
            }else{
                return Alert(
                    title: Text("计时结束"), // 弹窗标题
                    message: Text("本次计时获得\(tagWithTime[selectedTagIndex].tagPoint!)Points"), // 弹窗消息
                    primaryButton: .default(Text("确定"), action: {
                        // 在确定按钮点击时执行的操作
                        resetCountdown()
                        time=false
                    }),
                    secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
                )
            }
            
        }

    }
    func fetchTargetData() {
        targetDataManager.fetchTargetData(userEmail: userData.userEmail) { fetchedData, error in
            if let fetchedData = fetchedData {
                for data in fetchedData {
                    switch data.status {
                    case "0":
                        targetNoTime.append(data)
                    case "1":
                        targetWithTime.append(data)
                    case "2":
                        targetCompleted.append(data)
                    case "3":
                        targetExpire.append(data)
                    default:
                        break
                    }
                }
                targetNoTimeNum=targetNoTime.count
                targetWithTimeNum=targetWithTime.count
                targetCompletedNum=targetCompleted.count
                targetExpireNum=targetExpire.count
                if targetNoTimeNum==0&&targetWithTimeNum==0{
                    ifshowTargetMenuNull=true
                }

                print(targetNoTime)
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
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
        }
    }
    func fetchTagData() {
        tagDataManager.fetchTagData(userEmail: userData.userEmail) { fetchedData, error in
            if let fetchedData = fetchedData {
                tagWithTime = fetchedData
                tagNum=tagWithTime.count
                if tagWithTime[0].ifTagNull=="1"{
                    ifshowTagDetailBNull=true
                }
                print(tagWithTime)
                // 计算初始的剩余时间（秒数）
                let hoursInSeconds = (Int(tagWithTime[selectedTagIndex].tagHour!) ?? 1) * 3600
                let minutesInSeconds = (Int(tagWithTime[selectedTagIndex].tagMinute!) ?? 30) * 60
                remainingTimeInSeconds = TimeInterval(hoursInSeconds + minutesInSeconds)
                
                
                isDataLoaded = true  // 数据加载完成
                
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
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
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    func resetCountdown() {
        countdownTimer?.invalidate() // 停止定时器
        // 重置剩余时间为初始值
        let hoursInSeconds = (Int(tagWithTime[selectedTagIndex].tagHour!) ?? 1) * 3600
        let minutesInSeconds = (Int(tagWithTime[selectedTagIndex].tagMinute!) ?? 30) * 60
        remainingTimeInSeconds = TimeInterval(hoursInSeconds + minutesInSeconds)

    }
    func finishTag(tagName:String){
        tagDataManager.finishTag(tagName: tagName) { error in
            if error == nil {
                
                print("完成标签成功")
            } else {
                
                print("完成标签失败")
            }
            
        }
    }
}

struct Previews_TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView().environmentObject(UserData())
    }
}

