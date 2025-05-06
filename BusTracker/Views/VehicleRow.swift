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
                    Text(vehicle.details.destination).font(.title)
                        .lineLimit(1, reservesSpace: true)
                }
                Text("Operator: \(vehicle.details.operatorCode)").foregroundStyle(.secondary)
                        .lineLimit(1, reservesSpace: true)
                Text("Origin: \(vehicle.details.origin)").foregroundColor(.secondary)
                        .lineLimit(1, reservesSpace: true)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VehicleRow(vehicle: Vehicle.preview)
}
