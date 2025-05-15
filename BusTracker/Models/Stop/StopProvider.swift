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
    private var initialised: Bool = false
    
    private let client: StopClient
    
    func fetchStops() async throws {
        if initialised {
            return
        }
        
        let stops = try await client.stops;
        self.stops = stops
        self.initialised = true
    }
    
    init(client: StopClient = StopClient()) {
        self.client = client
    }
}
