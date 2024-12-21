//
//  Authentication.swift
//  BusTracker
//
//  Created by Zack Williams on 17-12-2024.
//

import Foundation

//char* getAccessToken(void * authenticationPtr);
//int getExpiryTime(void * authenticationPtr);
//char* getIDToken(void * authenticationPtr);
//char* getRefreshToken(void * authenticationPtr);
//char* getTokenType(void * authenticationPtr);

struct Authentication: Codable, Equatable {
    let accessToken: String
    let expiryTime: Date
    let idToken: String
    let refreshToken: String
    let tokenType: String
    
    private let initialised: Bool
    
    init(accessToken: String, expiryTime: Int, idToken: String,
         refreshToken: String, tokenType: String) {
        self.accessToken = accessToken
        self.expiryTime = .init(timeIntervalSinceNow: TimeInterval(expiryTime))
        self.idToken = idToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.initialised = true
    }
    
    init() {
        self.accessToken = ""
        self.expiryTime = .distantPast
        self.idToken = ""
        self.refreshToken = ""
        self.tokenType = ""
        self.initialised = false
    }
    
    func isInitialised() -> Bool {
        return initialised
    }
    
    func isExpired() -> Bool {
        expiryTime < Date()
    }
}

extension Authentication {
    static let sampleData: Authentication = Authentication(
        accessToken: "aaawsdrfcfgyhgbvhuijnjkokmk12",
        expiryTime: 3600,
        idToken: "poowduiweurgwuekhfwhkfhfkuqkwfh",
        refreshToken: "dkqfdjiqefhwikhoq2fofdsduh",
        tokenType: "Bearer"
    )
        
}


