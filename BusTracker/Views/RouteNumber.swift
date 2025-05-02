//
//  RouteNumber.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct RouteNumber: View {
    var bus: Bus
    var height: CGFloat = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(bus.primaryColour)
            .frame(width: 80, height: height)
            .overlay {
                Text(bus.details.lineNumber)
                    .font(.title)
                    .bold()
                    .foregroundStyle(bus.secondaryColour)
            }
    }
}

#Preview {
    RouteNumber(bus: Bus.preview)
}
