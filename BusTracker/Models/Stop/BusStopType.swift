//
//  BusStopType.swift
//  BusTracker
//
//  Created by Zack Williams on 21-05-2025.
//

import Foundation

enum BusStopType: String, Decodable, CaseIterable {
    case marked = "MKD"
    case custom = "CUS"
    case hailAndRide = "HAR"
}
