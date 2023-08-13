//
//  TargetItemNullView.swift
//  Habeet
//
//  Created by TEC on 2023/8/19.
//

import SwiftUI


struct TargetItemNullView: View {
    let targetStatus:Int
    var body: some View {
        HStack{
            Image("targetLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60,height: 60)
                .padding(.leading,20)
            VStack(alignment: .leading){
                if targetStatus==0{
                    Text("还没有随时完成的目标")
                        .bold()
                        .font(.title2)
                    Text("快来建立吧")
                        .foregroundColor(Color.secondary)
                }else if targetStatus==1{
                    Text("还没有限时完成的目标")
                        .bold()
                        .font(.title2)
                    Text("快来建立吧")
                        .foregroundColor(Color.secondary)
                }else if targetStatus==2{
                    Text("还没有已经完成的目标")
                        .bold()
                        .font(.title2)
                    Text("快去完成吧")
                        .foregroundColor(Color.secondary)
                }else if targetStatus==3{
                    Text("还没有已经过期的目标")
                        .bold()
                        .font(.title2)
                    Text("继续保持吧")
                        .foregroundColor(Color.secondary)
                }

                
            }.frame(width: 230,height: 120,alignment: .leading)
                .padding(.leading,10)
            Spacer()
        }
        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
            .cornerRadius(22.5)
            .padding([.leading,.trailing],15)
            .padding([.top,.bottom],10)

    }
}

struct TargetItemNullView_Previews: PreviewProvider {
    static var previews: some View {
        TargetItemNullView(targetStatus:0)
    }
}
