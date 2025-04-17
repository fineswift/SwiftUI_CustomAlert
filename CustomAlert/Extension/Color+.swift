//
//  Color+.swift
//  CustomAlert
//
//  Created by 허광호 on 4/17/25.
//

import SwiftUI

extension Color {
    init(_ red: Int, _ green: Int, _ blue: Int, _ opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double(red) / 255.0,
            green: Double(green) / 255.0,
            blue: Double(blue) / 255.0,
            opacity: opacity
        )
    }
}
