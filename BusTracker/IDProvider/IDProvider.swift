//
//  IDProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 08-12-2024.
//

import Foundation

class IDProvider {
    fileprivate let clientPtr: UnsafeMutableRawPointer
    fileprivate let idProviderPtr: UnsafeMutableRawPointer
    fileprivate let authenticationPtr: UnsafeMutableRawPointer
    var authenticated: Bool
    
    init(
        userID: String,
        password: String,
        emailAddress: String,
        clientRegion: String,
        clientID: String
    ) throws {
        let clientSize = openIDClientSize();
        clientPtr = UnsafeMutableRawPointer.allocate(
            byteCount: clientSize,
            alignment: MemoryLayout<UnsafeMutableRawPointer>.alignment
        );
        let success = initialiseOpenIDClient(clientPtr);
        if (!success) {
            throw IDError.openIDError(error: "Initialisation of OpenID Client failed");
        }
        
        let idSize = idProviderSize();
        idProviderPtr = UnsafeMutableRawPointer.allocate(
            byteCount: idSize,
            alignment: MemoryLayout<UnsafeMutableRawPointer>.alignment
        );
        let success2 = initialiseOpenIDProvider(idProviderPtr, userID, password, emailAddress, clientRegion, clientID);
        if (!success2) {
            throw IDError.openIDError(error: "Initialisation of OpenID IDProvider failed");
        }
        
        let authenticationSize = authenticationSize();
        authenticationPtr = UnsafeMutableRawPointer.allocate(
            byteCount: authenticationSize,
            alignment: MemoryLayout<UnsafeMutableRawPointer>.alignment
        );
        authenticated = false;
    }
    
    func signUp() throws {
        let success = signUpUser(idProviderPtr);
        
        if (!success) {
            throw IDError.openIDError(error: "OpenID user sign-up failed");
        }
    }
    
    func verify(authenticationCode: String) throws {
        var success = true;
        let string = authenticationCode.cString(using: .utf8)!;
        string.withUnsafeBytes { (authenticationCodePtr) in
            success = verifyUser(idProviderPtr, authenticationCodePtr.baseAddress!);
        }
        
        if (!success) {
            throw IDError.openIDError(error: "OpenID user verification failed");
        }
    }
    
    func resendVerification() throws {
        let success = resendCode(idProviderPtr);
        
        if (!success) {
            throw IDError.openIDError(error: "OpenID resend verification request failed");
        }
    }
    
    func requestAuthentication() throws {
        let success = authenticate(authenticationPtr, idProviderPtr);
        //bool authenticate(void * authentication, void * idProviderPtr);
        if (!success) {
            throw IDError.openIDError(error: "OpenID authentication request failed");
        }
        authenticated = true;
    }
    
    func getAuthentication() throws -> Authentication {
        if (!authenticated) {
            try requestAuthentication();
        }
        
        let accessToken = String(cString: getAccessToken(authenticationPtr));
        let expiryTime = Int(getExpiryTime(authenticationPtr));
        let idToken = String(cString: getIDToken(authenticationPtr));
        let refreshToken = String(cString: getRefreshToken(authenticationPtr));
        let tokenType = String(cString: getTokenType(authenticationPtr));
        
        return Authentication(
            accessToken: accessToken,
            expiryTime: expiryTime,
            idToken: idToken,
            refreshToken: refreshToken,
            tokenType: tokenType);
    }
    
    private func validateAuthentication(authentication: Authentication) throws {
        if (!authenticated) {
            throw IDError.authenticationError(error: "IDProvider not authenticated");
        }
        if (authentication.isExpired()) {
            throw IDError.expiredAuthenticationError
        }
        let authentication2 = try getAuthentication();
        
        if (authentication2 != authentication) {
            throw IDError.authenticationError(error: "Authencation mismatch");
        }
    }

    
    func deleteAccount(authentication: Authentication) throws {
        try validateAuthentication(authentication: authentication);
        
        let success = deleteUser(idProviderPtr, authenticationPtr);
        
        if (!success) {
            throw IDError.openIDError(error: "OpenID account deletion failed");
        }
    }
    
    deinit {
        uninitialiseOpenIDClient(clientPtr);
        uninitialiseOpenIDProvider(idProviderPtr);
        clientPtr.deallocate();
        idProviderPtr.deallocate();
        authenticationPtr.deallocate();
    }
}
