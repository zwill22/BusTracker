//
//  VehicleLocation.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

struct VehicleLocation: Hashable {
    var latitude: Double
    var longitude: Double
}

extension VehicleLocation: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
