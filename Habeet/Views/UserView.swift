//
//  UserView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=4
    @State private var ifDelete:Bool=false
    @State private var  ifShowUserMenu:Bool=true
    
    let userDataManager = UserDataManager() // 实例化UserDataManager
    
    @State private var userTimeP:String="过去一周"
    
    @State private var pointRecordData:PointRecordData?
    
    
    let pointAll:String="10"
    var body: some View {
        ZStack{
            // 目标视图的内容
            VStack{
                //第一行的Nav
                NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
                
                //这是第二行的目标Nav
                HStack(){
                    Text(userTimeP)
                        .padding(.leading, 20.0)
                        .frame(width: 300,height: 40,alignment: .leading)
                    if  ifShowUserMenu{
                        Button{
                            // 切换  ifShowUserMenu 的状态
                            ifShowUserMenu.toggle()
                        }label: {
                            Image("arrowUp")
                                .padding(.trailing, 20.0)
                            
                        }
                        
                    }else{
                        Button{
                            // 切换  ifShowUserMenu 的状态
                            ifShowUserMenu.toggle()
                        }label: {
                            Image("arrowDown")
                                .padding(.trailing, 20.0)
                            
                        }
                    }
                }
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                .cornerRadius(22.5)
                .frame(width: 350.0, height: 60.0)
                .animation(.easeInOut, value:  ifShowUserMenu)
                
                ZStack{
                    VStack(alignment: .leading){
                        Text("获取分数")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack{
                            Text((pointRecordData?.pointAll) ?? "0")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.indigo)
                            Image("Coin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25,height: 25)
                                .padding(.leading,20)
                        }
                        Text("努力的\(String(userTimeP.suffix(2)))！")
                    }.padding(20)
                        .frame(width: 330,height: 140,alignment: .leading)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color(red: 205/255, green: 231/255, blue: 255/255),
                                        Color(red: 193/255, green: 225/255, blue: 255/255)
                                    ]
                                ),
                                //从右往左渐变
                                startPoint: .trailing,
                                endPoint: .leading
                            )
                        )
                        .cornerRadius(22.5)
                    Image("userLogo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200,height: 200)
                        .padding(.leading,180)
                }.padding(.top,-20)
                ZStack{
                    VStack(alignment: .leading){
                        Text("进步")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack{
                            Text((pointRecordData?.progress) ?? "0")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.indigo)
                            Text("Points")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.indigo)
                            
                        }
                        Text("努力的\(String(userTimeP.suffix(2)))！")
                    }.padding(20)
                        .frame(width: 330,height: 140,alignment: .leading)
                        .background(Color(red: 233/255, green: 233/255, blue: 255/255))
                        .cornerRadius(22.5)
                    Image("userLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120,height: 120)
                        .padding(.leading,180)
                }.padding(.top,-20)
                
                HStack{
                    VStack{
                        VStack(alignment: .leading){
                            HStack{
                                Text("\((pointRecordData?.pointInsistence) ?? "0")\n连续得分")
                                    .bold()
                                    .padding(.trailing,20)
                                Image("userLogo4")
                            }.padding(.bottom,20)
                            Image("userLogo5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        .padding(20)
                        .frame(width: 160,height: 120,alignment: .leading)
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                        .cornerRadius(22.5)
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text("\((pointRecordData?.completeTargetRate) ?? "0.0")%")
                                        .bold()
                                        .font(.title2)
                                        .frame(width: 90, height: 30, alignment: .leading)
                                        .padding(.trailing,20)
                                    Text("目标完成率")
                                        .font(.footnote)
                                        .frame(width: 90, height: 20, alignment: .leading)
                                        .padding(.trailing,20)
                                }
                                Image("userLogo4")
                            }
                            Image("Progress")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        .padding(20)
                        .frame(width: 160,height: 180,alignment: .leading)
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                        .cornerRadius(22.5)
                    }.padding(.top,10)
                    VStack{
                        
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text((pointRecordData?.pointAverage) ?? "0.0")
                                        .bold()
                                        .font(.title2)
                                        .frame(width: 90, height: 30, alignment: .leading)
                                        .padding(.trailing,20)
                                    Text("每日平均得分")
                                        .font(.footnote)
                                        .frame(width: 90, height: 20, alignment: .leading)
                                        .padding(.trailing,20)
                                }
                                Image("userLogo4")
                            }
                            Image("userLogo3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        .padding(20)
                        .frame(width: 160,height: 180,alignment: .leading)
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                        .cornerRadius(22.5)
                        
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text("\((pointRecordData?.completeTarget) ?? "0")个目标")
                                        .bold()
                                        .font(.title2)
                                        .frame(width: 90, height: 30, alignment: .leading)
                                        .padding(.trailing,20)
                                    Text("完全完成")
                                        .frame(width: 90, height: 20, alignment: .leading)
                                        .padding(.trailing,20)
                                }
                                Image("userLogo4")
                            }
                            Image("userLogo5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        .padding(20)
                        .frame(width: 160,height: 120,alignment: .leading)
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                        .cornerRadius(22.5)
                        
                    }.padding(.top,10)
                    
                }
                
                Spacer()
                
            }
            
            
            if  ifShowUserMenu{
                //下面是targetMenu
                if userTimeP=="过去一周"{
                    VStack{
                        Button{
                            userTimeP="过去一天"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                        }label: {
                            Text("过去一天")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        Button{
                            userTimeP="过去一月"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                        }label: {
                            Text("过去一月")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        
                    }.padding([.trailing, .leading],20).padding([.top,.bottom],10)
                        .background(Color.white)
                        .cornerRadius(20)
                    
                        .padding(.top,-270)
                    
                }else if userTimeP=="过去一天"{
                    VStack{
                        Button{
                            userTimeP="过去一周"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                        }label: {
                            Text("过去一周")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        Button{
                            userTimeP="过去一月"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                        }label: {
                            Text("过去一月")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        
                    }.padding([.trailing, .leading],20).padding([.top,.bottom],10)
                        .background(Color.white)
                        .cornerRadius(20)
                    
                        .padding(.top,-270)
                    
                }else if userTimeP=="过去一月"{
                    VStack{
                        Button{
                            userTimeP="过去一天"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                        }label: {
                            Text("过去一天")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        Button{
                            userTimeP="过去一周"
                            ifShowUserMenu.toggle()
                            fetchPointRecordData()
                            
                        }label: {
                            Text("过去一周")
                                .frame(width: 280, height: 30, alignment: .leading)
                                .foregroundColor(Color.secondary)
                        }
                        
                    }.padding([.trailing, .leading],20).padding([.top,.bottom],10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.top,-270)
                }
                
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
            
        }
            .animation(.easeInOut, value:  ifShowUserMenu)
            .onAppear {
                fetchPointRecordData()
            }
    }
    func fetchPointRecordData() {
        userDataManager.fetchPointRecordData(userEmail:userData.userEmail,userTimeP: userTimeP) { fetchedData, error in
            if let fetchedData = fetchedData {
                pointRecordData=fetchedData
                print((pointRecordData?.pointAll)!)
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
            
        }
    }

}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView().environmentObject(UserData())
    }
}
