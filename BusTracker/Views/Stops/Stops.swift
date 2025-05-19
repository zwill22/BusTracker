//
//  Stops.swift
//  BusTracker
//
//  Created by Zack Williams on 15-05-2025.
//

import SwiftUI

struct Stops: View {
    @EnvironmentObject var stopProvider: StopProvider
    @EnvironmentObject var locationProvider: LocationProvider
    
    @State var isLoading: Bool = false
    @State private var hasError: Bool = false
    @State private var error: VehicleError?
    @State private var vehicles: [Vehicle] = []
    
    var body: some View {
        NavigationStack {
            MapView(vehicles: $vehicles, stops: $stopProvider.stops)
                    .environmentObject(locationProvider)
            List {
                ForEach(stopProvider.stops) { stop in
                    StopRow(stop: stop)
                }
            }
            .listStyle(.inset)
            .alert(isPresented: $hasError, error: error) {}
        }.task {
            await fetchStops()
        }
    }
    
    func fetchStops() async {
        isLoading = true
        do {
            guard let location = locationProvider.mapLocation() else {
                return
            }
            try await stopProvider.fetchStopsArea(mapLocation: location, stops: stopProvider.stops)
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

#Preview {
    Stops().environmentObject(StopProvider()).environmentObject(LocationProvider())
}
