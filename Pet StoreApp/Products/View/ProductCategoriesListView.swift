//
//  ProductCategoriesListView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct ProductCategoriesListView: View {
    
    @ObservedObject var products = ProductStore()
    @Binding var tabSelection: Int
    @ObservedObject var cart = CartStore()
    
    var itemsPerRow = 2
    var body: some View {
        
        List{
            ForEach(0..<self.products.productCategories.count, id: \.self) {index in
                
                ZStack{
                    self.products.productCategories[index].image?
                        .resizable()
                    Text(self.products.productCategories[index].categortyName)
                        .modifier(CustomTitleStyle())
                    NavigationLink(destination: ProductListView(choosenProductCategory: self.products.productCategories[index].categortyName, tabSelection: self.$tabSelection)){
                        EmptyView() // in order to hide the arrow on the list we need to add empty view see medium article below for more details
                    }
                }.frame(height: 160)
            }
            .modifier(CustomCategoryCellStyle())
        }
        .modifier(CustomNavigationBarViewModifier(sectionTitle: "Shop", spacing: 95, tabSelection: $tabSelection))
            .environment(\.defaultMinListRowHeight, 180) // creates spacing between the  rows for better UI.
            .onAppear(perform: clearLinesInList)
    }
    func clearLinesInList(){
        UITableView.appearance().separatorColor = .clear //removes line separtors in list
    }
}


