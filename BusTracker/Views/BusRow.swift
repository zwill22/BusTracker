//
//  BusRow.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct BusRow: View {
    var bus: Bus
    
    var body: some View {
        HStack {
            RouteNumber(bus: bus, height: 75)
            VStack(alignment: .leading) {
                HStack{
                    Text("\(bus.details.originDepartureTime.formatted(date: .omitted, time: .shortened))").font(.title)
                        .lineLimit(1, reservesSpace: true)
                    Image(systemName: "arrow.right").font(.title)
                    Text(bus.details.destination).font(.title)
                        .lineLimit(1, reservesSpace: true)
                }
                Text("Operator: \(bus.details.operatorCode)").foregroundStyle(.secondary)
                        .lineLimit(1, reservesSpace: true)
                Text("Origin: \(bus.details.origin)").foregroundColor(.secondary)
                        .lineLimit(1, reservesSpace: true)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BusRow(bus: Bus.preview)
}
