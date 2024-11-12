//
//  BusLocation.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

struct BusLocation {
    var latitude: Double
    var longitude: Double
    
    init(latitude: String, longitude: String) {
        self.latitude = Double(latitude) ?? 0
        self.longitude = Double(longitude) ?? 0
    }
}
