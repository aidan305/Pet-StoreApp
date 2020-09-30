//
//  ContentView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 22/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        TabView(selection: $tabSelection){
            NavigationView{
                ProductCategoriesListView(tabSelection: $tabSelection).navigationBarTitle("", displayMode: .inline)
            }
            .tabItem {
                Text("Shop")
                Image(systemName: "house.fill")
            }
            .tag(1)
            NavigationView{
                CartView(tabSelection: $tabSelection).navigationBarTitle("", displayMode: .inline)
            }
                .tabItem {
                    Text("Cart")
                    Image(systemName: "cart.fill")
            }
            .tag(2)
            
            NavigationView{
            FavouritesListView(tabSelection: $tabSelection).navigationBarTitle("", displayMode: .inline)
            }
                .tabItem{
                    Text("Favourites")
                    Image(systemName: "heart.fill")
            }.tag(3)
            

            if (session.session != nil ){
                NavigationView{
                ProfileView(tabSelection: $tabSelection).navigationBarTitle("", displayMode: .inline)
                }
                    .tabItem {
                        Text("Profile")
                        Image(systemName: "person.crop.circle")
                            
                }.tag(4).accessibility(identifier: "ProfileTab")
                
               
            }
            if (session.session == nil)  {
                SignUpView(tabSelection: $tabSelection)
                    .tabItem {
                        Text("Profile")
                        Image(systemName: "person.crop.circle")
                }.tag(5)
            }
        }.accentColor(Color("Primary Green"))
            .onAppear(perform: getUser)
    }
    
    func getUser() {
        session.listen()
    }
    
    func switchTab(tabTag: Int){
        tabSelection = tabTag
    }
}

