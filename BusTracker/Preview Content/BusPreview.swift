//
//  BusPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

extension Bus {
    static var preview: Bus {
        
        let previewDetails = BusDetails(
            lineNumber: "X11",
            operatorCode: "ARV",
            vehicleRef: "FAKE_VEHICLE_REF",
            location: BusLocation(latitude: 53, longitude: -3),
            origin: "Atown",
            destination: "Btown",
            originDepartureTime: Date(timeIntervalSinceNow: -1000)
        )
        
        let previewBus = Bus(
            time: Date(timeIntervalSinceNow: 0),
            details: previewDetails,
            id: "1234567890"
        )
    
        return previewBus
    }
}
