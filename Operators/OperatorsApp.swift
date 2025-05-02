//
//  OperatorsApp.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import SwiftUI

@main
struct OperatorsApp: App {
    @StateObject var operatorProvider = OperatorProvider()
    var body: some Scene {
        WindowGroup {
            Operators()
                .environmentObject(operatorProvider)
        }
    }
}
