//
//  StoreItemNullView.swift
//  Habeet
//
//  Created by TEC on 2023/8/20.
//

import SwiftUI

struct StoreItemNullView: View {
    var body: some View {
        VStack{
            //商品界面的第一个色块
            VStack{
                
            }
                .frame(width: 300,height: 230)
                .background(Color(red: 160/255, green: 215/255, blue: 231/255))
                .cornerRadius(22.5)
                
            VStack(){
                Text("还没有建立商品")
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.indigo)
                    .padding(.top,50)
                Text("快去建立吧")
                    .foregroundColor(Color.secondary)
                    .padding(.bottom,10)
                
                Spacer()
            }
            
            .frame(width: 280,height: 250)
        }
        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
        .cornerRadius(22.5)
        .padding(.top,40)
        .overlay {
            Image("storeLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 400,height: 400)
                .padding(.bottom,210)
        }.shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // 添加阴影效果
    }
}

struct StoreItemNullView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemNullView().environmentObject(UserData())
    }
}
