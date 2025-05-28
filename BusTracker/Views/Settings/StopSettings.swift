//
//  StopSettings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct StopSettings: View {
    @Binding var maxStops: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Max Stops")
            HStack{
                Slider(
                    value: IntDoubleBinding($maxStops).doubleValue,
                    in: 100...1000,
                    step: 100
                ) {
                    Text("Maximum number of bus stops to load")
                }
                Spacer()
                Text("\(String(format: "%d", maxStops)) Stops")
            }
        }
    }
}

#Preview {
    @Previewable @State var maxStops = 500
    
    StopSettings(maxStops: $maxStops)
}
