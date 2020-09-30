//
//  ProductListView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage
import ExyteGrid

struct ProductListView: View {
    
    @ObservedObject var products = ProductStore()
    var choosenProductCategory : String 
    @State var selectedProduct : String = ""
    @Binding var tabSelection: Int
    @ObservedObject var profile = ProfileStore()
    @EnvironmentObject var session: SessionStore
    var imageHeartFill =  Image(systemName: "heart.fill")
    var imageHeartEmpty = Image(systemName: "heart")
    
    var body: some View {
        Grid(tracks: 2){
            
            ForEach(products.allProducts.filter({ $0.category.categortyName == choosenProductCategory }), id: \.self) { product in

                    NavigationLink(destination: ProductDetailsView(productToDisplay: product, tabSelection: self.$tabSelection)){
                        
                        ZStack{
                            Rectangle()
                                .cornerRadius(10)
                                .lineLimit(9)
                                .foregroundColor(Color.white)
                                .shadow(radius: 10)
                            VStack{
                                URLImage(product.productImageURLs[0]) { proxy in
                                    proxy.image
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 120, height: 150)
                                }
                                
                                Text(product.productName)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                Text("€" + String(format : "%0.2f", product.productPrice))
                                    .multilineTextAlignment(.leading)
                            }
                            Button(action: {
                                print("heart button on \(product.productName) pressed")
                                if let uid = self.session.session?.uid {
                                    
                                    if product.isFavourite == false {
                                        self.profile.addToFavourites(userID: uid, product: product) {
                                            print("\(product.productName) added to favourites")
                                            self.products.setProductToUserFavouriteLocally(product: product)
                                        }
                                    }
                                    else if product.isFavourite == true {
                                        print("product already added to favourites so here we want to delete from favourites")
                                        self.profile.deleteFavouriteFromFirebase(userID: uid, idOfFavouriteToDelete: "\(product.id)")
                                        self.products.removeProductFromUsersFavouritesLocally(product: product)
                                    }
                                }
                            }) {
                                if product.isFavourite {
                                    self.imageHeartFill
                                        .font(.system(size: 30))
                                } else {
                                    self.imageHeartEmpty
                                        .font(.system(size: 30))
                                }
                            }.offset(x: 65, y: -90)
  
                        }.frame(width: UIScreen.main.bounds.size.width / 2.2, height: 220)
                            .padding()
                }
            }
        }
        .modifier(CustomNavigationBarViewModifier(sectionTitle: "\(choosenProductCategory)", spacing: 95, tabSelection: $tabSelection))
        .gridContentMode(.scroll)
    }
}












