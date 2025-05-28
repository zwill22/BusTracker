//
//  Settings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack {
            SettingsBlock(height: 80).padding(.top)
            Text("Settings").font(.title).padding(.bottom)
            Spacer()
            BuyMeButton().frame(height: 60)
        }
    }
}

#Preview {
    Settings()
}
