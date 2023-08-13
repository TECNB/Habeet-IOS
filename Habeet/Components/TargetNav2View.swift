//
//  TargetNav2View.swift
//  Habeet
//
//  Created by TEC on 2023/8/19.
//

import SwiftUI

struct TargetNav2View: View {
    @Binding var targetStatus:Int
    var body: some View {
        HStack(spacing: 50){
            if targetStatus==0{
                Button{
                    targetStatus=0
                }label: {
                    Text("进行中")
                        .bold()
                        .padding([.leading,.trailing],18)
                        .padding([.top,.bottom],8)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                        .cornerRadius(22.5)
                        .frame(width: 100,height: 50)
                }
                Button{
                    targetStatus=1
                }label: {
                    Text("已完成")
                        .foregroundColor(Color.secondary)
                }
                Button{
                    targetStatus=2
                }label: {
                    Text("已过期")
                        .foregroundColor(Color.secondary)
                }

                Image("targetLogo2")
            }else if targetStatus==1{
                Button{
                    targetStatus=0
                }label: {
                    Text("进行中")
                    .foregroundColor(Color.secondary)
                }
                Button{
                    targetStatus=1
                }label: {
                    Text("已完成")
                        .bold()
                        .padding([.leading,.trailing],18)
                        .padding([.top,.bottom],8)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                        .cornerRadius(22.5)
                        .frame(width: 100,height: 50)
                    
                }
                Button{
                    targetStatus=2
                }label: {
                    Text("已过期")
                        .foregroundColor(Color.secondary)
                }

                Image("targetLogo2")

            }else if targetStatus==2{
                Button{
                    targetStatus=0
                }label: {
                    Text("进行中")
                        .foregroundColor(Color.secondary)
                }
                Button{
                    targetStatus=1
                }label: {
                    Text("已完成")
                        .foregroundColor(Color.secondary)
                }
                Button{
                    targetStatus=2
                }label: {
                    Text("已过期")
                        .bold()
                        .padding([.leading,.trailing],18)
                        .padding([.top,.bottom],8)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                        .cornerRadius(22.5)
                        .frame(width: 100,height: 50)
                }

                Image("targetLogo2")

            }
            
        }

    }
}

struct TargetNav2View_Previews: PreviewProvider {
    static var previews: some View {
        let targetStatus=Binding.constant(0)
        TargetNav2View(targetStatus:targetStatus)
    }
}
