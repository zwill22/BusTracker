//
//  StopBlock.swift
//  BusTracker
//
//  Created by Zack Williams on 21-05-2025.
//

import SwiftUI

struct StopBlock: View {
    var stop: Stop
    var height: CGFloat = 60
    var width: CGFloat = 80
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(stop.stopType.colour)
            .frame(width: width, height: height)
            .overlay {
                if let busStopType = stop.busStopType {
                    busStopType.view(height: min(height, width) * 0.9)
                } else {
                    stop.stopType.view(height: min(height, width) * 0.9)
                }
            }
        
    }
}

#Preview {
    StopBlock(stop: Stop.preview)
}
