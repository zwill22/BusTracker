//
//  StopType.swift
//  BusTracker
//
//  Created by Zack Williams on 20-05-2025.
//

import Foundation

enum StopType: String, Decodable, CaseIterable {
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
    
}
