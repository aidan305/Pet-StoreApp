//
//  ProfileView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profile = ProfileStore()
    @Binding var tabSelection: Int
    
    var body: some View {
        
            ScrollView{
                VStack(spacing: 20){
                    ZStack{
                        Image("fish profile pic").resizable().frame(width: 300, height: 270)
                        Text("Welcome \n   \(profile.getName())").offset(x: 10, y: 125)
                         .font(.custom("SanFranciscoDisplay-Black", size: 18))
                    }
                    Text("\(profile.getOrders(uid: session.session?.uid ?? "no order info"))").hidden()
                    OrderHistory
                    Button("Sign Out"){
                        self.session.signOut()
                    }
                }.frame(width: UIScreen.main.bounds.width)
                
            }.modifier(CustomNavigationBarViewModifier(sectionTitle: "Profile", spacing: 95, tabSelection: $tabSelection))
        
    }
    
    
    var OrderHistory: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Orders")
                .font(.custom("SanFranciscoDisplay-Bold", size: 20))
                .frame(alignment: .leading)
            VStack(spacing: 10){
                ForEach(profile.userOrders, id: \.self) { order in
                    VStack(alignment: .leading, spacing: 4){
                        HStack{
                            Text("Order No: \(order.id)".replacingOccurrences(of: ",", with: "")).italic()
                            Spacer()
                            Text("Quantity").italic()
                        }
                        ForEach(order.products, id: \.self) { product in
                            HStack{
                                Text("\(product.productName)").bold()
                                Spacer()
                                Text("\(product.productQuantity)").frame(alignment: .center)
                            }
                        }
                    }
                }
                .padding(4)
                .background(Color("Primary Green"))
                    //.background(Color("Light Grey"))
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
        }.padding()
    }
}



