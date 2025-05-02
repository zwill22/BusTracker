//
//  BusLocation.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import MapKit

struct BusLocation {
    var latitude: Double
    var longitude: Double
}

extension BusLocation: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    func getPlace() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
