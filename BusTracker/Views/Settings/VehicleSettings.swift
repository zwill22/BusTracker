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
    @Binding var maxTime: Int
    @Binding var timeout: Int
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Maximum vehicles to load")
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
                            value: IntDoubleBinding($maxTime).doubleValue,
                            in: 600...10800,
                            step: 600
                        ) {
                            Text("Maximum time in minutes since last update")
                        }
                        Spacer()
                        Text("\(String(format: "%d", maxTime / 60)) minutes")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Timeout")
                    HStack{
                        Slider(
                            value: IntDoubleBinding($timeout).doubleValue,
                            in: 10...1000,
                            step: 10
                        ) {
                            Text("Timeout for fetching data")
                        }
                        Spacer()
                        Text("\(String(format: "%d", timeout)) seconds")
                    }
                }
                
                
              
    }
}

#Preview {
    @Previewable @State var maxVehicles = 500
    @Previewable @State var maxTime = 3600
    @Previewable @State var timeout = 60
    
    VehicleSettings(maxVehicles: $maxVehicles, maxTime: $maxTime, timeout: $timeout)
}
