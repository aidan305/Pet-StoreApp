//
//  PaymentView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 30/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct PaymentView: View {
    
    @ObservedObject var cart = CartStore()
    
    var body: some View {
    
        VStack{
            StripeCheckoutView()
                .frame(height: 250)
//            VStack{
//                Spacer()
//                HStack{
//                    Text("Total")
//                    Spacer()
//                    Text("€" + String(format : "%0.2f", cart.calculateTotalCost()))
//                }
                
//                Button(action: {
//                    self.stripeCheckoutViewController.performPaymentProcess()
//                }) {
//                    Text("BUY")
//                    .bold()
//                }
//                NavigationLink(destination: EmptyView()){
//                    Text("Buy")
//                        .frame(width: 200, height: 30, alignment: .trailing)
//                        .font(.custom("SanFranciscoDisplay-Black", size: 20))
//                        .foregroundColor(.primary)
//                        .padding([.leading, .trailing], 10)
//                        .padding([.top, .bottom], 5)
//                        .background(Color("Primary Green"))
//                        .cornerRadius(10)
//                        .shadow(radius: 10)
//                }.padding(.top)
                
            //}
        }
    
        
    }
}

