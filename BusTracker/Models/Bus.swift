//
//  Bus.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

 import Foundation

struct Bus {
    let time: Date
    let vehicleUniqueId: String
}

extension Bus: Identifiable {
    var id: String { vehicleUniqueId }
}

extension Bus: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case time = "RecordedAtTime"
        case vehicleUniqueId = "ItemIdentifier"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawCode = try? values.decode(String.self, forKey: .vehicleUniqueId)
        
        guard let time = rawTime,
              let code = rawCode
        else {
            throw BusError.missingData
        }
        
        self.time = time
        self.vehicleUniqueId = code
    }
}
