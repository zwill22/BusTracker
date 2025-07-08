//
//  VehicleDetailView.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct VehicleDetail: View {
    @Bindable var vehicleProvider: VehicleProvider
    @State var vehicle: Vehicle
    let offset: Int
    
    @State var isLoading: Bool = false
    @State private var error: VehicleError?
    @State private var hasError = false

    var body: some View {
        let location = vehicle.details.location
        NavigationStack {
            VStack(alignment: .leading) {
                VehicleDetailMap(vehicle: $vehicle)
                    .ignoresSafeArea(.container)
                HStack {
                    RouteNumber(vehicle: vehicle, height: 80)
                        .padding(.trailing, 10)
                    VStack(alignment: .leading) {
                        if let destination = vehicle.destination {
                            Text(destination.name).lineLimit(1).font(.title)
                        } else {
                            Text(vehicle.details.destination).lineLimit(1, reservesSpace: true).font(.title)
                        }
                        
                        if let origin = vehicle.origin {
                            Text("Origin: \(origin.name)").lineLimit(1, reservesSpace: true).font(.headline)
                        }
                        
                        if let transportOperator = vehicle.vehicleOperator {
                            NavigationLink(destination: OperatorDetailView(
                                transportOperator: transportOperator
                            )) {
                                Text("Operator: \(transportOperator.name)")
                                    .font(.headline).lineLimit(1, reservesSpace: true)
                            }
                        } else {
                            Text("Operator: \(vehicle.details.operatorCode)")
                                .font(.headline).lineLimit(1, reservesSpace: true)
                        }
                        Text("\(vehicle.time.formatted())")
                            .foregroundStyle(Color.secondary)
                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                        Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
            }
        }
        .toolbar(content: detailToolbar)
    }
    
    func updateVehicle() async {
        isLoading = true
        do {
            try await vehicleProvider.updateVehicle(atOffset: offset)
            vehicle = vehicleProvider.vehicles[offset]
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
    
    @ToolbarContentBuilder
    func detailToolbar() -> some ToolbarContent {
        ToolbarItemGroup {
            RefreshButton {
                Task {
                    await updateVehicle()
                }
            }
        }
    }
    
    init(offset: Int, vehicleProvider: VehicleProvider) {
        self.vehicleProvider = vehicleProvider
        self.vehicle = vehicleProvider.vehicles[offset]
        self.offset = offset
    }
}

