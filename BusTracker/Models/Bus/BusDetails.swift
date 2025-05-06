//
//  BusDetails.swift
//  BusTracker
//
//  Created by Zack Williams on 05-05-2025.
//

import Foundation

struct BusDetails {
    let lineNumber: String
    let operatorCode: String
    let vehicleRef: String
    let location: BusLocation
    let origin: String
    let destination: String
    let originDepartureTime: Date
}

extension BusDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case lineNumber = "LineRef"
        case operatorCode = "OperatorRef"
        case vehicleRef = "VehicleRef"
        case location = "VehicleLocation"
        case origin = "OriginName"
        case destination = "DestinationName"
        case originDepartureTime = "OriginAimedDepartureTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawLineNumber = try? values.decode(String.self, forKey: .lineNumber)
        let rawOperatorCode = try? values.decode(String.self, forKey: .operatorCode)
        let rawVehicleRef = try? values.decode(String.self, forKey: .vehicleRef)
        let rawBusLocation = try? values.decode(BusLocation.self, forKey: .location)
        let rawOrigin = try? values.decode(String.self, forKey: .origin)
        let rawDestination = try? values.decode(String.self, forKey: .destination)
        let rawOriginDepartureTime = try? values.decode(Date.self, forKey: .originDepartureTime)
        
        guard let location = rawBusLocation,
              let lineNumber = rawLineNumber,
              let operatorCode = rawOperatorCode,
              let vehicleRef = rawVehicleRef
        else {
            throw BusError.missingData
        }
        
        self.lineNumber = lineNumber
        self.operatorCode = operatorCode
        self.vehicleRef = vehicleRef
        self.location = location
        self.origin = rawOrigin ?? ""
        self.destination = rawDestination ?? ""
        self.originDepartureTime = rawOriginDepartureTime ?? .distantPast
    }
}
