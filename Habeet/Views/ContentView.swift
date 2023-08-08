//
//  ContentView.swift
//  Habeet
//
//  Created by TEC on 2023/8/7.
//

import SwiftUI

struct ContentView: View {
    @State private var ifShowTargetMenu:Bool=false
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool = false
    var body: some View {
        ZStack{
            //计时视图
            TimerView(ifShowTargetMenu:$ifShowTargetMenu,ifShowMenu:$ifShowMenu,ifShowTarget:$ifShowTarget)
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
                    DrawerMenu(isDrawerOpen: $ifShowMenu, ifShowTarget: $ifShowTarget)
                        .padding(.leading,-15)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height+40) // Set VStack height to screen height
                        .background(Color.white)
                    
                }
            }
            
            //导航
            if ifShowTarget{
                TargetView()
                    .fullScreenCover(isPresented: $ifShowTarget, content: {
                        // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                        TargetView()
                    })
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

