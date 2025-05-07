//
//  OperatorMode.swift
//  BusTracker
//
//  Created by Zack Williams on 07-05-2025.
//

enum OperatorMode: String, Decodable {
    case bus = "Bus"
    case train = "Rail"
    case taxi = "Taxi"
    case ferry = "Ferry"
    case coach = "Coach"
    case tram = "Tram"
    case drt = "DRT"
    case underground = "Underground"
    case airline = "Airline"
    case metro = "Metro"
    case cableCar = "Cable Car"
    case permit = "Permit"
    case partlyDrt = "Partly DRT"
    case section19 = "Section 19"
    case none = "None"
    case other = "Other"
    
    
    func image() -> String {
        switch self {
        case .bus:
            return "bus.fill"
        case .train:
            return "train.side.rear.car"
        case .taxi:
            return "car.fill"
        case .ferry:
            return "ferry.fill"
        case .coach:
            return "bus.doubledecker.fill"
        case .tram:
            return "tram.fill"
        case .drt:
            return "figure.wave"
        case .underground:
            return "train.side.front.car"
        case .airline:
            return "airplane"
        case .metro:
            return "lightrail.fill"
        case .cableCar:
            return "cablecar.fill"
        case .permit:
            return "car.rear"
        default:
            return "figure.walk.circle.fill"
        }
    }
}
