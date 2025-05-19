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
        
        var strings: [String] = [stop.stopType, stop.name, stop.locality]
        
        
        return strings
    }
    
    var body: some View {
        DetailRow(strings: strings, image: Image(systemName: "mappin.circle.fill"))
    }
}


#Preview {
    StopRow(stop: Stop(
        id: "0100BRX32922",
        name: "Queen Square",
        shortName: nil,
        street: "Prince Street",
        localityCode: "N0076879",
        locality: "Bristol City Centre",
        parentLocality: "Bristol",
        location: VehicleLocation(latitude: -2.59652, longitude: 51.45116),
        stopType: "MKD",
        busStopType: "OTH",
        bearing: "N")
    )
}
