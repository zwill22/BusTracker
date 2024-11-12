//
//  XML.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

private struct Vehicles: Decodable {
    var buses: [Bus]
    
    enum CodingKeys: String, CodingKey {
        case buses = "VehicleActivity"
    }
}

struct XML: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
    
    private enum ServiceDeliveryCodingKeys: String, CodingKey {
        case vehicleMonitoringDelivery = "VehicleMonitoringDelivery"
    }
    
    private(set) var buses: [Bus] = []
    
    init (from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let serviceDeliveryContainer = try rootContainer.nestedContainer(keyedBy: ServiceDeliveryCodingKeys.self, forKey: .serviceDelivery)
        let vehicles = try serviceDeliveryContainer.decode(Vehicles.self, forKey: .vehicleMonitoringDelivery)
        
        buses = vehicles.buses
    }
}
