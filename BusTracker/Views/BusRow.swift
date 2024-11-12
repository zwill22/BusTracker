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
            RouteNumber(bus: bus)
            VStack(alignment: .leading) {
                Text(bus.details.operatorCode)
                    .font(.title)
                Text("\(bus.time.formatted(.relative(presentation: .named)))")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let previewDetails = BusDetails(
        lineNumber: "X11",
        operatorCode: "ARV",
        location: BusLocation(latitude: 60, longitude: 0)
    )
    
    let previewBus = Bus(
        time: Date(timeIntervalSinceNow: 0),
        details: previewDetails,
        id: "1234567890"
    )
    BusRow(bus: previewBus)
}
