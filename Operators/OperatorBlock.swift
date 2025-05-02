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
    
    func getColour() -> (Color, Color) {
        var primaryColour = transportOperator.primaryColour
        var secondaryColour = transportOperator.secondaryColour
        if colorScheme == .dark && primaryColour == .black {
            primaryColour = .white
            if secondaryColour == .white {
                secondaryColour = .black
            }
        }
        
        return (primaryColour, secondaryColour)
    }
    
    var body: some View {
        let (primaryColour, secondaryColour) = getColour()
        RoundedRectangle(cornerRadius: 8)
            .fill(primaryColour)
            .frame(width: 64, height: 64)
            .overlay {
                Image(systemName: transportOperator.mode.image())
                    .font(.title)
                    .bold()
                    .foregroundStyle(secondaryColour)
            }
        
    }
}

#Preview {
    OperatorBlock(transportOperator: Operator.preview)
}
