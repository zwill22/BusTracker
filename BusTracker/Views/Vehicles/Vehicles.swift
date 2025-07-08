//
//  Vehicles.swift
//  BusTracker
//
//  Created by Zack Williams on 07-04-2025.
//

import SwiftUI

struct Vehicles: View {
    @AppStorage("vehiclesLastUpdated")
    var vehiclesLastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @Bindable var locationProvider: LocationProvider
    @Bindable var operatorProvider: OperatorProvider
    @Bindable var stopProvider: StopProvider
    @Bindable var vehicleProvider: VehicleProvider
    
    @State var isLoading: Bool = false
    @State private var error: VehicleError?
    @State private var hasError = false
    
    var body: some View {
        NavigationStack {
            MapView(position: $locationProvider.position, vehicles: $vehicleProvider.vehicles)
            List {
                ForEach(Array(vehicleProvider.vehicles.enumerated()), id: \.offset) { index, vehicle in
                    NavigationLink(
                        destination: VehicleDetail(offset: index, vehicleProvider: vehicleProvider)
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
    
    func fetchStops() async throws {
        var codes: [String] = []
        for vehicle in vehicleProvider.vehicles {
            if vehicle.details.originRef != "" {
                codes.append(vehicle.details.originRef)
            }
            if vehicle.details.destinationRef != "" {
                codes.append(vehicle.details.destinationRef)
            }
        }
        
        try await stopProvider.fetchStopCodes(codes: codes)
    }
    
    func fetchVehicles() async {
        isLoading = true
        do {
            guard let location = locationProvider.mapLocation() else { return }
            try await vehicleProvider.fetchVehicles(mapLocation: location)
            try await fetchStops()
            
            vehicleProvider.updateVehicles(
                operators: operatorProvider.vehicleOperators,
                stops: stopProvider.stops
            )
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        vehiclesLastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Vehicles(
        locationProvider: LocationProvider(),
        operatorProvider: OperatorProvider.preview,
        stopProvider: StopProvider.preview,
        vehicleProvider: VehicleProvider.preview
    )
}

