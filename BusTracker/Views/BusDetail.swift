//
//  BusDetail.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct BusDetail: View {
    var bus: Bus
    @EnvironmentObject private var busProvider: BusProvider
    @State private var high_precision: Bool = false
    
    func changePrecision() {
        self.high_precision.toggle()
    }
    
    var body: some View {
        let location = self.bus.details.location
        VStack {
            BusDetailMap(location: location, tintColour: bus.colour)
                .ignoresSafeArea(.container)
            HStack {
                RouteNumber(bus: bus)
                VStack {
                    Text(bus.details.operatorCode)
                        .font(.title3)
                        .bold()
                    Text("\(bus.time.formatted())")
                        .foregroundStyle(Color.secondary)
                    if high_precision {
                        Text("Latitude: \(location.latitude.formatted())")
                        Text("Longitude: \(location.longitude.formatted())")
                    } else {
                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                        Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                    }
                }
            }
        }.onTapGesture {
            changePrecision()
        }
    }
}

#Preview {
    BusDetail(bus: Bus.preview)
}
