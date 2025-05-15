//
//  Stop.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation

struct Stop: Identifiable {
    let id: String
    let name: String
    let shortName: String?
    let street: String?
    let localityCode: String
    let locality: String
    let parentLocality: String?
    let location: VehicleLocation
    let stopType: String
    let busStopType: String?
    let bearing: String?
}

extension Stop: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "ATCOCode"
        case name = "CommonName"
        case shortName = "ShortCommonName"
        case street = "Street"
        case localityCode = "NptgLocalityCode"
        case locality = "LocalityName"
        case parentLocality = "ParentLocalityName"
        case stopType = "StopType"
        case busStopType = "BusStopType"
        case bearing = "Bearings"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawID = try? values.decode(String.self, forKey: .id)
        let rawName = try? values.decode(String.self, forKey: .name)
        let rawLocalityCode = try? values.decode(String.self, forKey: .localityCode)
        let rawLocality = try? values.decode(String.self, forKey: .locality)
        let rawLocation = try? VehicleLocation(from: decoder)
        let rawStopType = try? values.decode(String.self, forKey: .stopType)
        
        guard let id = rawID,
              let name = rawName,
              let localityCode = rawLocalityCode,
              let locality = rawLocality,
              let location = rawLocation,
              let stopType = rawStopType
        else {
            throw OperatorError.missingData // TODO: StopError
        }
        
        self.id = id
        self.name = name
        self.localityCode = localityCode
        self.locality = locality
        self.location = location
        self.stopType = stopType
        
        self.shortName = try? values.decode(String.self, forKey: .shortName)
        self.street = try? values.decode(String.self, forKey: .street)
        self.parentLocality = try? values.decode(String.self, forKey: .parentLocality)
        self.busStopType = try? values.decode(String.self, forKey: .busStopType)
        self.bearing = try? values.decode(String.self, forKey: .bearing)
    }
}
