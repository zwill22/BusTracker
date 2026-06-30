//
//  SettingsBlock.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct SettingsBlock: View {
    var height: CGFloat = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.dark)
            .frame(width: 80, height: height)
            .overlay {
                Image(systemName: "gear")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.offWhite)
            }
        
    }
}

#Preview {
    SettingsBlock()
}
