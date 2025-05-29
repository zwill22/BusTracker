//
//  Stop.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation

struct Stop: Identifiable, Hashable {
    let id: String
    let name: String
    let shortName: String?
    let landmark: String?
    let street: String?
    let localityCode: String
    let locality: String
    let parentLocality: String?
    let town: String?
    let suburb: String?
    let location: VehicleLocation?
    let stopType: StopType
    let busStopType: BusStopType?
    let bearing: String?
}

extension Stop: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "ATCOCode"
        case name = "CommonName"
        case shortName = "ShortCommonName"
        case landmark = "Landmark"
        case street = "Street"
        case localityCode = "NptgLocalityCode"
        case locality = "LocalityName"
        case parentLocality = "ParentLocalityName"
        case town = "Town"
        case suburb = "Suburb"
        case stopType = "StopType"
        case busStopType = "BusStopType"
        case bearing = "Bearing"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawID = try? values.decode(String.self, forKey: .id)
        let rawName = try? values.decode(String.self, forKey: .name)
        let rawLocalityCode = try? values.decode(String.self, forKey: .localityCode)
        let rawLocality = try? values.decode(String.self, forKey: .locality)
        let rawStopType = try? values.decode(StopType.self, forKey: .stopType)
        
        guard let id = rawID,
              let name = rawName,
              let localityCode = rawLocalityCode,
              let locality = rawLocality,
              let stopType = rawStopType
        else {
            throw OperatorError.missingData // TODO: StopError
        }
        
        self.id = id
        self.name = name
        self.localityCode = localityCode
        self.locality = locality
        self.stopType = stopType
        
        self.location = try? VehicleLocation(from: decoder)
        self.shortName = try? values.decode(String.self, forKey: .shortName)
        self.landmark = try? values.decode(String.self, forKey: .landmark)
        self.street = try? values.decode(String.self, forKey: .street)
        self.parentLocality = try? values.decode(String.self, forKey: .parentLocality)
        self.town = try? values.decode(String.self, forKey: .town)
        self.suburb = try? values.decode(String.self, forKey: .suburb)
        self.busStopType = try? values.decode(BusStopType.self, forKey: .busStopType)
        self.bearing = try? values.decode(String.self, forKey: .bearing)
    }
}
