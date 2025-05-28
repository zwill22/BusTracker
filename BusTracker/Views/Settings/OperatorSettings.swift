//
//  OperatorSettings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct OperatorSettings: View {
    @Binding var operators: [Operator]
    
    var body: some View {
        Text("\(String(format: "%d", operators.count)) Operators")
    }
}

#Preview {
    @Previewable @State var operators: [Operator] = [Operator.preview]
    
    OperatorSettings(operators: $operators)
}
