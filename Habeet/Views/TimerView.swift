//
//  Timer.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct TimerView: View {
    @State private var ifShowTargetMenu:Bool=false
    @State private var ifShowMenu:Bool=false
    @State private var ifShowTarget:Bool=false
    @State private var showWhichView:Int = 0

    
    var body: some View {
        ZStack{
            VStack {
                if ifShowMenu{
                    HStack{
                        
                    }.frame(height: 45.8)
                    
                }else{
                    //这里是第一行的Nav
                    NavView(ifShowMenu:$ifShowMenu)
                }
                
                //这是第二行的目标Nav
                HStack(spacing: 250.0){
                    Text("目标")
                        .padding(.leading, 20.0)
                        .frame(height: 40)
                    if ifShowTargetMenu{
                        Button{
                            // 切换 ifShowTargetMenu 的状态
                            ifShowTargetMenu.toggle()
                        }label: {
                            Image("arrowUp")
                                .padding(.trailing, 20.0)
                            
                        }
                        
                    }else{
                        Button{
                            // 切换 ifShowTargetMenu 的状态
                            ifShowTargetMenu.toggle()
                        }label: {
                            Image("arrowDown")
                                .padding(.trailing, 20.0)
                            
                        }
                    }
                    
                }
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                .cornerRadius(22.5)
                .frame(width: 350.0, height: 60.0)
                .animation(.easeInOut, value: ifShowTargetMenu)
                
                Spacer()
                // 添加一个背景为白色的视图，放在目标下方，覆盖住学习的VStack
                Rectangle()
                    .fill(Color.white)
                    .overlay {
                        
                        //这是主要的计时View
                        VStack{
                            Image("Progress")
                                .frame(width: 330,height: 280)
                            Text("学习")  //动态
                                .font(.system(size: 14))
                                .foregroundColor(.indigo)
                                .frame(width: 50,height: 28)
                                .background(Color(rgba: (207, 200, 255, 1)))
                                .cornerRadius(20) // 调整圆角半径，适应你的需求
                                .padding(.top,-10)
                            Text("00:30:00")   //动态
                                .foregroundColor(.indigo)
                                .font(.system(size: 50))
                            
                            Text("开始学习吧")
                                .frame(height: 40)
                                .padding(.top,-30).padding(.bottom,40)
                            Button(role: .none, action: {
                                
                            }, label: {
                                Text("开始")
                                    .bold()
                                    .font(.title2)
                                    .frame(width: 100,height: 30)
                            })
                            
                            .cornerRadius(22) //建立圆角按钮
                            .frame(width: 300,height: 100)
                            .buttonStyle(.borderedProminent)
                            .padding(.bottom,20)
                        }
                        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                        .cornerRadius(22.5)
                        .frame(width: 320,height: 600.0)
                        .padding(.bottom,20)
                        
                        if ifShowTargetMenu{
                            //下面是targetMenu
                            VStack{
                                HStack{
                                    Text("测试1")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image("Coin")
                                    Text("X1")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .padding(.leading,-5).padding(.trailing,5)
                                    Text("还有3天")
                                        .bold()
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                                HStack{
                                    Text("测试2")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image("Coin")
                                    Text("X2")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .padding(.leading,-5).padding(.trailing,5)
                                    Text("还有2天")
                                        .bold()
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                                HStack{
                                    Text("测试3")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image("Coin")
                                    Text("X3")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .padding(.leading,-5).padding(.trailing,5)
                                    Text("还有1天")
                                        .bold()
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                                HStack{
                                    Text("测试4")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image("Coin")
                                    Text("X4")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                        .padding(.leading,-5).padding(.trailing,5)
                                    Text("还有5天")
                                        .bold()
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                                
                            }.padding([.top, .leading, .bottom],20)      .background(Color.white)
                                .cornerRadius(20)
                                .frame(width: 320, height: 650, alignment: .top)
                            
                            
                        }
                        
                        
                    }.animation(.easeInOut, value: ifShowTargetMenu)
            }
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
                    DrawerMenu(isDrawerOpen: $ifShowMenu, ifShowTarget: $ifShowTarget, showWhichView: $showWhichView)
                    
                }
            }
            
        }
    }
}

struct Previews_TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
