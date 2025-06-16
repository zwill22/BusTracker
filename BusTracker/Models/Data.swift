//
//  Data.swift
//  BusTracker
//
//  Created by Zack Williams on 29-05-2025.
//

import SwiftData

@Model
class UserSettings {
    var maxVehicles: Int
    
    init(maxVehicles: Int) {
        self.maxVehicles = maxVehicles
    }
}
