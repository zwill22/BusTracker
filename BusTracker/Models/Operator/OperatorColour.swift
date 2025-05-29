//
//  OperatorColour.swift
//  BusTracker
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

typealias Colour = Color

extension Colour {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Operator {
    var primaryColour: Colour {
        if name.lowercased().contains("arriva") {
            return .init(hex: 0x2EBDCE)
        }
        
        if name.lowercased().contains("stagecoach") {
            return .init(hex: 0x36A2F5)
        }
        
        if opCode == "PATS" {
            return .white
        }
        
        if opCode == "TANV" {
            return .init(hex: 0x06223A)
        }
        
        if opCode == "LLCO" {
            return .init(hex: 0xBD0E19)
        }
        
        if opCode == "A2BV" {
            return .init(hex: 0xFFFFFF)
        }
        
        if opCode == "AINT" {
            return .init(hex: 0xAC1418)
        }
        
        if opCode == "DAGC" {
            return .red
        }
        
        if opCode == "ALSC" {
            return .init(hex: 0x2B6CA3)
        }
        
        if opCode == "MHCO" {
            return .init(hex: 0x113450)
        }
        
        if opCode == "SARG" {
            return .init(hex: 0xCA2727)
        }
        
        if let url = website {
            if url.contains("firstbus") {
                return .init(hex: 0x2D007D)
            }
        }
        
        return .primary.opacity(0.8)
    }
        
    var secondaryColour: Colour {
        if name.lowercased().contains("arriva") {
            return .offWhite
        }
        
        if name.lowercased().contains("stagecoach") {
            return .init(hex: 0xF5B65F)
        }
        
        if opCode == "PATS" {
            return .init(hex: 0xBF1E2E)
        }
        
        if opCode == "TANV" {
            return .white
        }
        
        if opCode == "LLCO" {
            return .init(hex: 0xAF991D)
        }
        
        if opCode == "A2BV" {
            return .init(hex: 0x162A82)
        }
        
        if opCode == "AINT" {
            return .init(hex: 0xF4EFDA)
        }
        
        if opCode == "DAGC" {
            return .yellow
        }
        
        if opCode == "ALSC" {
            return .init(hex: 0xFFFFFF)
        }
        
        if opCode == "MHCO" {
            return .init(hex: 0xEBCB00)
        }
        
        if opCode == "SARG" {
            return .init(hex: 0x746644)
        }
        
        if let url = website {
            if url.contains("firstbus") {
                return .init(hex: 0xFD1BE0)
            }
        }
        
        return .accentColor
    }
}
