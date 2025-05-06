//
//  XML.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

private struct VehicleList: Decodable {
    var vehicles: [Vehicle]
    
    enum CodingKeys: String, CodingKey {
        case vehicles = "VehicleActivity"
    }
}

struct XML: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
    
    private enum ServiceDeliveryCodingKeys: String, CodingKey {
        case vehicleMonitoringDelivery = "VehicleMonitoringDelivery"
    }
    
    private(set) var vehicles: [Vehicle] = []
    
    init (from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let serviceDeliveryContainer = try rootContainer.nestedContainer(keyedBy: ServiceDeliveryCodingKeys.self, forKey: .serviceDelivery)
        let vehicleList = try serviceDeliveryContainer.decode(VehicleList.self, forKey: .vehicleMonitoringDelivery)
        
        vehicles = vehicleList.vehicles
    }
}
