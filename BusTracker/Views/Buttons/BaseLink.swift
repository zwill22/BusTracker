//
//  BaseLink.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct BaseLink: View {
    @Environment(\.openURL) private var openURL
    var label: String?
    var urlString: String
    var image: Image
    
    var body: some View {
        BaseButton(strings: [label ?? urlString], image: image) {
            if let url = URL(string: urlString) {
                openURL(url)
             }
        }
    }
}

#Preview {
    BaseLink(urlString: "https://www.google.com", image: Image(systemName: "network"))
}
