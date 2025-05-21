//
//  BusStopType.swift
//  BusTracker
//
//  Created by Zack Williams on 21-05-2025.
//

import Foundation
import SwiftUI

enum BusStopType: String, Decodable {
    case marked = "MKD"
    case custom = "CUS"
    case hailAndRide = "HAR"
    
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

