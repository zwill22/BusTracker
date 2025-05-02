//
//  WebButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

func cleanAddress(_ input: String) -> String {
    let result = input.split(separator: "#").compactMap { address in
        if address != "" {
            return String(address)
        } else {
            return nil
        }
    }
    
    if result.isEmpty {
        return ""
    }
    
    if result.count == 1 {
        return result[0]
    }
    
    if let resultFirst = result.first(where: { $0.contains("http") } ){
        return resultFirst
    } else {
        return result[0]
    }
}

struct WebButton: View {
    var webAddress: URL
    
    var body: some View {
        Link(destination: webAddress) {
            DetailRow(string: webAddress.relativeString, image: Image(systemName: "network"))
        }
    }
    
    init(inputAddress: String) {
        let address = cleanAddress(inputAddress)
        
        self.webAddress = URL(string: address) ?? URL(string: "https://www.google.com")!
    }
}

#Preview {
    WebButton(inputAddress: "https://www.github.com")
}
