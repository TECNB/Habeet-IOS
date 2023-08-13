//
//  ContentView.swift
//  Habeet
//
//  Created by TEC on 2023/8/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //计时视图
        LoginNavView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}

