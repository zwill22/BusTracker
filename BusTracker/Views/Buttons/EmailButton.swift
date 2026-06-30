//
//  EmailButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct EmailButton: View {
    var email: String
    
    var body: some View {
        BaseLink(label: email, urlString: "mailto:\(email)", image: Image(systemName: "envelope.fill"))
    }
}

#Preview {
    EmailButton(email: "example@example.com")
}
