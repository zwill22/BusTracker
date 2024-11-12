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
            VStack(alignment: .leading) {
                Text(bus.vehicleUniqueId)
                    .font(.title)
                Text("\(bus.time.formatted(.relative(presentation: .named)))")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let previewBus = Bus(
        time: Date(timeIntervalSinceNow: 0),
        vehicleUniqueId: "1234567890"
    )
    BusRow(bus: previewBus)
}
