//
//  OperatorColour.swift
//  BusTracker
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Operator {
    var primaryColour: Color {
        switch opCode {
        case "LLCO":
            return Color(Color.init(hex: 0xBD0E19))
        case "ACYM":
            return .green
        case "PATS":
            return .white
        case "TANV":
            return .red
        default:
            return .black
        }
    }
    var secondaryColour: Color {
        switch opCode {
        case "LLCO":
            return Color(Color.init(hex: 0xAF991D))
        case "ACYM":
            return .white
        case "PATS":
            return .red
        case "TANV":
            return .white
        default:
            return .white
        }
    }
}
