//
//  ColorExtensions.swift
//  Habeet
//
//  Created by TEC on 2023/8/12.
//

import SwiftUI

extension Color {
    init(rgba: (Double, Double, Double, Double)) {
        self.init(
            .sRGB,
            red: rgba.0 / 255,
            green: rgba.1 / 255,
            blue: rgba.2 / 255,
            opacity: rgba.3
        )
    }
}
