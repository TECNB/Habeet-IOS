//
//  StoreView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=3
    @State private var ifDelete:Bool=false
    
    @State private var storeWithTime: [StoreWithTime] = []
    let storeDataManager = StoreDataManager()
    
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @State private var timerTriggered = false
    @State private var storeNum:Int=1
    @State private var ifEnough:Bool=false
    
    @State private var ifshowStoreWithTimeNull:Bool=false
    
    @State private var textContant="兑换成功"
    @State private var deleteSuccess:Bool=false



    var body: some View {
        ZStack{
            // 目标视图的内容
            VStack{
                //第一行的Nav
                NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
                HStack{
                    Text("Welcome to Store")
                        .foregroundColor(Color.secondary)
                    Spacer()
                }.padding(.leading,25)
                
                if ifshowStoreWithTimeNull==true{
                    StoreItemNullView()
                }else{
                    TabView(selection: $currentIndex) {
                        ForEach(storeWithTime.indices, id: \.self) { index in
                            StoreItemView(storeName: storeWithTime[index].storeName ?? "0",
                                          storeDescribe: storeWithTime[index].storeDescribe ?? "0",
                                          storePoint: storeWithTime[index].storePoint ?? "0",
                                          storeHour: storeWithTime[index].storeHour ?? "0",
                                          storeMinute: storeWithTime[index].storeMinute ?? "0",storeWithTime:$storeWithTime,storeNum:$storeNum,ifEnough:$ifEnough,storeIndex:index,textContant:$textContant,deleteSuccess:$deleteSuccess,ifshowStoreWithTimeNull:$ifshowStoreWithTimeNull)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .onReceive(timer) { _ in
                        withAnimation {
                            if storeNum != 0{
                                currentIndex = (currentIndex + 1) % storeNum
                                
                            }
                        }
                    }

                }
                                
                Spacer()
                
                //按钮
                HStack{
                    Spacer()
                    
                    Button{
                        showWhichView=9
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
            fetchStoreData()
       }.overlay {
           if deleteSuccess{
               TextAlertView(textContant:$textContant,ifshowTextAlert:$deleteSuccess)
           }
       }
    }
    func fetchStoreData() {
        storeDataManager.fetchStoreData(userEmail:userData.userEmail) { fetchedData, error in
            if let fetchedData = fetchedData {
                storeWithTime = fetchedData
                storeNum=storeWithTime.count
                if storeWithTime[0].ifStoreNull=="1"{
                    ifshowStoreWithTimeNull=true
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView().environmentObject(UserData())
    }
}
