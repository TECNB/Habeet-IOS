//
//  HabeetApp.swift
//  Habeet
//
//  Created by TEC on 2023/8/7.
//

import SwiftUI

@main
struct HabeetApp: App {
    @StateObject private var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
