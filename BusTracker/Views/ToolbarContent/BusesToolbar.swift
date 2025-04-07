//
//  BusesToolbar.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

extension Buses {
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .automatic) {
            RefreshButton {
                Task {
                    await fetchBuses()
                }
            }
            
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: lastUpdated,
                busCount: provider.buses.count
            )
            Spacer()
        }
    }
}
