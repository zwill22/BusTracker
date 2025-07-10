//
//  Enquiry.swift
//  BusTracker
//
//  Created by Zack Williams on 07-05-2025.
//

import Foundation

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
            throw BusTrackerError.missingData
        }
        
        self.init(string: string)
    }
}
