//
//  RefreshButton.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RefreshButton()
}
