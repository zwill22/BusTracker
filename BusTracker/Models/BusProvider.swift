//
//  BusProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

@MainActor
class BusProvider: ObservableObject {
    @Published var buses: [Bus] = []
    
    let client: BusClient
    
    func fetchBuses() async throws {
        let nearestBuses = try await client.buses
        self.buses = nearestBuses
    }
    
    func deleteBuses(atOffsets offsets: IndexSet) {
        buses.remove(atOffsets: offsets)
    }
    
    init(client: BusClient = BusClient()) {
        self.client = client
    }
}
