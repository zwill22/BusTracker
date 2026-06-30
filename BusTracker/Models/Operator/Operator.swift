//
//  Operator.swift
//  BusTracker
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation

struct Operator: Identifiable {
    let id: String
    let name: String
    let opCode: String
    let mode: OperatorMode
    let enquiries: [Enquiry]
    let address: String?
    let twitter: String?
    let website: String?
}


extension Operator: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "PubNmId"
        case name = "OperatorPublicName"
        case opCode = "NOCCODE"
        case mode = "Mode"
        case enquires1 = "TTRteEnq"
        case enquires2 = "FareEnq"
        case address = "ComplEnq"
        case twitter = "Twitter"
        case website = "Website"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let rawID = try? values.decode(String.self, forKey: .id)
        let rawName = try? values.decode(String.self, forKey: .name)
        let rawOpCode = try? values.decode(String.self, forKey: .opCode)
        let rawOpMode = try? values.decode(OperatorMode.self, forKey: .mode)
        
        let enquiries1 = try? values.decode(Enquiry.self, forKey: .enquires1)
        let enquiries2 = try? values.decode(Enquiry.self, forKey: .enquires2)
        
        guard let id = rawID,
              let name = rawName,
              let opCode = rawOpCode
        else {
            throw BusTrackerError.missingData
        }
        
        self.id = id
        self.name = name
        self.opCode = opCode
        
        var rawEnquiries: [Enquiry] = []
        
        if enquiries1 != nil {
            rawEnquiries.append(enquiries1!)
        }
        if enquiries2 != nil {
            rawEnquiries.append(enquiries2!)
        }
        
        self.mode = rawOpMode ?? .other
        self.enquiries = rawEnquiries
        self.address = try? values.decode(String.self, forKey: .address)
        self.twitter = try? values.decode(String.self, forKey: .twitter)
        self.website = try? values.decode(String.self, forKey: .website)
    }
}
