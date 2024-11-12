//
//  RouteNumber.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct RouteNumber: View {
    var bus: Bus
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                Text(bus.details.lineNumber)
                    .font(.title)
                    .bold()
                    .foregroundStyle(bus.colour)
            }
    }
}

#Preview {
    let previewBus = Bus(
        time: Date(timeIntervalSinceNow: 0),
        details: .init(
            lineNumber: "X11",
            operatorCode: "ARV",
            location: .init(latitude: 60, longitude: 0)
        ),
        id: "1234567890"
    )
    RouteNumber(bus: previewBus)
}
