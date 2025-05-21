//
//  VehiclePreview.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

extension Vehicle {
    static var preview: Vehicle {
        
        let previewDetails = VehicleDetails(
            lineNumber: "X11",
            operatorCode: "ARV",
            vehicleRef: "FAKE_VEHICLE_REF",
            location: VehicleLocation(latitude: 53.1, longitude: -3.08),
            origin: "Atown",
            originRef: "AtownOriginRef",
            destination: "Btown",
            destinationRef: "BtownDestinationRef",
            originDepartureTime: Date(timeIntervalSinceNow: -1000)
        )
        
        let previewOperator = Operator(
            id: "123456789",
            name: "A Fake Operator",
            opCode: "ARV",
            mode: .bus,
            enquiries: [
                Enquiry(string: "0123456789"),
                Enquiry(string: "email@example.com")
            ],
            address: "1 Fake Street, Anytown, UK",
            twitter: "@twitter",
            website: "https://www.example.com"
        )
        
        let previewStop = Stop(
            id: "StopRef",
            name: "Big stop",
            shortName: "Town",
            landmark: nil,
            street: "Town Street",
            localityCode: "local123",
            locality: "Local",
            parentLocality: "Local Area",
            town: "Big Town",
            suburb: "Out of Town",
            location: VehicleLocation(latitude: 53.05, longitude: -3.00),
            stopType: .busStationEntrance,
            busStopType: "FAKE",
            bearing: "SE"
        )
            
        
        let previewVehicle = Vehicle(
            time: Date(timeIntervalSinceNow: 0),
            details: previewDetails,
            id: "1234567890",
            vehicleOperator: previewOperator,
            origin: previewStop,
            destination: previewStop
        )
    
        return previewVehicle
    }
}
