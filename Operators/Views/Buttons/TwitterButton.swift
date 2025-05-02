//
//  TwitterButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct TwitterButton: View {
    var twitterHandle: String
    
    private var address: String {
        let name = String(twitterHandle.dropFirst())
        
        return "https://twitter.com/\(name)"
    }
    
    var body: some View {
        BaseLink(label: twitterHandle, urlString: address, image: Image(.twitter64).renderingMode(.template))
    }
}

#Preview {
    TwitterButton(twitterHandle: "@Cymru")
}
