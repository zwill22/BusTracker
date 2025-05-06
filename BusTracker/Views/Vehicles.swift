//
//  Vehicles.swift
//  BusTracker
//
//  Created by Zack Williams on 07-04-2025.
//

import SwiftUI

struct Vehicles: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var vehicleProvider: VehicleProvider
    @EnvironmentObject var operatorProvider: OperatorProvider
    @EnvironmentObject var locationProvider: LocationProvider
    
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: VehicleError?
    @State private var hasError = false
    
    var body: some View {
        NavigationStack {
            MapView(vehicles: $vehicleProvider.vehicles)
                .environmentObject(locationProvider)
            List(selection: $selection) {
                ForEach(vehicleProvider.vehicles) { vehicle in
                    NavigationLink(
                        destination: VehicleDetail(vehicle: vehicle)
                    ) {
                        VehicleRow(vehicle: vehicle)
                    }
                }
            }
            .listStyle(.inset)
            .toolbar(content: toolbarContent)
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchOperators()
            await fetchVehicles()
        }
    }
    
    func fetchOperators() async {
        do {
            try await operatorProvider.fetchOperators()
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
    }
    
    func fetchVehicles() async {
        isLoading = true
        do {
            guard let location = locationProvider.mapLocation() else { return }
            try await vehicleProvider.fetchVehicles(
                mapLocation: location,
                operators: operatorProvider.vehicleOperators
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
        .environmentObject(OperatorProvider.preview)
        .environmentObject(LocationProvider())
}

