//
//  Stops.swift
//  BusTracker
//
//  Created by Zack Williams on 15-05-2025.
//

import SwiftUI

struct Stops: View {
    @AppStorage("stopsLastUpdated")
    var stopsLastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @Bindable var locationProvider: LocationProvider
    @Bindable var stopProvider: StopProvider
    
    @State var isLoading: Bool = false
    @State private var error: StopError?
    @State private var hasError = false
    
    var body: some View {
        NavigationStack {
            StopMap(position: $locationProvider.position, stops: $stopProvider.stops)
            List {
                ForEach(stopProvider.filteredStops) { stop in
                    NavigationLink(
                        destination: StopDetailView(stop: stop)
                    ) {
                        StopRow(stop: stop)
                    }
                }
            }
            .navigationTitle("Transport Stops")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.inset)
            .alert(isPresented: $hasError, error: error) {}
            .searchable(text: $stopProvider.searchText)
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
        stopsLastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Stops(locationProvider: LocationProvider(), stopProvider: StopProvider.preview)
}

