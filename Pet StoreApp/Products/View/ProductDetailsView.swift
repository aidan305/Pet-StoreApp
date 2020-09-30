//
//  ProductDetailsView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage

struct ProductDetailsView: View {
    
    let productToDisplay : Product
    @ObservedObject var products = ProductStore()
    @Binding var tabSelection: Int
    
    @ObservedObject var cart = CartStore()
    
    var body: some View {
        ScrollView{
            HStack{
                VStack(alignment: .leading){
                    Text("\(productToDisplay.productName )")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.custom("SanFranciscoDisplay-Bold", size: 30))
                        .padding([.top, .leading])
                    URLImage(productToDisplay.productImageURLs[0]) { proxy in
                        proxy.image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 230, height: 300)
                    }
                }
                VStack{
                    Text("\(productToDisplay.flashText ?? "")")
                        .font(.custom("ChalkboardSE-Bold", size: 16))
                        .foregroundColor(Color("Primary Green"))
                    Spacer()
                        .frame(height: 50)
                    Text("€" + String(format : "%0.2f", productToDisplay.productPrice))
                        .font(.custom("SanFranciscoDisplay-Black", size: 22))
                }
            }
            
            //ADD TO CART BELOW :
            VStack{
                Button(action: {
                    self.cart.addItemToShoppingCart(itemAdded: self.productToDisplay) {
                        self.tabSelection = 2
                        
                    }
                    
                }){
                    Text("Add To Cart")
                        .font(.custom("SanFranciscoDisplay-Black", size: 20))
                        .foregroundColor(.primary)
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                        .background(Color("Primary Green"))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Description").bold()
                        .font(.custom("SanFranciscoDisplay-Black", size: 22))
                        .padding([.leading, .top])
                    Text(productToDisplay.productDescription)
                        .padding([.leading, .trailing])
                        .font(.custom("SanFranciscoDisplay-Black", size: 18))
                }
            }
        }
    }
}
