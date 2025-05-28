//
//  Settings.swift
//  BusTracker
//
//  Created by Zack Williams on 27-05-2025.
//

import SwiftUI


struct BuyMeButton: View {
    @Environment(\.openURL) private var openURL
    
    private func buyMeACola() {
        if let url = URL(string: "https://buymeacoffee.com/zmwill") {
            openURL(url)
        }
    }
    
    var body: some View {
        Button(action: buyMeACola) {
            Image(.buymeacoffee).resizable().scaledToFit()
        }
    }
}

#Preview {
    BuyMeButton()
}
