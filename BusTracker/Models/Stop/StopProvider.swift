//
//  StopProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation

@MainActor
class StopProvider: ObservableObject {
    @Published var stops: [Stop] = []
    @Published var maxStops: Int = 500
    @Published var searchText: String = ""
    private let client: StopClient
    
    func fetchStopsArea(
        mapLocation: MapLocation
    ) async throws {
        
        let newStops = try await client.stops(
            mapLocation: mapLocation,
            maxStops: maxStops
        )
        
        self.stops = Array(Set(self.stops + newStops))
    }
    
    func fetchStopCodes(
        codes: [String]
    ) async throws {
        
        let newStops: [Stop] = try await client.stops(stopCodes: codes)
        
        self.stops = newStops
    }
    
    var filteredStops: [Stop] {
        guard !searchText.isEmpty else {
            return stops
        }
        
        return stops.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.landmark?.lowercased().contains(searchText.lowercased()) ?? false ||
            $0.shortName?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    init(client: StopClient = StopClient()) {
        self.client = client
    }
}
