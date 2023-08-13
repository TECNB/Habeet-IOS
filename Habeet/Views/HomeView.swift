//
//  HomeView.swift
//  Habeet
//
//  Created by TEC on 2023/8/17.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var showWhichView=10
    @State private var timerTriggered = false
    
    let userDataManager = UserDataManager() // 实例化UserDataManager
    
    @State private var ifshowTextAlert = false
    @State private var textContant="QQ邮箱格式错误"

    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Button{
                showWhichView=13
                timerTriggered=true
            }label: {
                HStack{
                    Image("Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                    Spacer()
                }

            }
                        
            Text("欢迎回来")
                .bold()
                .font(.largeTitle)
            Text("你的QQ邮箱")
                .foregroundColor(.secondary)
            TextField("请输入邮箱", text: $userData.userEmail)
                .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                .cornerRadius(22.5) // 圆角边框
                .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
                
            
            Button{
                let isValidQQEmail = isValidQQEmailFormat(email: userData.userEmail)
                if isValidQQEmail{
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
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            }
            .frame(width: 360,height: 45)
            .background(Color.indigo)
            .cornerRadius(22.5)
            .padding([.top,.bottom],6)

            Spacer()
            
            NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)
        }.padding(15)
            .overlay {
                if ifshowTextAlert{
                    TextAlertView(textContant:$textContant,ifshowTextAlert:$ifshowTextAlert)
                        
                }
            }
    }
    // 校验QQ邮箱格式的函数
        func isValidQQEmailFormat(email: String) -> Bool {
            let qqEmailRegex = "[1-9][0-9]{4,10}@qq\\.com"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", qqEmailRegex)
            return emailPredicate.evaluate(with: email)
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}

    
