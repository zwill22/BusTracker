//
//  Stops.swift
//  BusTracker
//
//  Created by Zack Williams on 15-05-2025.
//

import SwiftUI

struct Stops: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var stopProvider: StopProvider
    @EnvironmentObject var locationProvider: LocationProvider
    
    @State var isLoading: Bool = false
    @State private var error: StopError?
    @State private var hasError = false
    
    var body: some View {
        NavigationStack {
            StopMap(stops: $stopProvider.stops)
                .environmentObject(locationProvider)
            List {
                ForEach(stopProvider.stops) { stop in
                    NavigationLink(
                        destination: StopDetailView(stop: stop)
                    ) {
                        StopRow(stop: stop)
                    }
                }
            }
            .listStyle(.inset)
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchStops()
        }
    }
    
    
    func fetchStops() async {
        isLoading = true
        do {
            guard let location = locationProvider.mapLocation() else { return }
            try await stopProvider.fetchStopsArea(mapLocation: location)
        } catch {
            self.error = error as? StopError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Stops()
        .environmentObject(StopProvider.preview)
        .environmentObject(LocationProvider())
}

