//
//  LoginScreen.swift
//  BusTracker
//
//  Created by Zack Williams on 21-12-2024.
//

import SwiftUI

struct ClientSettings {
    var region: String = "eu-west-2"
    var id: String = "59lgg6i7hcnv8kma81rn4i7qbr"
}

struct LoginSettings {
    var username: String
    var password: String
    var email: String
    
    static var emptySettings: LoginSettings {
        LoginSettings(username: "", password: "", email: "")
    }
}

struct LoginScreen: View {
    @State private var idProvider: IDProvider?

    @State private var clientSettings = ClientSettings()
    @State private var newLoginSettings = LoginSettings.emptySettings
    @State private var lastLogin: Date = .distantPast
    
    @State var isSigningUp: Bool = false
    @State var isLoggingIn: Bool = false
    @State private var isSignedUp: Bool?
    
    @State private var error: IDError?
    @State private var hasError: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("BusTracker Login Page").font(.title).padding([.top, .horizontal])
            Spacer()
            Form {
                Section(header: Text("Login details")) {
                    TextField("Username", text: $newLoginSettings.username);
                    TextField("Password", text: $newLoginSettings.password)
                    TextField("Email", text: $newLoginSettings.email)
                }
            }
            Spacer()
            HStack {
                Button("Sign-Up") {
                    signUp()
                }
                Spacer()
                Button("Login") {
                    login()
                }
            }.padding([.bottom, .horizontal])
        }.alert(isPresented: $hasError, error: error) {}
    }
    
    func setupIDProvider() throws {
        if self.idProvider == nil {
            idProvider = try IDProvider(
                userID: newLoginSettings.username,
                password: newLoginSettings.password,
                emailAddress: newLoginSettings.email,
                clientRegion: clientSettings.region,
                clientID: clientSettings.id
            )
        }
        
        if self.idProvider == nil {
            throw IDError.unexpectedError(error: "Could not initialise IDProvider" as! Error)
        }
    }
    
    func signUp() {
        isSigningUp = true
        isSignedUp = false
        do {
            try self.setupIDProvider()
            try idProvider?.signUp()
            isSignedUp = true
        } catch {
            self.error = error as? IDError ?? .unexpectedError(error: error)
            self.hasError = false
        }
        
        isSigningUp = false
    }
    
    func login() {
        isLoggingIn = true
        do {
            if self.idProvider != nil {
                try setupIDProvider()
            }
            
            if self.idProvider == nil {
                throw IDError.unexpectedError(error: "Could not initialise IDProvider" as! Error)
            }
            try idProvider?.requestAuthentication()
        } catch {
            self.error = error as? IDError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        
        lastLogin = Date()
        isLoggingIn = false
    }
}

#Preview {
    LoginScreen()
}
