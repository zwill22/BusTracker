//
//  VehicleDetailView.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct VehicleDetail: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State var vehicleLastUpdated: TimeInterval = Date.now.timeIntervalSince1970
    @Bindable var vehicleProvider: VehicleProvider
    @State var vehicle: Vehicle
    
    let offset: Int
    
    @State private var isLoading: Bool = false
    @State private var error: VehicleError?
    @State private var hasError = false
    @State private var autoRefresh: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showDirectionsOptions: Bool = false

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
                            NavigationLink(destination: StopDetailView(stop: destination)) {
                                Text(destination.name).lineLimit(1).font(.title)
                            }.foregroundStyle(.primary)
                        } else {
                            Text(vehicle.details.destination).lineLimit(1, reservesSpace: true).font(.title)
                        }
                        
                        if let origin = vehicle.origin {
                            NavigationLink(destination: StopDetailView(stop: origin)) {
                                Text("Origin: \(origin.name)").lineLimit(1, reservesSpace: true).font(.headline)
                            }.foregroundStyle(.primary)
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
                        Menu {
                            DirectionsMenu(latitude: location.latitude, longitude: location.longitude)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                                Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                            }
                        }.foregroundStyle(.primary)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
            }
        }
        .onChange(of: vehicleProvider.autoRefresh) {
            autoRefresh = vehicleProvider.autoRefresh
        }
        .onAppear(perform: {
            autoRefresh = vehicleProvider.autoRefresh
            
            Task {
                await updateVehicle()
            }
        })
        .onDisappear(perform: {
            autoRefresh = false
        })
        .onReceive(timer, perform: { time in
            refresh(time.timeIntervalSince1970)
        })
        .toolbar(content: detailToolbar)
    }
    
    func refresh(_ time: TimeInterval) {
        if !autoRefresh { return }
        
        let timeInterval = time - vehicleLastUpdated
        if timeInterval > vehicleProvider.refreshInterval {
            Task {
                await updateVehicle()
            }
        }
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
        self.vehicleLastUpdated = Date.now.timeIntervalSince1970
        isLoading = false
    }
    
    @ToolbarContentBuilder
    func detailToolbar() -> some ToolbarContent {
        ToolbarItemGroup {
            if isLoading {
                ProgressView()
            } else {
                RefreshButton {
                    Task {
                        await updateVehicle()
                    }
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

