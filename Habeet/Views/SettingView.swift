//
//  SettingView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct SettingView: View {
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=5
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                NavView(ifShowMenu: $ifShowMenu)
                    .padding(.leading,-20)
                    .padding(.bottom,20)
                Text("更换模式")
                    .foregroundColor(.secondary)
                HStack{
                    Text("黑夜模式")
                        .padding(20)
                        .frame(width: 285,height:50,alignment: .leading)
                    Image("darkMode")
                        .padding(.trailing,10)
                }
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                    .cornerRadius(22)
                    .padding(.bottom,20)
                Text("按照系统设置的模式")
                    .foregroundColor(.secondary)
                    .padding(.bottom,20)

                Text("更换语言")
                    .foregroundColor(.secondary)
                HStack{
                    Text("简体中文")
                        .padding(20)
                        .frame(width: 312,height:50,alignment: .leading)
                    Image("arrowDown")
                        .padding(.trailing,10)
                }
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                    .cornerRadius(22)
                    .padding(.bottom,20)

                Text("消息")
                    .foregroundColor(.secondary)
                HStack{
                    Text("消息提示")
                        .padding(20)
                        .frame(width: 312,height:50,alignment: .leading)
                    Image("arrowDown")
                        .padding(.trailing,10)
                }
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                    .cornerRadius(22)
                Spacer()
                
                
            }.padding(.leading,20)
            
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
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
