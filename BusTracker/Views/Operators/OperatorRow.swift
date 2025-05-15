//
//  OperatorRow.swift
//  Operators
//
//  Created by Zack Williams on 24-04-2025.
//

import SwiftUI

struct OperatorRow: View {
    var busOperator: Operator
    
    var body: some View {
        HStack {
            OperatorBlock(transportOperator: busOperator, height: 75)

            VStack(alignment: .leading) {
                Text("\(busOperator.name)").font(.title)
                        .lineLimit(1, reservesSpace: true)
                
                Text("\(busOperator.opCode)").font(.title2)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    OperatorRow(busOperator: Operator.preview)
}
