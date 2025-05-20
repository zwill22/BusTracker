//
//  StopRow.swift
//  BusTracker
//
//  Created by Zack Williams on 15-05-2025.
//

import SwiftUI

struct StopRow: View {
    var stop: Stop
    
    var strings: [String] {
        
        let strings: [String] = [stop.stopType, stop.name, stop.locality]
        
        
        return strings
    }
    
    var body: some View {
        DetailRow(strings: strings, image: Image(systemName: "mappin.circle.fill"))
    }
}


#Preview {
    StopRow(stop: Stop.preview)
}
