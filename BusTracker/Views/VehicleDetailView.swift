//
//  VehicleDetailView.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import WrappingHStack

struct VehicleDetail: View {
    var vehicle: Vehicle
    
    var body: some View {
        let location = self.vehicle.details.location
        VStack(alignment: .leading) {
            VehicleDetailMap(
                location: location, tintColour: vehicle.primaryColour)
                .ignoresSafeArea(.container)
            HStack {
                RouteNumber(vehicle: vehicle, height: 80)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    WrappingHStack(alignment: .leading) {
                        Group {
                            Text(vehicle.details.origin)
                            Image(systemName: "arrow.right")
                            Text(vehicle.details.destination)
                        }.lineLimit(1).font(.title3)
                    }
                    Text("Operator: \(vehicle.details.operatorCode)")
                        .font(.headline)
                    Text("\(vehicle.time.formatted())")
                        .foregroundStyle(Color.secondary)
                    Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                    Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
        }
    }
}

#Preview {
    VehicleDetail(vehicle: Vehicle.preview)
}
