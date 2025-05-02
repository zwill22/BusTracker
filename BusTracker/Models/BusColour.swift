//
//  BusColour.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

extension Bus {
    var primaryColour: Color {
        switch details.operatorCode {
        case "ACYM":
            return .green
        case "PATS":
            return .white
        case "TANV":
            return .red
        default:
            print(details.operatorCode)
            return .black
        }
    }
    var secondaryColour: Color {
        switch details.operatorCode {
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
