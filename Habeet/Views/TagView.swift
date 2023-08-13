//
//  TagView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject private var userData: UserData
    
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=2
    @State private var ifDelete:Bool=false
    @State private var deleteSuccess:Bool=false
    @State private var tagNum:Int=0

    
    @State private var tagWithTime: [TagWithTime] = []
    @State private var ifshowTagDetailBNull = false //判断标签里是否有数据没有数据
    
    @State private var timerTriggered = false
    
    @State private var textContant="删除标签"

    
    let tagDataManager = TagDataManager()

    var body: some View {
        ZStack{
            // 标签视图的内容
            VStack{
                //第一行的Nav
                NavView(ifShowMenu: $ifShowMenu,showWhichView:$showWhichView,ifDelete:$ifDelete)
                
                if ifshowTagDetailBNull{
                    TagItemNullView()
                }else{
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(tagWithTime.indices, id: \.self) { index in
                            let currentIndex = index // 创建一个独立的副本

                            TagItemView(ifshowTagDetailBNull:$ifshowTagDetailBNull,tagNum:$tagNum,deleteSuccess:$deleteSuccess,ifDelete: $ifDelete,tagName: tagWithTime[index].tagName!, tagDescribe: tagWithTime[index].tagDescribe!,tagWithTime:$tagWithTime,tagTimeIndex:currentIndex)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                                
            }.overlay(alignment:.bottomTrailing) {
                //按钮
                Button{
                    showWhichView=8
                    timerTriggered=true
                }label: {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 70,height: 70)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                        .cornerRadius(50)
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
             fetchTagData()
        }.overlay {
            if deleteSuccess{
                TextAlertView(textContant:$textContant,ifshowTextAlert:$deleteSuccess)
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
                
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView().environmentObject(UserData())
    }
}
