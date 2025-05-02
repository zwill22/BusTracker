//
//  Operator.swift
//  BusTracker
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation

enum OperatorMode: String, Decodable {
    case bus = "Bus"
    case train = "Rail"
    case taxi = "Taxi"
    case ferry = "Ferry"
    case coach = "Coach"
    case tram = "Tram"
    case drt = "DRT"
    case underground = "Underground"
    case airline = "Airline"
    case metro = "Metro"
    case cableCar = "Cable Car"
    case permit = "Permit"
    case partlyDrt = "Partly DRT"
    case section19 = "Section 19"
    case none = "None"
    case other = "Other"
    
    
    func image() -> String {
        switch self {
        case .bus:
            return "bus.fill"
        case .train:
            return "train.side.rear.car"
        case .taxi:
            return "car.fill"
        case .ferry:
            return "ferry.fill"
        case .coach:
            return "bus.doubledecker.fill"
        case .tram:
            return "tram.fill"
        case .drt:
            return "figure.wave"
        case .underground:
            return "train.side.front.car"
        case .airline:
            return "airplane"
        case .metro:
            return "lightrail.fill"
        case .cableCar:
            return "cablecar.fill"
        case .permit:
            return "car.rear"
        default:
            return "figure.walk.circle.fill"
        }
    }
}

func isPhone(_ phoneNumber: String) -> Bool {
    let phoneRegex = "^(?:(?:\\(?(?:0(?:0|11)\\)?[\\s-]?\\(?|\\+)[0-9][0-9]?[0-9]?\\)?[\\s-]?(?:\\(?0\\)?[\\s-]?)?)|(?:\\(?0\\)?[\\s-]?))(?:(?:\\d{5}\\)?[\\s-]?\\d{4,5})|(?:\\d{4}\\)?[\\s-]?(?:\\d{5}|\\d{3}[\\s-]?\\d{3}))|(?:\\d{3}\\)?[\\s-]?\\d{3}[\\s-]?\\d{3,4})|(?:\\d{2}\\)?[\\s-]?\\d{4}[\\s-]?\\d{4}))$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    
    let isValidFormat = phoneTest.evaluate(with: phoneNumber)
        
    let allCharactersAreSame = Set(phoneNumber).count == 1
    
    return isValidFormat && !allCharactersAreSame
}

func isEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: email)
}

enum EnquiryType: Decodable {
    case email
    case phone
    case other
}

func getType(_ string: String) -> EnquiryType {
    if isPhone(string) {
        return .phone
    } else if isEmail(string) {
        return .email
    } else {
        return .other
    }
}

struct Enquiry: Decodable, Hashable {
    let type: EnquiryType
    let string: String
    
    init (string: String) {
        self.string = string
        self.type = getType(string)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let rawString = try? container.decode(String.self)
        
        guard let string = rawString else {
            throw OperatorError.missingData
        }
        
        self.init(string: string)
    }
}

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
            throw OperatorError.missingData
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
