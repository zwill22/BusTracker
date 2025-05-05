//
//  MainView.swift
//  BusTracker
//
//  Created by Zack Williams on 07-04-2025.
//

import SwiftUI
import MapKit

struct Buses: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: BusProvider
    @EnvironmentObject var locationManager: LocationManager
    
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: BusError?
    @State private var hasError = false
    @State var position: MapCameraPosition = .automatic
    @State var defaultDelta: Double = 0.1
    
    var body: some View {
        NavigationStack {
            MapView(position: $position, buses: $provider.buses)
            List(selection: $selection) {
                ForEach(provider.buses) { bus in
                    NavigationLink(destination: BusDetail(bus: bus)) {
                        BusRow(bus: bus)
                    }
                }
            }
            .listStyle(.inset)
            .toolbar(content: toolbarContent)
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            guard let location = locationManager.location else { return }
            position = .region(MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: defaultDelta, longitudeDelta: defaultDelta)
            ))
        }
        .task {
            await fetchBuses()
        }
    }
    
    func fetchBuses() async {
        isLoading = true
        do {
            let userLocation = locationManager.location ?? CLLocation(
                    latitude: position.region!.center.latitude,
                    longitude: position.region!.center.longitude
                )
            
            try await provider.fetchBuses(
                position: position,
                userLocation: userLocation.coordinate)
        } catch {
            self.error = error as? BusError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Buses()
        .environmentObject(
            BusProvider.preview
        )
        .environmentObject(LocationManager())
}

