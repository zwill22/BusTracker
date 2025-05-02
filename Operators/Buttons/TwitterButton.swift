//
//  TwitterButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct TwitterButton: View {
    var webAddress: URL
    
    var body: some View {
        Link(destination: webAddress) {
            DetailRow(string: webAddress.relativeString, image: Image(.twitter64).renderingMode(.template))
        }
    }
    
    init(twitterHandle: String) {
        let name = String(twitterHandle.dropFirst())
        let address = "https://twitter.com/\(name)"
        self.webAddress = URL(string: address)!
    }
}

#Preview {
    TwitterButton(twitterHandle: "@Cymru")
}
