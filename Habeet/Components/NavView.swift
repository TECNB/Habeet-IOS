//
//  NavView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI



struct NavView: View {
    @EnvironmentObject private var userData: UserData
    
    @Binding var ifShowMenu:Bool
    @Binding var showWhichView:Int
    @Binding var ifDelete:Bool
    var body: some View {
        HStack {
            Button{
                ifShowMenu.toggle()
            }label: {
                Image("Menu")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28.0, height: 28.0)
            }
            
            
            Text(userData.userName)    //动态
                .bold()
                .font(.title3)
            
            Spacer()
            
            if showWhichView==1||showWhichView==2 {
                Button{
                    ifDelete.toggle()
                }label: {
                    Image("Delete")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                
            }else{
                HStack{
                    Text("Points")
                        .font(.footnote)
                        .foregroundColor(.indigo)
                        .padding(.leading,10)
                    Text(String(userData.point))  //动态
                        .font(.footnote)
                        .frame(height: 25)
                        .foregroundColor(.secondary)
                    Image("Coin")
                        .padding(.trailing,10)
                }
                .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
                .cornerRadius(22.5)
                .padding(.trailing,10)
                //下面为用户头像
                Image("Avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40) // 调整大小，适应你的需求
                    .background(LinearGradient(gradient: Gradient(colors: [Color(rgba: (187, 255, 231, 1)), Color(rgba: (134, 255, 202, 1))]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Circle())
                
            }
            
        }.padding(.leading,20).padding(.trailing,20)
    }
}
