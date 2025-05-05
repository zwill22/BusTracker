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
        if name.lowercased().contains("arriva") {
            return .green
        }
        
        if opCode == "PATS" {
            return .white
        }
        
        if opCode == "TANV" {
            return .red
        }
        
        if opCode == "LLCO" {
            return Color(Color.init(hex: 0xBD0E19))
        }
        
        return .primary.opacity(0.8)
    }
        
    var secondaryColour: Color {
        if name.lowercased().contains("arriva") {
            return .white
        }
        
        if opCode == "PATS" {
            return .red
        }
        
        if opCode == "TANV" {
            return .white
        }
        
        if opCode == "LLCO" {
            return Color(Color.init(hex: 0xAF991D))
        }
        
        return .accentColor
    }
}
