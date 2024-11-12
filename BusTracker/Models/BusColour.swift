//
//  BusColour.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

extension Bus {
    var colour: Color {
        switch details.operatorCode {
        default:
            return .green
        }
    }
}
