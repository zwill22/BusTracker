//
//  LocationSettings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct LocationSettings: View {
    @Binding var defaultDelta: Double
    @Binding var maxDelta: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Default Map Zoom")
            HStack{
                Slider(
                    value: $defaultDelta,
                    in: 0.01...1,
                    step: 0.01
                ) {
                    Text("Default Map Zoom")
                }
            }
        }
        
        VStack(alignment: .leading) {
            Text("Map region limit")
            HStack{
                Slider(
                    value: $maxDelta,
                    in: 0.1...2,
                    step: 0.1
                ) {
                    Text("Map region limit")
                }
            }
            
        }
    }
}

#Preview {
    @Previewable @State var defaultDelta = 0.1
    @Previewable @State var maxDelta = 0.1
    
    LocationSettings(defaultDelta: $defaultDelta, maxDelta: $maxDelta)
}
