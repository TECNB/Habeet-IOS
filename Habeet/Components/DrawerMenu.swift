//
//  DrawerMenu.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

struct DrawerMenu: View {
    @EnvironmentObject private var userData: UserData
    
    @Binding var isDrawerOpen: Bool
    @Binding var ifShowTarget: Bool
    @Binding var showWhichView:Int
    
    @State private var timerTriggered = false
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Group {
                    VStack(alignment: .leading) {
                        Image("Avatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(rgba: (187, 255, 231, 1)), Color(rgba: (134, 255, 202, 1))]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Circle())
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2 // Align to the left half of the screen
                            }
                            .padding(.leading,30).padding(.bottom,10)
                        Text(userData.userName)      //动态
                            .bold()
                            .font(.title2)
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2 // Align to the left half of the screen
                            }
                            .padding(.leading,30).padding(.bottom,40)
                        
                        if showWhichView==0{
                            Button{
                                showWhichView=0
                                 
                            }label: {
                                //专注
                                HStack{
                                    Image("countDownAfter")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .padding(5)
                                        .background(Color.indigo)
                                        .cornerRadius(10)
                                    Text("专注")
                                        .foregroundColor(.indigo)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }
                        }else{
                            Button{
                                showWhichView=0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            // 2秒后触发计时器
                                            timerTriggered = true
                                        }

                            }label: {
                                //目标
                                HStack{
                                    Image("countDownBefore")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(.leading,5)
                                    
                                    Text("专注")
                                        .foregroundColor(.black)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }
                        }
                        
                        if showWhichView==1{
                            Button{
                                showWhichView=1
                                 
                            }label: {
                                //目标
                                HStack{
                                    Image("targetAfter")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .padding(5)
                                        .background(Color.indigo)
                                        .cornerRadius(10)
                                    Text("目标")
                                        .foregroundColor(.indigo)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }
                        }else{
                            Button{
                                showWhichView=1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            // 2秒后触发计时器
                                            timerTriggered = true
                                        }

                            }label: {
                                //目标
                                HStack{
                                    Image("targetBefore")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(.leading,5)
                                    
                                    Text("目标")
                                        .foregroundColor(.black)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }

                        }
                        
                        
                        
                        if showWhichView==2{
                            Button{
                                showWhichView=2
                                 
                            }label: {
                                //标签
                                HStack{
                                    Image("tagAfter")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .padding(5)
                                        .background(Color.indigo)
                                        .cornerRadius(10)
                                    Text("标签")
                                        .foregroundColor(.indigo)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }
                        }else{
                            Button{
                                showWhichView=2
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            // 2秒后触发计时器
                                            timerTriggered = true
                                        }

                            }label: {
                                //标签
                                HStack{
                                    Image("tagBefore")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(.leading,5)
                                    Text("标签")
                                        .foregroundColor(.black)
                                        .frame(width: 120,alignment: .leading)
                                    
                                }
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    geometry.size.width / 2
                                }
                                .cornerRadius(10)
                                .padding(.bottom,30)
                            }
                        }
                    }
                }
                Group{
                    if showWhichView==3{
                        Button{
                            showWhichView=3
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // 2秒后触发计时器
                                        timerTriggered = true
                                    }

                        }label: {
                            //商店
                            HStack{
                                Image("storeAfter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(5)
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                                Text("商店")
                                    .foregroundColor(.indigo)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }
                    }else{
                        Button{
                            showWhichView=3
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // 2秒后触发计时器
                                        timerTriggered = true
                                    }

                        }label: {
                            //商店
                            HStack{
                                Image("storeBefore")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,5)
                                
                                Text("商店")
                                    .foregroundColor(.black)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }
                    }
                    
                    if showWhichView==4{
                        Button{
                            showWhichView=4
                             
                        }label: {
                            //我的
                            HStack{
                                Image("userAfter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(5)
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                                Text("我的")
                                    .foregroundColor(.indigo)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }

                    }else{
                        Button{
                            showWhichView=4
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // 2秒后触发计时器
                                        timerTriggered = true
                                    }

                        }label: {
                            //我的
                            HStack{
                                Image("userBefore")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,5)
                                
                                
                                Text("我的")
                                    .foregroundColor(.black)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .cornerRadius(10)
                            .padding(.bottom,30)
                            
                        }
                    }
                    
                    if showWhichView==5{
                        Button{
                            showWhichView=5
                             
                        }label: {
                            //设置
                            HStack{
                                Image("settingAfter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(5)
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                                Text("设置")
                                    .foregroundColor(.indigo)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }

                    }else{
                        Button{
                            showWhichView=5
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // 2秒后触发计时器
                                        timerTriggered = true
                                    }

                        }label: {
                            //设置
                            HStack{
                                Image("settingBefore")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,5)
                                
                                Text("设置")
                                    .foregroundColor(.black)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }

                    }
                    
                    if showWhichView==6{
                        Button{
                            showWhichView=6
                            
                        }label: {
                            //关于
                            HStack{
                                Image("helpAfter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(5)
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                                Text("关于")
                                    .foregroundColor(.indigo)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(rgba: (205, 231, 255, 1)), Color(rgba: (193, 225, 255, 1))]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.bottom,80)
                        }
                        
                    }else{
                        Button{
                            showWhichView=6
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                // 2秒后触发计时器
                                timerTriggered = true
                            }

                        }label: {
                            //关于
                            HStack{
                                Image("helpBefore")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,5)
                                Text("关于")
                                    .foregroundColor(.black)
                                    .frame(width: 120,alignment: .leading)
                                
                            }
                            
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                geometry.size.width / 2
                            }
                            .cornerRadius(10)
                            .padding(.bottom,120)
                            
                        }
                    }
                    
                    
                    Button{
                        showWhichView=13
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            // 2秒后触发计时器
                            timerTriggered = true
                        }
                    }label: {
                        //登出
                        HStack{
                            Image("Logout")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(.leading,5)
                            Text("登出")
                                .frame(width: 120,alignment: .leading)
                                .foregroundColor(.red)
                        }
                        
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            geometry.size.width / 2
                        }
                        .cornerRadius(10)
                        .padding(.bottom,20)
                    }
                    NavigationCoverView(showWhichView: $showWhichView,timerTriggered:$timerTriggered)

                }
            }
            .padding(.top,-40)
                .frame(width: geometry.size.width / 2, height: geometry.size.height+40) // Set VStack height to screen height
                .background(Color.white)
            
            
        }
    }
}


struct Previews_DrawerMenu_Previews: PreviewProvider {
    
    static var previews: some View {
        let isDrawerOpen = Binding.constant(true)
        let showWhichView = Binding.constant(0)
        let ifShowTarget=Binding.constant(false)
        DrawerMenu(isDrawerOpen: isDrawerOpen, ifShowTarget: ifShowTarget, showWhichView: showWhichView).environmentObject(UserData())
    }
}
