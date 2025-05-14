//
//  Server.swift
//  BusTracker
//
//  Created by Zack Williams on 07-05-2025.
//

import Foundation

struct Server {
    #if DEBUG
    private let url: URL = URL(filePath: "http://localhost:5134")!
    #else
    private let url: URL = URL(filePath: "https://zmwill.pythonanywhere.com")!
    #endif
    
    func getURLRoot(path: String) -> URL {
        return url.appending(path: path)
    }
}
