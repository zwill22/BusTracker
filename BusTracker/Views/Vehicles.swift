//
//  Vehicles.swift
//  BusTracker
//
//  Created by Zack Williams on 07-04-2025.
//

import SwiftUI
import MapKit

struct Vehicles: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: VehicleProvider
    @EnvironmentObject var locationManager: LocationManager
    
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: VehicleError?
    @State private var hasError = false
    @State var position: MapCameraPosition = .automatic
    @State var defaultDelta: Double = 0.1
    
    var body: some View {
        NavigationStack {
            MapView(position: $position, vehicles: $provider.vehicles)
            List(selection: $selection) {
                ForEach(provider.vehicles) { vehicle in
                    NavigationLink(destination: VehicleDetail(vehicle: vehicle)) {
                        VehicleRow(vehicle: vehicle)
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
            await fetchVehicles()
        }
    }
    
    func fetchVehicles() async {
        isLoading = true
        do {
            let userLocation = locationManager.location ?? CLLocation(
                    latitude: position.region!.center.latitude,
                    longitude: position.region!.center.longitude
                )
            
            try await provider.fetchVehicles(
                position: position,
                userLocation: userLocation.coordinate
            )
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Vehicles()
        .environmentObject(VehicleProvider.preview)
        .environmentObject(LocationManager())
}

