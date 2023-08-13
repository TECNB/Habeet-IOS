//
//  TextAlertView.swift
//  Habeet
//
//  Created by TEC on 2023/8/17.
//

import SwiftUI

struct TextAlertView: View {
    //这里控制了视图的计时消失
    @State private var isTextVisible = true
    
    @Binding var textContant:String
    //这里的变量ifshowTextAlert使得该视图能在需要时多次出现
    @Binding var ifshowTextAlert:Bool
    var body: some View {
        VStack {
            if isTextVisible {
                Text(textContant)
                    .foregroundColor(Color.white)
                    .padding([.top,.bottom],10)
                    .padding([.leading,.trailing],15)
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            withAnimation {
                                isTextVisible = false
                            }
                            ifshowTextAlert=false
                        }
                    }
            }
        }
    }
}

struct TextAlertView_Previews: PreviewProvider {
    static var previews: some View {
        let textContant=Binding.constant("删除标签")
        let ifshowTextAlert=Binding.constant(true)
        
        TextAlertView(textContant:textContant,ifshowTextAlert:ifshowTextAlert)
    }
}
