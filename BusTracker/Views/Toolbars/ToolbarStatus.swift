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
    var count: Int
    var itemType: String
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Checking for \(itemType.lowercased())...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(count) \(itemType)")
                    .foregroundStyle(.secondary)
            } else {
                let lastUpdateDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdateDate.formatted(.relative(presentation: .named)))")
                Text("\(count) \(itemType)")
                    .foregroundStyle(.secondary)
            }
        }
        .font(.caption)
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 40)) {
    
    ToolbarStatus(
        isLoading: true,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        count: 125,
        itemType: "Vehicles"
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantFuture.timeIntervalSince1970,
        count: 10_000,
        itemType: "Buses"
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.now.timeIntervalSince1970,
        count: 10000,
        itemType: "Issues"
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        count: 10000,
        itemType: "Routes"
    )
}
