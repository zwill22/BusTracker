//
//  VehicleSettings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct IntDoubleBinding {
    let intValue : Binding<Int>
    
    let doubleValue : Binding<Double>
    
    init(_ intValue : Binding<Int>) {
        self.intValue = intValue
        
        self.doubleValue = Binding<Double>(get: {
            return Double(intValue.wrappedValue)
        }, set: {
            intValue.wrappedValue = Int($0)
        })
    }
}

struct VehicleSettings: View {
    @Binding var maxVehicles: Int
    @Binding var maxTime: TimeInterval
    @Binding var timeout: TimeInterval
    @Binding var refreshRate: TimeInterval
    @Binding var autoRefresh: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vehicle Limit")
            HStack{
                Slider(
                    value: IntDoubleBinding($maxVehicles).doubleValue,
                    in: 100...1000,
                    step: 100
                ) {
                    Text("Maximum number of vehicles to load")
                }
                Spacer()
                Text("\(String(format: "%d", maxVehicles)) Vehicles")
            }
        }
                
        VStack(alignment: .leading) {
            Text("Time window")
            HStack{
                Slider(
                    value: $maxTime,
                    in: 600...10800,
                    step: 600
                ) {
                    Text("Maximum time in minutes since last update")
                }
                Spacer()
                Text("\(String(format: "%.0f", maxTime / 60)) minutes")
            }
        }
                
        VStack(alignment: .leading) {
            Text("Timeout")
            HStack{
                Slider(
                    value: $timeout,
                    in: 10...1000,
                    step: 10
                ) {
                    Text("Timeout for fetching data")
                }
                Spacer()
                Text("\(String(format: "%.0f", timeout)) seconds")
            }
        }
        
        VStack(alignment: .leading) {
            Text("Auto refresh rate")
            HStack{
                Slider(
                    value: $refreshRate,
                    in: 10...1000,
                    step: 10
                ) {
                    Text("Refresh rate in seconds")
                }
                Spacer()
                Text("\(String(format: "%.0f", refreshRate)) seconds")
            }
        }
        .disabled(!autoRefresh)
        
        HStack {
            Text("Auto refresh")
            Spacer()
            Toggle("", isOn: $autoRefresh)
        }
    }
}

#Preview {
    @Previewable @State var maxVehicles: Int = 500
    @Previewable @State var maxTime: TimeInterval = 3600
    @Previewable @State var refreshRate: TimeInterval = 30
    @Previewable @State var timeout: TimeInterval = 60
    @Previewable @State var autoRefresh: Bool = true
    
    VehicleSettings(
        maxVehicles: $maxVehicles,
        maxTime: $maxTime,
        timeout: $timeout,
        refreshRate: $refreshRate,
        autoRefresh: $autoRefresh
    )
}
