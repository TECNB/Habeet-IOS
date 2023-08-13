//
//  TagItemNullView.swift
//  Habeet
//
//  Created by TEC on 2023/8/17.
//

import SwiftUI

struct TagItemNullView: View {
    var body: some View {
        VStack{
            HStack{
                Image("tagLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60,height: 60)
                    .padding(.trailing,10)

                VStack(alignment: .leading){
                    Text("还没有建立标签")
                        .bold()
                        .font(.headline)
                        .frame(width: 240,height: 20,alignment: .leading)
                    Text("快去建立吧")
                        .frame(width: 240,height: 20,alignment: .leading)
                }
                
            }
            .frame(width: 350,height: 90)
            .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
            .cornerRadius(22.5)
            .padding(.top,30)
            Spacer()
        }
        
    }
}

struct TagItemNullView_Previews: PreviewProvider {
    
    static var previews: some View {
        TagItemNullView()
    }
}
