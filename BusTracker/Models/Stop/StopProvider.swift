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
    
    private var versionOK = false
    
    private let client: StopClient
    
    func fetchVersion() async throws {
        if !versionOK {
            try await client.checkVersion();
            versionOK = true
        }
    }
    
    func fetchStopsArea(
        mapLocation: MapLocation,
        stops: [Stop]
    ) async throws {
        try await fetchVersion()
        
        let newStops = try await client.stops(
            mapLocation: mapLocation,
            maxStops: maxStops
        )
        
        self.stops = Array(Set(self.stops + newStops))
    }
    
    func fetchStopCodes(
        codes: [String]
    ) async throws {
        try await fetchVersion()
        
        let newStops: [Stop] = try await client.stops(stopCodes: codes)
        
        self.stops = newStops
    }
    
    init(client: StopClient = StopClient()) {
        self.client = client
    }
}
