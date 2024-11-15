//
//  ToolbarStatus.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

struct ToolbarStatus: View {
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var busCount: Int
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Checking for Buses...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(busCount) Buses")
                    .foregroundStyle(Color.secondary)
            } else {
                let lastUpdateDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdateDate.formatted(.relative(presentation: .named)))")
                Text("\(busCount) Buses")
                    .foregroundStyle(Color.secondary)
            }
        }
        .font(.caption)
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 40)) {
    
    ToolbarStatus(
        isLoading: true,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        busCount: 125
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantFuture.timeIntervalSince1970,
        busCount: 10_000
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.now.timeIntervalSince1970,
        busCount: 10000
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        busCount: 10000
    )
}
