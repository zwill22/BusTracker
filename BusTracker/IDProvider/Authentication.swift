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

struct Authentication: Equatable {
    let accessToken: String
    let expiryTime: Date
    let idToken: String
    let refreshToken: String
    let tokenType: String
    
    init(accessToken: String, expiryTime: Int, idToken: String,
         refreshToken: String, tokenType: String) {
        self.accessToken = accessToken
        self.expiryTime = .init(timeIntervalSinceNow: TimeInterval(expiryTime))
        self.idToken = idToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
    }
    
    func isExpired() -> Bool {
        expiryTime < Date()
    }
}


