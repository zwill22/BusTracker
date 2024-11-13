//
//  Bus.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

struct BusDetails {
    let lineNumber: String
    let operatorCode: String
    let location: BusLocation
    let origin: String
    let destination: String
    let originDepartureTime: Date
}

extension BusDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case lineNumber = "LineRef"
        case operatorCode = "OperatorRef"
        case location = "VehicleLocation"
        case origin = "OriginName"
        case destination = "DestinationName"
        case originDepartureTime = "OriginAimedDepartureTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawLineNumber = try? values.decode(String.self, forKey: .lineNumber)
        let rawOperatorCode = try? values.decode(String.self, forKey: .operatorCode)
        let rawBusLocation = try? values.decode(BusLocation.self, forKey: .location)
        let rawOrigin = try? values.decode(String.self, forKey: .origin)
        let rawDestination = try? values.decode(String.self, forKey: .destination)
        let rawOriginDepartureTime = try? values.decode(Date.self, forKey: .originDepartureTime)
        
        guard let lineNumber = rawLineNumber,
              let operatorCode = rawOperatorCode,
              let busLocation = rawBusLocation,
              let origin = rawOrigin,
              let destination = rawDestination,
              let originDepartureTime = rawOriginDepartureTime
        else {
            throw BusError.missingData
        }
        
        self.lineNumber = lineNumber
        self.operatorCode = operatorCode
        self.location = busLocation
        self.origin = origin
        self.destination = destination
        self.originDepartureTime = originDepartureTime
    }
}

struct Bus: Identifiable {
    let time: Date
    let details: BusDetails
    let id: String
}

extension Bus: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case time = "RecordedAtTime"
        case id = "ItemIdentifier"
        case monitoredJourney = "MonitoredVehicleJourney"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)


        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawID = try? values.decode(String.self, forKey: .id)
        let rawDetails = try? values.decode(BusDetails.self, forKey: .monitoredJourney)
        
        guard let time = rawTime,
              let id = rawID,
              let details = rawDetails
        else {
            throw BusError.missingData
        }
        
        self.time = time
        self.id = id
        self.details = details
    }
}
