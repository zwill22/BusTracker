//
//  VehicleRow.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct VehicleRow: View {
    var vehicle: Vehicle
    
    var body: some View {
        HStack {
            RouteNumber(vehicle: vehicle, height: 75)
            VStack(alignment: .leading) {
                HStack{
                    Text("\(vehicle.details.originDepartureTime.formatted(date: .omitted, time: .shortened))").font(.title)
                        .lineLimit(1, reservesSpace: true)
                    Image(systemName: "arrow.right").font(.title)
                    if let destination = vehicle.destination {
                        if let shortName = destination.shortName {
                            Text(shortName).font(.title)
                                .lineLimit(1, reservesSpace: true)
                        } else {
                            Text(destination.name).font(.title)
                                .lineLimit(1, reservesSpace: true)
                        }
                    } else {
                        Text(vehicle.details.destination).font(.title)
                            .lineLimit(1, reservesSpace: true)
                    }
                }
                
                if let transportOperator = vehicle.vehicleOperator {
                    Text("Operator: \(transportOperator.name)").foregroundStyle(.secondary)
                        .lineLimit(1, reservesSpace: true)
                } else {
                    Text("Operator: \(vehicle.details.operatorCode)").foregroundStyle(.secondary)
                        .lineLimit(1, reservesSpace: true)
                }
                
                if let origin = vehicle.origin {
                    if let shortName = origin.shortName {
                        Text("Origin: \(shortName)").foregroundColor(.secondary)
                            .lineLimit(1, reservesSpace: true)
                    } else {
                        Text("Origin: \(origin.name)").foregroundColor(.secondary)
                            .lineLimit(1, reservesSpace: true)
                    }
                } else {
                    Text("Origin: \(vehicle.details.origin)").foregroundColor(.secondary)
                        .lineLimit(1, reservesSpace: true)
                }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VehicleRow(vehicle: Vehicle.preview)
}
