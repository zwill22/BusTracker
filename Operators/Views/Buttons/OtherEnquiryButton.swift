//
//  OtherEnquiryButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct OtherEnquiryButton: View {
    var string: String
    
    var body: some View {
        BaseButton(strings: [string], image: Image(systemName: "message.circle.fill"))
    }
}

#Preview {
    OtherEnquiryButton(string: "Other enquiries")
}
