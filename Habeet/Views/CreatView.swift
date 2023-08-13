//
//  CreatView.swift
//  Habeet
//
//  Created by TEC on 2023/8/15.
//

import SwiftUI

struct CreatView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var Name: String = ""
    @State private var Describe: String = ""
    
    @State private var timerTriggered = false
    @Binding var showWhichView:Int
    
    @State private var textContant:String="标签名字重复"
    //这里的变量ifshowTextAlert使得该视图能在需要时多次出现
    @State private var ifshowTextAlert:Bool=false
    
    
    @State private var showTimePicker = false
        
    @State private var showScorePicker = false
    @State private var selectedHours = 0
    @State private var selectedMinutes = 10
    @State private var selectedScore = 1
    
    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
    @State private var deadlineString = ""
    
    let tagDataManager = TagDataManager()
    let storeDataManager = StoreDataManager()
    let targetDataManager = TargetDataManager()


    var body: some View {
        VStack(alignment: .leading){
            Group {
                HStack{
                    //返回的逻辑
                    if showWhichView==7{
                        Button{
                            showWhichView=1
                            timerTriggered=true
                        }label: {
                            Image("creatX")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25,height: 25)
                        }

                        Text("建立目标")
                            .bold()
                            .font(.title2)
                            .padding(.leading,12)
                    }else if showWhichView==8{
                        Button{
                            showWhichView=2
                            timerTriggered=true
                        }label: {
                            Image("creatX")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25,height: 25)
                        }

                        Text("建立标签")
                            .bold()
                            .font(.title2)
                            .padding(.leading,12)
                    }else if showWhichView==9{
                        Button{
                            showWhichView=3
                            timerTriggered=true
                        }label: {
                            Image("creatX")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25,height: 25)
                        }

                        Text("建立商品")
                            .bold()
                            .font(.title2)
                            .padding(.leading,12)
                    }
                    Spacer()
                    //保存的逻辑
                    Button{
                        if selectedScore==0{
                            textContant="请输入分数"
                            ifshowTextAlert=true
                        }
                        if Describe==""{
                            textContant="请输入标签备注"
                            ifshowTextAlert=true
                        }

                        if Name==""{
                            textContant="请输入标签名"
                            ifshowTextAlert=true
                        }

                        if Name != ""&&Describe != ""&&selectedScore != 0{
                            if showWhichView==7{
                                saveTarget(ifTargetUpdate: userData.ifTargetUpdate)
                            }else if showWhichView==8{
                                saveTag(ifTagUpdate: userData.ifTagUpdate)
                            }else if showWhichView==9{
                                saveStore(ifStoreUpdate: userData.ifStoreUpdate)
                            }
                        }
                        
                    }label: {
                        Text("保存")
                            .bold()
                            .foregroundColor(Color.indigo)
                    }
                }
                Image("creatLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,height: 180)
                    .padding(.leading,30)
                Text("名称")
                    .bold()
                    .foregroundColor(Color.secondary)
                
                TextField("请输入名称", text: $Name)
                    
                    .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                    .cornerRadius(22.5) // 圆角边框
                    .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
                
                Text("备注")
                    .bold()
                    .foregroundColor(Color.secondary)
                TextField("请输入备注", text: $Describe)
                    
                    .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 15, trailing: 20)) // 调整内部空间
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                    .cornerRadius(22.5) // 圆角边框
                    .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
            }
            
            
            HStack{
                Text("代表颜色")
                    .bold()
                    .foregroundColor(Color.secondary)
                Spacer()
                Circle()
                    .fill(Color.orange)
                    .frame(width: 20, height: 50) // 设置圆形的尺寸
            }
            HStack{
                Text("是否设置截止日期和分数")
                    .bold()
                    .foregroundColor(Color.secondary)
            }
            
            HStack{
                if showWhichView==7{
                    Button{
                        showDatePicker.toggle()
                    }label: {
                        Image("Calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(15)
                            .background(
                                LinearGradient(
                                    gradient:Gradient(colors: [Color(red: 154/255, green: 219/255, blue: 127/255), Color(red: 110/255, green: 169/255, blue: 92/255)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(50)
                        Text("+添加时间")
                            .foregroundColor(Color(rgba: (165, 245, 156, 1)))
                    }
                    //下面为时间Picker
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
                            .presentationDetents([.fraction(0.6),.large])
                                .edgesIgnoringSafeArea(.all)

                            
                            Button {
                                showDatePicker.toggle()
                                deadlineString = dateFormatter.string(from: selectedDate)
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
                }else{
                    Button{
                        showTimePicker.toggle()
                    }label: {
                        Image("Calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(15)
                            .background(
                                LinearGradient(
                                    gradient:Gradient(colors: [Color(red: 154/255, green: 219/255, blue: 127/255), Color(red: 110/255, green: 169/255, blue: 92/255)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(50)
                        Text("+添加时间")
                            .foregroundColor(Color(rgba: (165, 245, 156, 1)))
                    }
                    //下面为时间Picker
                    .sheet(isPresented: $showTimePicker) {
                        HStack {
                            Picker("小时", selection: $selectedHours) {
                                ForEach(0..<5) { hour in
                                    Text("\(hour)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            Picker("分钟", selection: $selectedMinutes) {
                                ForEach([10, 20, 30, 40, 50], id: \.self) { minute in
                                    Text("\(minute)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }.presentationDetents([.fraction(0.4),.medium,.large])
                            .edgesIgnoringSafeArea(.all)
                        
                        Button {
                            showTimePicker.toggle()
                        }label: {
                            Text("完成")
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 100,height: 40)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .padding(.top,30)
                        
                    }

                }

                
                Spacer()
                
                Button{
                    showScorePicker.toggle()
                }label: {
                    Image("Coin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(15)
                        .background(
                            LinearGradient(
                                gradient:Gradient(colors: [Color(red: 255/255, green: 178/255, blue: 142/255), Color(red: 255/255, green: 122/255, blue: 85/255)]),
                                startPoint: .trailing,
                                endPoint: .leading
                            )
                        )
                        .cornerRadius(50)
                    Text("+添加分数")
                        .foregroundColor(Color(rgba: (255,206,115,1)))

                }
                //下面为时间Picker
                .sheet(isPresented: $showScorePicker) {
                    Picker("分数", selection: $selectedScore) {
                        ForEach(1...8, id: \.self) { score in
                            Text("\(score) Point")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
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
                
            }
            HStack{
                if showWhichView==7{
                    Rectangle()
                        .fill(Color.indigo)
                        .frame(width: 8,height: 20)
                        .cornerRadius(22.5)
                    Text("截止时间：\(selectedDate, formatter: dateFormatter)")
                }else{
                    Rectangle()
                        .fill(Color.indigo)
                        .frame(width: 8,height: 20)
                        .cornerRadius(22.5)
                    Text("倒计时时间：\(selectedHours)小时\(selectedMinutes)分钟")
                }
                
            }.padding(.top,20)
            HStack{
                Rectangle()
                    .fill(Color.indigo)
                    .frame(width: 8,height: 20)
                    .cornerRadius(22.5)
                Text("可得分数：\(selectedScore) Point")
            }.padding(.top,10)

            Spacer()
            NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)
        }.padding([.leading,.trailing],20)
            .overlay {
                if ifshowTextAlert{
                    TextAlertView(textContant: $textContant, ifshowTextAlert: $ifshowTextAlert)
                }
            }
    }
    func saveTag(ifTagUpdate:Int){
        tagDataManager.saveTag(userEmail:userData.userEmail,tagName: Name, tagDescribe: Describe, tagPoint: selectedScore, tagHour: selectedHours, tagMinute: selectedMinutes, ifTagUpdate: ifTagUpdate) { fetchedData, error in
            if let fetchedData = fetchedData {
                if fetchedData.ifRepeat == "1"{
                    textContant="标签名字重复"
                    ifshowTextAlert=true
                }else{
                    showWhichView=2
                    timerTriggered=true
                }
                
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    func saveStore(ifStoreUpdate:Int){
        storeDataManager.saveStore(userEmail:userData.userEmail,storeName: Name, storeDescribe: Describe, storePoint: selectedScore, storeHour: selectedHours, storeMinute: selectedMinutes, ifStoreUpdate: ifStoreUpdate) { fetchedData, error in
            if let fetchedData = fetchedData {
                if fetchedData.ifRepeat == "1"{
                    textContant="商品名字重复"
                    ifshowTextAlert=true
                }else{
                    showWhichView=3
                    timerTriggered=true
                }
                
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    func saveTarget(ifTargetUpdate:Int){
        targetDataManager.saveTarget(userEmail:userData.userEmail,targetName: Name, targetDescribe: Describe, targetPoint: selectedScore, deadlineString:deadlineString, ifTargetUpdate: ifTargetUpdate){ fetchedData, error in
            if let fetchedData = fetchedData {
                if fetchedData.status == "4"{
                    textContant="目标名字重复"
                    ifshowTextAlert=true
                }else{
                    showWhichView=1
                    timerTriggered=true
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }



}


struct CreatView_Previews: PreviewProvider {
    static var previews: some View {
        let showWhichView=Binding.constant(7)

        CreatView(showWhichView:showWhichView).environmentObject(UserData())
    }
}

