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

    @AppStorage("locationLastUpdated")
    var locationLastUpdated = Date.distantFuture.timeIntervalSince1970

    @Bindable var locationProvider: LocationProvider
    @Bindable var operatorProvider: OperatorProvider
    @Bindable var stopProvider: StopProvider
    @Bindable var vehicleProvider: VehicleProvider

    @State var vehiclesLoading: Bool = false
    @State var centredOnUser: Bool = false
    @State var locationLoading: Bool = false
    @State var locationRequested: Bool = false

    @State private var error: BusTrackerError?
    @State private var hasError = false

    var body: some View {
        NavigationStack {
            VehicleMap(
                position: $locationProvider.position,
                vehicles: $vehicleProvider.vehicles,
                centredOnUser: $centredOnUser,
                recentreRequested: $locationRequested
            )
            List {
                ForEach(
                    Array(vehicleProvider.vehicles.enumerated()),
                    id: \.offset
                ) { index, vehicle in
                    NavigationLink(
                        destination: VehicleDetail(
                            offset: index,
                            vehicleProvider: vehicleProvider
                        )
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
            self.error =
                error as? BusTrackerError ?? .unexpectedError(error: error)
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
        vehiclesLoading = true
        do {
            guard let location = locationProvider.mapLocation() else { return }
            try await vehicleProvider.fetchVehicles(mapLocation: location)
            try await fetchStops()

            vehicleProvider.updateVehicles(
                operators: operatorProvider.vehicleOperators,
                stops: stopProvider.stops
            )
        } catch {
            self.error =
                error as? BusTrackerError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        vehiclesLastUpdated = Date().timeIntervalSince1970
        vehiclesLoading = false
    }

    func fetchUserLocation() {
        locationLoading = true

        let time = Date().timeIntervalSince1970

        if time - locationLastUpdated < 10 && centredOnUser {
            locationLoading = false
            return
        }

        locationProvider.update()

        locationLastUpdated = Date().timeIntervalSince1970
        locationLoading = false
        locationRequested = true
        centredOnUser = true
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
