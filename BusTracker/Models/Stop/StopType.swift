//
//  StopType.swift
//  BusTracker
//
//  Created by Zack Williams on 20-05-2025.
//

import Foundation
import SwiftUI

enum StopType: String, Decodable {
    case railStationEntrance = "RSE"
    case tramMetroAccess = "MET"
    case busStationBay = "BCS"
    case sharedTaxiRank = "STR"
    case railAccess = "RLY"
    case undergroundPlatform = "PLT"
    case ferryTerminalEntrance = "FTD"
    case ferryAccess = "FER"
    case busStationEntrance = "BCE"
    case airportEntrance = "AIR"
    case busStopStreet = "BCT"
    case busAccess = "BST"
    case ferryBerth = "FBT"
    case undergroundEntrance = "TMU"
    case airAccessArea = "GAT"
    case busStationVariableBay = "BCQ"
    case taxiRank = "TXR"
    case railPlatform = "RPL"
    
    
    private func imageView(image: Image, height: CGFloat,
                           colour: Color,
                           accentColour: Color,
                           scaleFactor: CGFloat
    ) -> some View {
        
        ZStack {
            Circle().fill(colour).frame(width: height, height: height)
            Image(systemName: "circle").resizable().frame(width: height, height: height)
                .foregroundStyle(accentColour)
            image.resizable().scaledToFit().frame(width: height * scaleFactor, height: height * scaleFactor)
        }
    }
    
    private func imageView(image: String, height: CGFloat,
                           colour: Color = .primary,
                           accentColour: Color = .white,
                           scaleFactor: CGFloat = 0.6
    ) -> some View {
        return imageView(
            image: Image(systemName: image),
            height: height,
            colour: colour,
            accentColour: accentColour,
            scaleFactor: scaleFactor
        )
    }
    
    private func dot(height: CGFloat, colour: Color) -> some View {
        return Circle().fill(colour).frame(width: height, height: height)
    }
    
    @ViewBuilder
    func view(height: CGFloat = 24) -> some View {
        switch self {
        case .railStationEntrance:
            dot(height: 4, colour: .railRed)
        case .tramMetroAccess:
            imageView(image: "lightrail.fill", height: height, colour: .dark, accentColour: .offWhite)
        case .busStationBay, .busStationVariableBay:
            imageView(image: "bus.fill", height: height, colour: .busBlue, accentColour: .offWhite)
        case .sharedTaxiRank, .taxiRank:
            imageView(image: "car.fill", height: height, colour: .taxiYellow, accentColour: .dirtyBrown)
        case .railAccess:
            imageView(image: Image(.nationalRail), height: height, colour: .white, accentColour: .railRed, scaleFactor: 0.7)
        case .busStationEntrance, .busAccess:
            dot(height: 4, colour: .busBlue)
        case .busStopStreet:
            dot(height: 4, colour: .primary)
        case .airAccessArea:
            imageView(image: "airplane.departure", height: height, colour: .black, accentColour: .offWhite)
        case .airportEntrance:
            dot(height: 4, colour: .black)
        case .ferryAccess:
            imageView(image: "ferry.fill", height: height, colour: .purple, accentColour: .offWhite)
        case .ferryTerminalEntrance, .ferryBerth:
            dot(height: 4, colour: .purple)
        case .undergroundEntrance:
            dot(height: 4, colour: .dark)
        default:
            dot(height: 1, colour: .primary)
        
        }
    }
}
