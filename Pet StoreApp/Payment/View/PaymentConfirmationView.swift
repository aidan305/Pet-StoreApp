//
//  PaymentConfirmationView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 05/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct PaymentConfirmationView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var cart = CartStore()
    let totalPriceToDisplay : String
    let custEmail : String
    let orderId : Int
    let orderRepository = RepositoryOrderUpload()
    let userRepositoy = RepositoryUser()
    let stripeCheckoutViewController = StripeCheckoutViewController()
    @Binding var tabSelection: Int
    let orderCompleteText = "Payment complete you will recieve a confirmation mail shortly."
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
  

    
    var body: some View {
        VStack{
            Spacer(minLength: 70)
            ScrollView{
                VStack{
                    VStack(alignment: .center, spacing: 15){
                        Image("dog with parcel")
                            .resizable()
                            .frame(width: 200, height: 180)
                            .foregroundColor(Color("Primary Green"))
                        Text("Order No# \(orderId)".replacingOccurrences(of: ",", with: "")).bold()
                        Text(orderCompleteText)
                            .italic()
                            .frame(alignment: .center)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding([.bottom], 30)
                    Spacer()
                }.onAppear(perform: uploadOrderToFirebase)
                    .hiddenNavigationBarStyle()
            }
        }
        
    }
    
    func uploadOrderToFirebase(){
        //Upload order to orders table in FB
        //Clear cart
        //If the user has an account and is signed in Update users table with order id
        cart.clearCart()
       
        self.orderRepository.uploadOrder(email: self.custEmail, orderID: self.orderId, products: self.cart.itemsInShoppingCart) {
            if (self.session.session != nil ){
                if let uid = self.session.session?.uid {
                    self.userRepositoy.addOrderToUser(orderID: self.orderId, uid: uid) {
                        
                    }
                }
            }
        }
    }
}




