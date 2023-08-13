//
//  SignView.swift
//  Habeet
//
//  Created by TEC on 2023/8/17.
//

import SwiftUI

struct SignView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var userEmail:String=""
    @State private var userName:String=""
    @State private var userPassword:String=""
    @State private var userConfirm:String=""
    @State private var userCode:String=""
    
    @State private var showWhichView=12
    @State private var timerTriggered = false
    
    @State private var textContant:String="验证码错误"
    //这里的变量ifshowTextAlert使得该视图能在需要时多次出现
    @State private var ifshowTextAlert:Bool=false
    
    @State private var isCountingDown = false
    @State private var countdown: Int = 60
    
    let userDataManager = UserDataManager() // 实例化UserDataManager

    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Group{
                HStack{
                    Button{
                        showWhichView=10
                        timerTriggered=true
                        userData.ifLoginUpdate=0
                    }label: {
                        Image("Back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30,height: 30)
                    }
                    
                    Spacer()
                }
                if userData.ifLoginUpdate==0{
                    Text("注册")
                        .bold()
                        .font(.largeTitle)
                    Text("将使用\(userData.userEmail)注册")
                        .foregroundColor(.secondary)
                    Text("名称")
                        .foregroundColor(.secondary)
                    TextField("请输入名称", text: $userName)
                        .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                        .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                        .cornerRadius(22.5) // 圆角边框
                        .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
                }else{
                    Text("找回密码")
                        .bold()
                        .font(.largeTitle)
                    Text("将为\(userData.userEmail)找回密码")
                        .foregroundColor(.secondary)
                }
                
                Text("密码")
                    .foregroundColor(.secondary)
                TextField("请输入密码", text: $userPassword)
                    .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                    .cornerRadius(22.5) // 圆角边框
                    .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
            }
            Text("确定密码")
                .foregroundColor(.secondary)
            TextField("请再次输入密码", text: $userConfirm)
                .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                .cornerRadius(22.5) // 圆角边框
                .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
            
            Text("验证码")
                .foregroundColor(.secondary)
            HStack{
                TextField("请输入验证码", text: $userCode)
                    .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                    .cornerRadius(22.5) // 圆角边框
                    .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
                Button{
                    if !isCountingDown {
                        isCountingDown = true
                        startCountdown()
                        // 在这里调用发送验证码的方法
                        userDataManager.code(userEmail: userData.userEmail, ifUpdate: userData.ifLoginUpdate){ fetchedData in
                            if fetchedData == "1"{
                                textContant="发生验证码成功"
                                ifshowTextAlert=true
                            }else{
                                textContant="发生验证码失败"
                                ifshowTextAlert=true
                            }
                        }
                    }
                }label: {
                    HStack(){
                        Image("loginNavLogo5")
                        Text(isCountingDown ? "\(countdown)秒后重试" : "发送验证码")
                            .bold()
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: 150,height: 45)
                .background(Color.indigo)
                .cornerRadius(22.5)
                .padding([.top,.bottom],6)
            }
            
            Button{
                if userPassword != userConfirm{
                    textContant="前后密码不一致"
                    ifshowTextAlert=true
                }
                if userPassword==""{
                    textContant="请输入密码"
                    ifshowTextAlert=true
                }
                if userData.ifLoginUpdate==0{
                    if userName==""{
                        textContant="请输入名称"
                        ifshowTextAlert=true
                    }
                    if userName != "" && userPassword != "" &&
                        userPassword == userConfirm{
                        userDataManager.sign(email:  userData.userEmail,userName:userName,password: userPassword, userCode: userCode, ifUpdate: userData.ifLoginUpdate) { fetchedData in
                            if fetchedData==0{
                                userData.point=0
                                userData.userName=userName
                                showWhichView=0
                                timerTriggered=true
                                userData.ifLoginUpdate=0
                            }else{
                                textContant="验证码错误"
                                ifshowTextAlert=true
                            }
                        }
                    }
                }else{
                    if userPassword != "" &&
                        userPassword == userConfirm{
                        userDataManager.sign(email:  userData.userEmail,userName:userName,password: userPassword, userCode: userCode, ifUpdate: userData.ifLoginUpdate) { fetchedData in
                            if fetchedData==0{
                                userDataManager.getUserData(email:  userData.userEmail, password: userPassword) { fetchedData, error in
                                    if let fetchedData = fetchedData {
                                        userData.point=Int(fetchedData.point!)!
                                        userData.userName=fetchedData.userName!
                                        print("userData.point:",userData.point)
                                    } else {
                                        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                                    }
                                }
                                showWhichView=0
                                timerTriggered=true
                                userData.ifLoginUpdate=0
                            }else{
                                textContant="验证码错误"
                                ifshowTextAlert=true
                            }
                        }
                    }
                }
                
                
                
            }label: {
                if userData.ifLoginUpdate==0{
                    HStack(){
                        Text("注册")
                            .bold()
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }else{
                    HStack(){
                        Text("确定")
                            .bold()
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }
            }
            .frame(width: 360,height: 45)
            .background(Color.indigo)
            .cornerRadius(22.5)
            .padding([.top,.bottom],10)
            
            Spacer()
            
            NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)
        }.padding(15)
            .overlay {
                if ifshowTextAlert{
                    TextAlertView(textContant:$textContant,ifshowTextAlert:$ifshowTextAlert)
                }
            }
    }
    func startCountdown() {
        countdown = 60
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                isCountingDown = false
            }
        }
        
        // 避免计时器受到RunLoop的影响，将计时器模式设置为common
        RunLoop.current.add(timer, forMode: .common)
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView().environmentObject(UserData())
    }
}
