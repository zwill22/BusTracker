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
                
                Group {
                    HStack {
                        Text("Departed:")
                        if let origin = vehicle.origin {
                            if let shortName = origin.shortName {
                                Text(shortName)
                            } else {
                                Text(origin.name)
                            }
                        } else {
                            Text(vehicle.details.origin)
                        }
                        
                        Text("(\(vehicle.details.originDepartureTime.formatted(date: .omitted, time: .shortened)))")
                    }
                }.foregroundStyle(.secondary).lineLimit(1, reservesSpace: true)
                
                if let transportOperator = vehicle.vehicleOperator {
                    Text("Operator: \(transportOperator.name)").foregroundStyle(.secondary)
                        .lineLimit(1, reservesSpace: true)
                } else {
                    Text("Operator: \(vehicle.details.operatorCode)").foregroundStyle(.secondary)
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
