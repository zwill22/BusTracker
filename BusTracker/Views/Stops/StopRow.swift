//
//  StopRow.swift
//  BusTracker
//
//  Created by Zack Williams on 15-05-2025.
//

import SwiftUI

struct StopRow: View {
    var stop: Stop
    
    var body: some View {
        HStack {
            StopBlock(stop: stop, height: 75)
            VStack(alignment: .leading) {
                Text(stop.name).lineLimit(1, reservesSpace: true).font(.title)
                Text(stop.locality).lineLimit(1, reservesSpace: true).font(.title2)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StopRow(stop: Stop.preview)
}
