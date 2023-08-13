//
//  LoginView.swift
//  Habeet
//
//  Created by TEC on 2023/8/17.
//

import SwiftUI


struct LoginView: View {
    @EnvironmentObject private var userData: UserData

    @State private var userPassword:String=""
    
    @State private var showWhichView=11
    @State private var timerTriggered = false
    
    let userDataManager = UserDataManager() // 实例化UserDataManager
    
    @State private var ifshowTextAlert = false
    @State private var textContant="密码错误"
    
    @State private var ifUpdate:Int=0

    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Button{
                    showWhichView=10
                    timerTriggered=true
                }label: {
                    Image("Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                }
                
                Spacer()
            }
            Text("登陆")
                .bold()
                .font(.largeTitle)
            Text("将使用\(userData.userEmail)登陆")
                .foregroundColor(.secondary)
            Text("你的密码")
                .foregroundColor(.secondary)
            TextField("请输入密码", text: $userPassword)
                .font(Font.system(size: 16, weight: .bold)) // 设置字体样式
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)) // 调整内部空间
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1))) // 设置背景颜色
                .cornerRadius(22.5) // 圆角边框
                .textFieldStyle(PlainTextFieldStyle()) // 去掉默认的边框样式
            HStack{
                Spacer()
                Button{
                    showWhichView=12
                    timerTriggered=true
                    userData.ifLoginUpdate=1
                }label: {
                    Text("忘记密码?")
                }
            }.padding(.top,-10)
            Button{
                userDataManager.checkPassword(email: userData.userEmail,password: userPassword) { newView in
                    showWhichView = newView
                    if showWhichView==0{
                        timerTriggered = true
                    }else{
                        ifshowTextAlert=true
                    }
                }
                userDataManager.getUserData(email:  userData.userEmail, password: userPassword) { fetchedData, error in
                    if let fetchedData = fetchedData {
                        userData.point=Int(fetchedData.point!)!
                        userData.userName=fetchedData.userName!
                        print("userData.point:",userData.point)
                    } else {
                        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    }
                    
                }

                
                
            }label: {
                HStack(){
                    Text("登陆")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserData())
    }
}
