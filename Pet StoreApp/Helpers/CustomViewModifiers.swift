//
//  customViewModifiers.swift
//  Pet StoreApp
//
//  Created by aidan egan on 27/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct CustomTitleStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .font(.custom("SanFranciscoRounded-Bold", size: 30))
            .foregroundColor(Color.white)
            .shadow(radius: 20)
    }
}

struct CustomCategoryCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .cornerRadius(10)
            .shadow(radius: 8)
        
    }
}
   
    
struct CustomNavigationBarViewModifier: ViewModifier {
    var sectionTitle: String
    var spacing: CGFloat
    @Binding var tabSelection: Int
    @ObservedObject var cart = CartStore()
    
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(leading:
                HStack(spacing: spacing){
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 35))
                    }.foregroundColor(Color("Primary Green"))
                    Text(sectionTitle)
                        .font(.custom("SanFranciscoRounded-Bold", size: 35))
                        .foregroundColor(Color("Primary Green"))
                        
                },
                trailing:
                HStack {
                    Button(action: switchTab) {
                        ZStack{
                            Image(systemName: "cart.fill")
                                .font(.system(size: 35))
                            if cart.itemsInShoppingCart.count != 0 {
                            Text("\(cart.itemsInShoppingCart.count)")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(Color.white)
                                .offset(x: 4, y: -7)
                            }
                        }
                    }.foregroundColor(Color("Primary Green"))
            }
        )
    }
    
    func switchTab(){
        tabSelection = 2
    }
}

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}



