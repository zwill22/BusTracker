//
//  StopTypeImage.swift
//  BusTracker
//
//  Created by Zack Williams on 16-06-2025.
//

import SwiftUI

extension BusStopType {
    
    private func imageView(image: String, height: CGFloat) -> some View {
        return ZStack {
            Circle().fill(.busBlue).frame(width: height, height: height)
            Image(systemName: "circle").resizable().frame(width: height, height: height)
                .foregroundStyle(.offWhite)
            Image(systemName: image).resizable().scaledToFit().frame(width: height * 0.7, height: height * 0.7)
                .foregroundStyle(.offWhite)
        }
    }
    
    @ViewBuilder
    func view(height: CGFloat = 16) -> some View {
        switch self {
        case .marked:
            imageView(image: "signpost.and.arrowtriangle.up.fill", height: height)
        case .hailAndRide:
            imageView(image: "figure.wave", height: height)
        case .custom:
            imageView(image: "mappin", height: height)
        }
    }
    
}

#Preview {
    ForEach(BusStopType.allCases, id: \.self) { key in
        key.view(height: 60)
    }
}
