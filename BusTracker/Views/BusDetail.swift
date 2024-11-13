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
        VStack(alignment: .leading) {
            BusDetailMap(location: location, tintColour: bus.colour)
                .ignoresSafeArea(.container)
            HStack {
                RouteNumber(bus: bus, height: 80)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    HStack {
                        Text(bus.details.origin).font(.title3)
                        Image(systemName: "arrow.right").font(.title3)
                        Text(bus.details.destination).font(.title3)
                    }
                    Text("Operator: \(bus.details.operatorCode)")
                        .font(.headline)
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
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
        }.onTapGesture {
            changePrecision()
        }
    }
}

#Preview {
    BusDetail(bus: Bus.preview)
}
