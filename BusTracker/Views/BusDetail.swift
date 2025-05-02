//
//  BusDetail.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import WrappingHStack

struct BusDetail: View {
    var bus: Bus
    
    var body: some View {
        let location = self.bus.details.location
        VStack(alignment: .leading) {
            BusDetailMap(location: location, tintColour: bus.primaryColour)
                .ignoresSafeArea(.container)
            HStack {
                RouteNumber(bus: bus, height: 80)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    WrappingHStack(alignment: .leading) {
                        Group {
                            Text(bus.details.origin)
                            Image(systemName: "arrow.right")
                            Text(bus.details.destination)
                        }.lineLimit(1).font(.title3)
                    }
                    Text("Operator: \(bus.details.operatorCode)")
                        .font(.headline)
                    Text("\(bus.time.formatted())")
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
    BusDetail(bus: Bus.preview)
}
