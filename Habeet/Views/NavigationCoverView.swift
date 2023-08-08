//
//  NavigationCoverView.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI


struct NavigationCoverView: View {
    @Binding var showWhichView: Int
    @Binding var timerTriggered: Bool
        
    var body: some View {
        switch showWhichView {
            case 0:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    TimerView()
                    })
            case 1:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    TargetView()
                    })

            case 2:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    TagView()
                    })

            case 3:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    StoreView()
                    })
            case 4:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    UserView()
                    })
            case 5:
                NullView()
                    .fullScreenCover(isPresented: $timerTriggered, content: {
                    // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                    SettingView()
                    })
            case 6:
                NullView()
                .fullScreenCover(isPresented: $timerTriggered, content: {
                        // 在此处放置其他您希望在全屏覆盖视图上显示的内容
                        HelperView()
                    })
            default:
                EmptyView()
        }

    }
}
