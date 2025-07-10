//
//  RefreshButton.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

struct RefreshButton: View {
    @Binding var isLoading: Bool
    
    var action: () -> Void = {}
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            Button(action: action) {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RefreshButton(isLoading: .constant(false))
    RefreshButton(isLoading: .constant(true))
}
