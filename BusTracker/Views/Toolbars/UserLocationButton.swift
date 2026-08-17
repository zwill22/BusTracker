//
//  UserLocationButton.swift
//  BusTracker
//
//  Created by Zack Williams on 17-08-2026.
//

import SwiftUI

struct UserLocationButton: View {
    @Binding var isLoading: Bool
    @Binding var centredOnUser: Bool

    var action: () -> Void = {}

    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            Button(action: action) {
                Label(
                    "Location",
                    systemImage: centredOnUser ? "location.fill" : "location"
                )
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserLocationButton(
        isLoading: .constant(false),
        centredOnUser: .constant(false)
    )
    UserLocationButton(
        isLoading: .constant(false),
        centredOnUser: .constant(true)
    )
    UserLocationButton(
        isLoading: .constant(true),
        centredOnUser: .constant(false)
    )
    UserLocationButton(
        isLoading: .constant(true),
        centredOnUser: .constant(true)
    )
}
