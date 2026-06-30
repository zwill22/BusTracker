//
//  PhoneButton.swift
//  BusTracker
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct PhoneButton: View {
    var phoneNumber: String
    var phoneString: String {
        phoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
    
    var body: some View {
        BaseLink(label: phoneNumber, urlString: "tel:\(phoneString)", image: Image(systemName: "phone.fill"))
    }
}

#Preview {
    PhoneButton(phoneNumber: "+44 1234 567890")
}
