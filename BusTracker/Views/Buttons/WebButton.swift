//
//  WebButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct WebButton: View {
    var webAddress: String
    
    private var cleanAddress: String {
        let result = webAddress.split(separator: "#").compactMap { address in
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
    
    var body: some View {
        BaseLink(urlString: cleanAddress, image: Image(systemName: "network"))
    }
}

#Preview {
    WebButton(webAddress: "https://www.github.com")
}
