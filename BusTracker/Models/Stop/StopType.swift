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
    
    
    var colour: Colour {
        switch self {
        case .railStationEntrance, .railAccess, .railPlatform:
            return .white
        case .tramMetroAccess, .undergroundPlatform, .undergroundEntrance:
            return .dark
        case .busStopStreet:
            return .neutral
        case .busStationBay, .busStationEntrance, .busAccess, .busStationVariableBay:
            return .busBlue
        case .sharedTaxiRank, .taxiRank:
            return .taxiYellow
        case .ferryTerminalEntrance, .ferryAccess, .ferryBerth:
            return .purple
        case .airportEntrance, .airAccessArea:
            return .black
        }
    }
    
    var secondaryColour: Colour {
        switch self {
        case .railStationEntrance, .railAccess, .railPlatform:
            return .railRed
        case .sharedTaxiRank, .taxiRank:
            return .dirtyBrown
        default:
            return .offWhite
        }
    }
    
    private func imageView(image: Image, height: CGFloat, scaleFactor: CGFloat = 0.6) -> some View {
        
        ZStack {
            Circle().fill(colour).frame(width: height, height: height)
            Image(systemName: "circle").resizable().frame(width: height, height: height)
                .foregroundStyle(secondaryColour)
            image.resizable().scaledToFit().frame(width: height * scaleFactor, height: height * scaleFactor).foregroundStyle(secondaryColour)
        }
    }
    
    private func imageView(image: String, height: CGFloat) -> some View {
        return imageView(image: Image(systemName: image), height: height)
    }
    
    private func dot(height: CGFloat, dotColour: Colour) -> some View {
        return Circle().fill(dotColour).frame(width: height, height: height)
    }
    
    @ViewBuilder
    func view(height: CGFloat = 24) -> some View {
        switch self {
        case .railStationEntrance:
            dot(height: height / 6, dotColour: secondaryColour)
        case .tramMetroAccess:
            imageView(image: "lightrail.fill", height: height)
        case .busStationBay, .busStationVariableBay:
            imageView(image: "bus.fill", height: height)
        case .sharedTaxiRank, .taxiRank:
            imageView(image: "car.fill", height: height)
        case .railAccess:
            imageView(image: Image(.nationalRail), height: height, scaleFactor: 0.7)
        case .airAccessArea:
            imageView(image: "airplane.departure", height: height)
        case .ferryAccess:
            imageView(image: "ferry.fill", height: height)
        default:
            dot(height: height / 6, dotColour: colour)
        
        }
    }
}
