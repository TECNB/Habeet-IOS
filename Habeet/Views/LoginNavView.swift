//
//  LoginNavView.swift
//  Habeet
//
//  Created by TEC on 2023/8/16.
//

import SwiftUI

struct LoginNavView: View {
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let items = [
            ("loginNavLogo1", "兑换\n商店积分"),
            ("loginNavLogo2", "发现\n自我进步"),
            ("loginNavLogo3", "建立\n计时标签"),
            ("loginNavLogo4", "建立\n你的目标")
    ]
    @State private var showWhichView=13
    @State private var timerTriggered = false
    
    @EnvironmentObject private var userData: UserData
    var body: some View {
        NavigationStack{
            VStack(){
                TabView(selection: $currentIndex) {
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
                        .tag(index)
                    }
                    
                }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .onReceive(timer) {_ in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % items.count
                        }
                    }

                
                Text("通过Habeet你可以通过自定义标签，来规定学习时间，并完成自己设立的目标，并获得分数来兑换商店的物品")
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                
                Button{
                    showWhichView=10
                    timerTriggered=true
                }label: {
                    HStack(){
                        Image("loginNavLogo5")
                        Text("邮箱登陆")
                            .bold()
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: 350,height: 45)
                .background(Color.indigo)
                .cornerRadius(22.5)
                .padding([.top,.bottom],6)
                Text("或者使用下面的方式登陆")
                    .bold()
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                HStack(spacing: 60){
                    Image("QQ")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                        .padding(8)
                        .background(Color(rgba: (207, 200, 255, 1)))
                        .cornerRadius(50)
                    Image("Wx")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                        .padding(8)
                        .background(Color(rgba: (207, 200, 255, 1)))
                        .cornerRadius(50)
                }.padding([.top,.bottom],6)
                Text("登陆后意味着同意小程序Habeet的\n")
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom,-18)
                
                HStack{
                    NavigationLink(destination: UserAgreementView()){
                        Text("用户协议")
                            .foregroundColor(Color(rgba: (255, 162, 192, 1)))
                    }
                    
                    Text("和")
                        .padding([.leading,.trailing],-4)
                    
                    NavigationLink(destination: PrivacyPolicyView()){
                        Text("隐私政策")
                                .foregroundColor(Color(rgba: (255, 162, 192, 1)))

                    }
                                        
                }
                .font(.footnote)
                .foregroundColor(Color.secondary)
                
                NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)
            }.padding(15)
        }
    }
}

struct LoginNavView_Previews: PreviewProvider {
    static var previews: some View {
        LoginNavView()
            .environmentObject(UserData())
    }
}
