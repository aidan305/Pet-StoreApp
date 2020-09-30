//
//  CartView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 29/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage
import ActivityIndicatorView

struct CartView: View {
    
    @ObservedObject var cart = CartStore()
    @Binding var tabSelection: Int
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var showCartEmptyState: Bool = false

    
    var body: some View {
        ZStack{
            VStack{
                if keyboard.currentHeight == 0 {
                    VStack(alignment: .leading){
                        ZStack{
                            List{
                                ForEach(0..<self.cart.itemsInShoppingCart.count, id: \.self) { index in
                                    HStack{
                                        SingleProductItemView(product: self.cart.itemsInShoppingCart[index])
                                            .frame(height: 120)
                                        Button(action: {
                                            self.removeItemFromCart(productToRemove: self.cart.itemsInShoppingCart[index])
                                            print("\(self.cart.calculateTotalCost())")
                                            StripeCheckoutViewController.loadTotalPriceToScreen(priceString: "\(self.cart.calculateTotalCost())")
                                        }){
                                            Image(systemName: "trash")
                                        } 
                                    }
                                }
                            }
                                .environment(\.defaultMinListRowHeight, 120)
                            if showCartEmptyState {
                                Image("Empty Trolley").resizable().frame(width: 300, height: 250)
                            }
                        }
                    }
                }
                StripeCheckoutView()
                    .frame(height: 250)
                    .padding([.bottom], keyboard.currentHeight == 0 ? 0 : 200)
            }
        }.modifier(CustomNavigationBarViewModifier(sectionTitle: "Cart", spacing: 95, tabSelection: $tabSelection))
        .onAppear(perform: loadCart)
    }
    func loadCart() {
        if cart.itemsInShoppingCart.count == 0{ //no items displayed in cart on screen and user clicked on cart from tab bar
            cart.populateItemsInCart()
            showCartEmptyState = false
            if cart.itemsInShoppingCart == [] {
                //if after trying to populate cart and still no items in cart then its empty and we show empty state
                showCartEmptyState = true
            }
            else { //new item was add
                cart.itemsInShoppingCart = []
                cart.populateItemsInCart()
            }
        }
    }
    
    func clearCart(){
        cart.itemsInShoppingCart = []
    }
  
    func removeItemFromCart(productToRemove: Product){
        cart.removeItemFromShoppingCart(itemToRemove: productToRemove)
    }
}

struct SingleProductItemView: View{
    var product: Product
    var spacing: CGFloat?
    
    var body: some View {
        HStack(spacing: spacing){
            URLImage(product.productImageURLs[0]) { proxy in
                proxy.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
            }
            Text("\(product.productName)")
            Text("€" + String(format : "%0.2f", product.productPrice))
            Text("\(product.customerQuantity)")
        }
    }
}





