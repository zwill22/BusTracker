//
//  XML.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

struct XML: Decodable, Encodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
    
    private enum ServiceDeliveryCodingKeys: String, CodingKey {
        case vehicleMonitoringDelivery = "VehicleMonitoringDelivery"
    }
    
    private enum VehicleMonitoringDeliveryCodingKeys: String, CodingKey {
        case vehicleActivity = "VehicleActivity"
    }
    
    private(set) var buses: [Bus] = []
    
    init (from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let serviceDeliveryContainer = try rootContainer.nestedContainer(keyedBy: ServiceDeliveryCodingKeys.self, forKey: .serviceDelivery)
        let vehicleMonitoringContainer = try serviceDeliveryContainer.nestedContainer(keyedBy: VehicleMonitoringDeliveryCodingKeys.self, forKey: .vehicleMonitoringDelivery)
    
        if let vehicleActivity = try? vehicleMonitoringContainer.decode(Bus.self, forKey: .vehicleActivity) {
            buses.append(vehicleActivity)
        }
    }
}
