//
//  OperatorDetailView.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct OperatorDetailView: View {
    var transportOperator: Operator
    var action: () -> Void = {}
    
    var body: some View {
        VStack {
            OperatorBlock(transportOperator: transportOperator).padding(.top)
            Text(transportOperator.mode.rawValue).font(.title2).padding(.bottom)
            Text(transportOperator.name).font(.largeTitle).padding(.bottom)
            List {
                if let website = transportOperator.website {
                    WebButton(webAddress: website)
                }
                if let twitter = transportOperator.twitter {
                    TwitterButton(twitterHandle: twitter)
                }
                if let address = transportOperator.address {
                    AddressButton(address: address).scaledToFill()
                }
                
                ForEach(transportOperator.enquiries, id: \.self) { enquiry in
                    switch enquiry.type {
                    case .email:
                        EmailButton(email: enquiry.string)
                    case .phone:
                        PhoneButton(phoneNumber: enquiry.string)
                    default:
                        OtherEnquiryButton(string: enquiry.string)
                    }
                }
            }
        }
    }
}

#Preview {
    OperatorDetailView(transportOperator: Operator.preview)
}
