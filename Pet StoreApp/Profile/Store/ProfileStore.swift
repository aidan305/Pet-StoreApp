//
//  ProfileStore.swift
//  Pet StoreApp
//
//  Created by aidan egan on 18/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ProfileStore: ObservableObject {
    @Published var profile : User?
    @Published var userOrders : [Order] = []
    @Published var usersFavouriteProducts : [Product] = []
    let userRepo = RepositoryUser()
    @State var refreshHeartinView: Bool = false
    
    
    func getName() -> String {
        return "Aidan"
    }
    
    func simplyAddFavouriteProduct(product: Product){
        usersFavouriteProducts.append(product)
    }
    
    func getOrders(uid: String) -> String  {
        lookUpUsersOrders(uid: uid) { orders in
            self.userOrders = orders
        }
        return "text"
    }
    
    func lookUpUsersOrders(uid: String, _completion: @escaping ([Order]) -> Void) {
        let ref = Database.database().reference(withPath: "Orders")
        var usersOrderIDs = [String]()
        var arrOfOrders = [Order]()
        
        userRepo.readUsersOrders(uid: uid) { (usersOrderStringIds) in
            usersOrderIDs = usersOrderStringIds
            
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let allOrders = snapshot.value as? [String : Any] {
                    if usersOrderIDs.count != 0 {
                        
                        for index in 0...usersOrderIDs.count - 1 {
                            for order in allOrders{
                                if usersOrderIDs[index] == order.key {
                                    //print("The order id \(order.key) has \(order.value)")
                                    let order = self.decodeOrderValue(orderID: order.key, orderValue: order.value)
                                    print("The order id:\(order.id) contains \(order.products)")
                                    arrOfOrders.append(order)
                                    if usersOrderIDs.count == arrOfOrders.count {
                                        _completion(arrOfOrders)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func decodeOrderValue(orderID: String, orderValue: Any) -> Order {
        var specificOrderDetails = [SpecificOrderDetails]()
        
        if let orderValue = orderValue as? [String : Any] {
            
            if let productName = orderValue["Product 0: name"] as? String {
                if let productQuantity = orderValue["Product 0: Quantity"] as? Int{
                    //                    print(productQuantity)
                    //                    print(productName)
                    let product = SpecificOrderDetails(productName: productName, productQuantity: productQuantity)
                    specificOrderDetails.append(product)
                }
            }
            
            if let product2Name = orderValue["Product 1: name"] as? String {
                if let product2Quantity = orderValue["Product 1: Quantity"] as? Int{
                    let product = SpecificOrderDetails(productName: product2Name, productQuantity: product2Quantity)
                    specificOrderDetails.append(product)
                }
            }
            
            if let product3Name = orderValue["Product 2: name"] as? String {
                if let product3Quantity = orderValue["Product 2: Quantity"] as? Int{
                    let product = SpecificOrderDetails(productName: product3Name, productQuantity: product3Quantity)
                    specificOrderDetails.append(product)
                }
            }
            
            if let product4Name = orderValue["Product 3: name"] as? String {
                if let product4Quantity = orderValue["Product 3: Quantity"] as? Int{
                    let product = SpecificOrderDetails(productName: product4Name, productQuantity: product4Quantity)
                    specificOrderDetails.append(product)
                }
            }
        }
        let usersOrderToReturn = Order(id: Int(orderID) ?? 0, products: specificOrderDetails)
        return usersOrderToReturn
    }
    
    func addToFavourites(userID: String, product: Product, _ completion: @escaping () -> Void){
        
        let usersFavRef = Database.database().reference(withPath: "Users").child(userID).child("Favourite")
        var values = [String : String]()
        
        readUsersFavouritesFromFirebase(uid: userID){
            let alreadyExists = self.usersFavouriteProducts.contains { $0.productName == "\(product.productName)" }
            
            if alreadyExists == false  {
                //Step 1 : read existing favourites and add to values variable
                for (index, aleadySavedFavourite) in self.usersFavouriteProducts.enumerated() {
                    values.updateValue("\(aleadySavedFavourite.id)", forKey: "Favourite \(index)")
                }
                //Step 2: add new favourite to values
                let newFavouriteValue = ["Favourite \(self.usersFavouriteProducts.count + 1)" : "\(product.id)"]
                values.merge(newFavouriteValue)  { (_, second) in second }
                
                //Step 3: Append new favourite to local favourite array
                self.usersFavouriteProducts.append(product)
                
                //Step 4: Upload to firebase the new favourite values
                usersFavRef.setValue(values) { error, result  in
                    if let error = error {
                        print(error)
                        return
                    }
                    completion()
                }
            }
        }
    }
    
    func readUsersFavouritesFromFirebase(uid: String, _ completion: @escaping () -> Void) {
        let usersFavouritesRef = Database.database().reference(withPath: "Users").child(uid).child("Favourite")

        var userFavouritesID = [String]()
        let usersRef = Database.database().reference(withPath: "Users")
        
        //first check if any favourites exist
        usersRef.child("\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild("Favourite"){
                print("Favourite exists")
            }else{
                print("Favourite doesn't exist")
                completion()
            }
        })
        
        
        usersFavouritesRef.observeSingleEvent(of: .value, with: {
            snapshot in
            if let arrOfFav = snapshot.value as? [String: String] {
                
                for favourite in arrOfFav {
                    userFavouritesID.append(favourite.value)
                }
                
                for product in CartStore.products {
                    for favouriteID in userFavouritesID {
                        if product.id == UUID(uuidString: favouriteID) {
                            self.usersFavouriteProducts.append(product)
                            if arrOfFav.count == self.usersFavouriteProducts.count{
                                completion()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func readUsersFavouritesIDsFromFirebase(uid: String, completion: (([String])->Void)?) {
        
        if profile?.uid != nil {
            let usersFavouritesRef = Database.database().reference(withPath: "Users").child(uid).child("Favourite")
            let usersRef = Database.database().reference(withPath: "Users")
            var userFavouritesID = [String]()
            
            //first check if any favourites exist
            usersRef.child("\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild("Favourite"){
                    print("Favourite exists")
                }else{
                    print("Favourite doesn't exist")
                    completion?([])
                }
            })
            
            usersFavouritesRef.observeSingleEvent(of: .value) {
                snapshot in
                if let arrOfFav = snapshot.value as? [String: String] {
                    
                    for favourite in arrOfFav {
                        userFavouritesID.append(favourite.value)
                    }
                    if arrOfFav.count == userFavouritesID.count{
                        completion?(userFavouritesID)
                        return
                    }
                }
            }
        } else{
            completion?([])
        }
    }
    
    func deleteFavouriteFromFirebase(userID: String, idOfFavouriteToDelete: String){
        let favouriteRef = Database.database().reference(withPath: "Users").child(userID).child("Favourite")
        
        
        favouriteRef.observe(.value) { snapshot in
            if let allFavourites = snapshot.value as? [String : Any] {
                
                for favourite in allFavourites {
                    print("The current value is \(favourite.value)")
                    print(idOfFavouriteToDelete)
                    print("--------")
                    if "\(favourite.value)" == idOfFavouriteToDelete {
                        print("\(favouriteRef.child(favourite.key))")
                        
                        let referenceToDelete = favouriteRef.child(favourite.key)
                        referenceToDelete.removeValue()
                        
                    }
                }
            }
        }
    }
}
