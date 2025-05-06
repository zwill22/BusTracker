//
//  Vehicle.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

struct Vehicle: Identifiable {
    let time: Date
    let details: VehicleDetails
    let id: String
    let vehicleOperator: Operator?
}

extension Vehicle: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case time = "RecordedAtTime"
        case id = "ItemIdentifier"
        case monitoredJourney = "MonitoredVehicleJourney"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawID = try? values.decode(String.self, forKey: .id)
        let rawDetails = try? values.decode(VehicleDetails.self, forKey: .monitoredJourney)
        
        guard let time = rawTime,
              let id = rawID,
              let details = rawDetails
        else {
            throw VehicleError.missingData
        }
        
        self.time = time
        self.id = id
        self.details = details
        self.vehicleOperator = nil
    }
    
    init (vehicle: Vehicle, operators: [Operator]) {
        self.time = vehicle.time
        self.details = vehicle.details
        self.id = vehicle.id
        self.vehicleOperator = operators.first { $0.opCode == vehicle.details.operatorCode }
    }
}
