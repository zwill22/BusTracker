//
//  OperatorBlock.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct OperatorBlock: View {
    @Environment(\.colorScheme) var colorScheme
    var transportOperator: Operator
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(transportOperator.primaryColour)
            .frame(width: 64, height: 64)
            .overlay {
                Image(systemName: transportOperator.mode.image())
                    .font(.title)
                    .bold()
                    .foregroundStyle(transportOperator.secondaryColour)
            }
        
    }
}

#Preview {
    OperatorBlock(transportOperator: Operator.preview)
}
