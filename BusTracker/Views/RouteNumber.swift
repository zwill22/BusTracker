//
//  RouteNumber.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct RouteNumber: View {
    var vehicle: Vehicle
    var height: CGFloat = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(vehicle.primaryColour)
            .frame(width: 80, height: height)
            .overlay {
                Text(vehicle.details.lineNumber)
                    .font(.title)
                    .bold()
                    .foregroundStyle(vehicle.secondaryColour)
            }
    }
}

#Preview {
    RouteNumber(vehicle: Vehicle.preview)
}
