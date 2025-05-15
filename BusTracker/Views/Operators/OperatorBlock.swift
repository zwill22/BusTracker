//
//  OperatorBlock.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct OperatorBlock: View {
    var transportOperator: Operator
    var height: CGFloat = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(transportOperator.primaryColour)
            .frame(width: 80, height: height)
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
