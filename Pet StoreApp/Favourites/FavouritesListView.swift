//
//  FavouritesListView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 11/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage

struct FavouritesListView: View {
    @Binding var tabSelection: Int
    @ObservedObject var profile = ProfileStore()
    @EnvironmentObject var session: SessionStore
    @State var showsEmptyState: Bool = false
    
    
    var body: some View {
        VStack{
            List{
                ForEach(profile.usersFavouriteProducts, id: \.self) { favouriteProduct in
                    HStack(spacing: 50){
                        URLImage(favouriteProduct.productImageURLs[0]) { proxy in
                            proxy.image
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 120, height: 150)
                        }.border(Color("Primary Green"), width: 2)
                        
                        
                        Text("\(favouriteProduct.productName )").bold()
                    }
                    
                }
                .onDelete{ index in
                    let idFavouriteToBeDeleted = self.profile.usersFavouriteProducts[index.first!].id
                    self.profile.usersFavouriteProducts.remove(at: Int(index.first!))
                    self.profile.deleteFavouriteFromFirebase(userID: self.session.session?.uid ?? "", idOfFavouriteToDelete: "\(idFavouriteToBeDeleted)")
                    if self.profile.usersFavouriteProducts.count == 0 {
                        self.showsEmptyState = true
                    }
                    
                }
            }.onAppear(perform: loadFavourites)
                .padding(.bottom, 30)
                .environment(\.defaultMinListRowHeight, 180) // creates spacing between the  rows for better UI.
                .modifier(CustomNavigationBarViewModifier(sectionTitle: "Favourites", spacing: 60, tabSelection: $tabSelection))
            
            
            if showsEmptyState {
                FavouritesEmptyState()
            }
        }
    }
    
    func loadFavourites(){
        if session.session?.uid != nil{
            showsEmptyState = false
            profile.usersFavouriteProducts = []
            profile.readUsersFavouritesFromFirebase(uid: session.session?.uid ?? ""){
                return
            }
        } else {
            showsEmptyState = true
        }
    }
}

struct FavouritesEmptyState: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            
            if session.session != nil {
                Image("cat favourite empty state - signed in")
                    .resizable()
                    .frame(width: UIScreen.screenWidth - 25, height: 450)
                    .padding(.bottom, 85)
            }
            else{
                Image("cat favourite empty state - not signed in")
                    .resizable()
                    .frame(width: UIScreen.screenWidth - 25, height: 450)
                    .padding(.bottom, 85)
            }
        }
    }
}


