//
//  TargetView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct TargetView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=1
    @State private var ifDelete:Bool=false
    
    @State private var timerTriggered = false
    
    @State private var targetTime: [TargetTime] = []
    @State private var targetNoTime: [TargetTime] = []
    @State private var targetWithTime: [TargetTime] = []
    @State private var targetCompleted: [TargetTime] = []
    @State private var targetExpire: [TargetTime] = []
    
    @State private var targetStatus:Int=0
    
    @State private var deleteSuccess:Bool=false

    @State private var textContant="删除目标"
    
    @State private var ifshowTargetNoTimeNull:Bool=false
    @State private var ifshowTargetWithTimeNull:Bool=false
    @State private var ifshowTargetCompletedNull:Bool=false
    @State private var ifshowTargetExpireNull:Bool=false
    
    @State private var targetNoTimeNum:Int=100
    @State private var targetWithTimeNum:Int=100
    @State private var targetCompletedNum:Int=100
    @State private var targetExpireNum:Int=100
    
    @State private var dayDifference:Int=0
    @State private var timeString:String="0"
    @State private var monthDayString:String="0"
    
    @State private var selectedDate:Date=Date()
    
    let targetDataManager = TargetDataManager()
        
    struct TargetDateInfo {
        var dayDifference: Int
        var timeString: String
    }
    @State private var targetDateInfo:[TargetDateInfo]=[]

    var body: some View {
        ZStack{
            // 目标视图的内容
            VStack{
                NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
                //第一行的Nav
                TargetNav1View(onDateSelected: { selectedDate in                    
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
                })
                //第二行的Nav
                TargetNav2View(targetStatus:$targetStatus)
                
                ScrollView(.vertical, showsIndicators: false) {
                    if targetStatus==0{
                        HStack{
                            Text("随时完成")
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.leading,25)
                        
                        //随时完成的目标
                        if ifshowTargetNoTimeNull{
                            TargetItemNullView(targetStatus: 0)
                        }else{
                            ForEach(Array(targetNoTime.enumerated()), id: \.element.id) { (index, target) in
                                TargetItemView(targetName: target.targetName!, targetDescribe: target.targetDescribe!, targetId: target.targetId!,targetPoint:target.targetPoint! ,targetStatus: target.status!, ifshowTargetNoTimeNull: $ifshowTargetNoTimeNull, ifshowTargetWithTimeNull: $ifshowTargetWithTimeNull, ifshowTargetCompletedNull: $ifshowTargetCompletedNull, ifshowTargetExpireNull: $ifshowTargetExpireNull, targetNoTimeNum: $targetNoTimeNum, targetWithTimeNum: $targetWithTimeNum, targetCompletedNum: $targetCompletedNum, targetExpireNum: $targetExpireNum, ifDelete: $ifDelete, deleteSuccess: $deleteSuccess,targetTime:$targetNoTime,targetTimeIndex:index,textContant:$textContant,targetCompleted:$targetCompleted,dayDifference:$dayDifference,timeString:$timeString,targetDateInfo: $targetDateInfo[index])
                            }
                        }
                                                
                        
                        HStack{
                            Text("限时完成")
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.leading,25)
                        
                        //限时完成的目标
                        if ifshowTargetWithTimeNull{
                            TargetItemNullView(targetStatus: 1)
                        }else{
                            ForEach(Array(targetWithTime.enumerated()), id: \.element.id) { (index, target)in
                                TargetItemView(targetName: target.targetName!, targetDescribe: target.targetDescribe!, targetId: target.targetId!,targetPoint:target.targetPoint! ,targetStatus: target.status!, ifshowTargetNoTimeNull: $ifshowTargetNoTimeNull, ifshowTargetWithTimeNull: $ifshowTargetWithTimeNull, ifshowTargetCompletedNull: $ifshowTargetCompletedNull, ifshowTargetExpireNull: $ifshowTargetExpireNull, targetNoTimeNum: $targetNoTimeNum, targetWithTimeNum: $targetWithTimeNum, targetCompletedNum: $targetCompletedNum, targetExpireNum: $targetExpireNum, ifDelete: $ifDelete, deleteSuccess: $deleteSuccess,targetTime:$targetWithTime,targetTimeIndex:index,textContant:$textContant,targetCompleted:$targetCompleted,dayDifference:$dayDifference,timeString:$timeString,targetDateInfo: $targetDateInfo[index])
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        
                    }else if targetStatus==1{
                        HStack{
                            Text("已经完成")
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.leading,25)
                        //已经完成的目标
                        if ifshowTargetCompletedNull{
                            TargetItemNullView(targetStatus: 2)
                        }else{
                            ForEach(Array(targetCompleted.enumerated()), id: \.element.id) { (index, target)  in
                                TargetItemView(targetName: target.targetName!, targetDescribe: target.targetDescribe!, targetId: target.targetId!,targetPoint:target.targetPoint! ,targetStatus: target.status!, ifshowTargetNoTimeNull: $ifshowTargetNoTimeNull, ifshowTargetWithTimeNull: $ifshowTargetWithTimeNull, ifshowTargetCompletedNull: $ifshowTargetCompletedNull, ifshowTargetExpireNull: $ifshowTargetExpireNull, targetNoTimeNum: $targetNoTimeNum, targetWithTimeNum: $targetWithTimeNum, targetCompletedNum: $targetCompletedNum, targetExpireNum: $targetExpireNum, ifDelete: $ifDelete, deleteSuccess: $deleteSuccess,targetTime:$targetCompleted,targetTimeIndex:index,textContant:$textContant,targetCompleted:$targetCompleted,dayDifference:$dayDifference,timeString:$timeString,targetDateInfo: $targetDateInfo[index])
                                    .frame(maxWidth: .infinity)
                            }

                        }
                        
                    }else if targetStatus==2{
                        HStack{
                            Text("已经过期")
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.leading,25)
                        //已经完成的目标
                        if ifshowTargetExpireNull{
                            TargetItemNullView(targetStatus: 3)
                        }else{
                            ForEach(Array(targetExpire.enumerated()), id: \.element.id) { (index, target) in
                                TargetItemView(targetName: target.targetName!, targetDescribe: target.targetDescribe!, targetId: target.targetId!,targetPoint:target.targetPoint! ,targetStatus: target.status!, ifshowTargetNoTimeNull: $ifshowTargetNoTimeNull, ifshowTargetWithTimeNull: $ifshowTargetWithTimeNull, ifshowTargetCompletedNull: $ifshowTargetCompletedNull, ifshowTargetExpireNull: $ifshowTargetExpireNull, targetNoTimeNum: $targetNoTimeNum, targetWithTimeNum: $targetWithTimeNum, targetCompletedNum: $targetCompletedNum, targetExpireNum: $targetExpireNum, ifDelete: $ifDelete, deleteSuccess: $deleteSuccess,targetTime:$targetExpire,targetTimeIndex:index,textContant:$textContant,targetCompleted:$targetCompleted,dayDifference:$dayDifference,timeString:$timeString,targetDateInfo: $targetDateInfo[index])

                                    .frame(maxWidth: .infinity)
                            }

                        }
                                                
                    }
                }
            }.overlay(alignment:.bottomTrailing) {
                //按钮
                HStack{
                    Spacer()
                    Button{
                        showWhichView=7
                        timerTriggered=true
                    }label: {
                        Text("+")
                            .font(.largeTitle)
                            .frame(width: 70,height: 70)
                            .foregroundColor(Color.white)
                            .background(Color.indigo)
                            .cornerRadius(50)
                    }
                }.padding(.trailing,20).padding(.bottom,20)
                
            }
            
            // 毛玻璃效果
            if ifShowMenu {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .ignoresSafeArea()
                Color.white.opacity(0.1) // 透明的白色背景
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
            NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)
            
        }.onAppear {
            let maxCount = max(targetNoTimeNum, targetWithTimeNum)
            //注意这里为了不报错，使用了偷懒的写法，直接给初值附上了99
            for _ in 0..<maxCount {
                targetDateInfo.append(TargetView.TargetDateInfo(dayDifference: 0, timeString: ""))
            }
            fetchTargetData()
        }.overlay {
            if deleteSuccess{
                TextAlertView(textContant:$textContant,ifshowTextAlert:$deleteSuccess)
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
                if targetNoTimeNum==0{
                    ifshowTargetNoTimeNull=true
                }
                if targetWithTimeNum==0{
                    ifshowTargetWithTimeNull=true
                }
                if targetCompletedNum==0{
                    ifshowTargetCompletedNull=true
                }
                if targetExpireNum==0{
                    ifshowTargetExpireNull=true
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

}


struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView().environmentObject(UserData())
    }
}
