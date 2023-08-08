//
//  HelperView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct HelperView: View {
    
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int=6
    
    

    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                NavView(ifShowMenu: $ifShowMenu)
                    .padding(.leading,-20)
                    .padding(.bottom,20)
                Text("作者")
                    .foregroundColor(.secondary)
                Text("TEC")
                    .padding(20)
                    .frame(width: 350,height:50,alignment: .leading)
                    .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                    .cornerRadius(22)
                    .padding(.bottom,20)
                Text("联系方式")
                    .foregroundColor(.secondary)
                Text("V+TEC20040303")
                    .padding(20)
                    .frame(width: 350,height:50,alignment: .leading)
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

struct HelperView_Previews: PreviewProvider {
    static var previews: some View {
        HelperView()
    }
}
