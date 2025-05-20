//
//  StopPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 19-05-2025.
//

import Foundation


extension Stop {
    
    static var preview: Stop {
    
    let previewData: Data = """
[{
    "ATCOCode":"2500918",
    "NaptanCode":"landagwp",
    "PlateCode":null,"CommonName":"Underpass",
    "ShortCommonName":"Underpass",
    "Landmark":"LANCASTER University Underpass",
    "Street":"University Campus",
    "Indicator":"by",
    "Bearing":"W",
    "NptgLocalityCode":"N0078438",
    "LocalityName":"Lancaster University",
    "ParentLocalityName":null,
    "Town":"Lancaster",
    "Suburb":"University",
    "LocalityCentre":"true",
    "GridType":"UKOS",
    "Longitude":-2.785501379,
    "Latitude":54.010236577,
    "StopType":"BCT",
    "BusStopType":"MKD",
    "TimingStatus":"TIP",
    "AdministrativeAreaCode":87,
    "CreationDateTime":"2006-08-24T00:00:00",
    "ModificationDateTime":"2019-06-20T09:26:21",
    "RevisionNumber":4.0,
    "Modification":"revise"
}]
""".data(using: .utf8)!
        
        guard let stopPreview: [Stop] = try? JSONDecoder().decode([Stop].self, from: previewData) else {
            return Vehicle.preview.destination!
        }
        
        return stopPreview.first!
    }
}
