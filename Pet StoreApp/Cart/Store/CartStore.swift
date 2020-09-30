//
//  CartStore.swift
//  Pet StoreApp
//
//  Created by aidan egan on 29/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

class CartStore: ObservableObject {
    
    let defaults = UserDefaults.standard
    @Published var itemsInShoppingCart: [Product] = []
    static var products = [Product]()
    
    init() {
        populateItemsInCart()
    }
    
    func addItemToShoppingCart(itemAdded: Product, completion: @escaping () -> Void){
        
        //Add to Cart Array
        //if it exists do this
        if itemsInShoppingCart.contains(where: { $0.productName == itemAdded.productName }){
            for (index, item) in itemsInShoppingCart.enumerated(){
                
                if item.id == itemAdded.id{ //already exists in cart so just increase quatity by 1
                    itemsInShoppingCart[index].customerQuantity += 1
                    print(itemsInShoppingCart[index].customerQuantity)
                    completion()
                }
            }
        }else { //new item added to cart doesnt already exist
            var newItemForCart = itemAdded
            newItemForCart.customerQuantity = 1
            itemsInShoppingCart.append(newItemForCart)
            completion()

        }
        
        //Add to User defaults
        var newCartItemsUserDefaults = [String]()
        let existingCartItemsUserDefaults = defaults.stringArray(forKey: "ItemIdsInCart") ?? [String]()
        
        for id in existingCartItemsUserDefaults {
            newCartItemsUserDefaults.append(id)
        }
        newCartItemsUserDefaults.append("\(itemAdded.id)")
        defaults.set(newCartItemsUserDefaults, forKey: "ItemIdsInCart")
    }
    
    func removeItemFromShoppingCart(itemToRemove: Product){
        
        //if only 1 left of product in cart then remove completely from the shopping cart
        if itemToRemove.customerQuantity == 1 {
            for (index, item) in itemsInShoppingCart.enumerated() {
                
                if itemToRemove.id == item.id {
                    itemsInShoppingCart.remove(at: index)
                    print("removing \(item.productName) from cart")
                    
                }
            }
        }
            //if more than 1 left of product in cart then just decrease the quantity by 1
        else if itemToRemove.customerQuantity > 1 {
            for (index, item) in itemsInShoppingCart.enumerated() {
                
                if itemToRemove.id == item.id {
                    itemsInShoppingCart[index].customerQuantity -= 1
                    print("decresing \(item.productName) by one in cart")
                    
                }
            }
            
        }
        //Remove from user default
        var newCartItems = [String]()
        var existingCartItems = defaults.stringArray(forKey: "ItemIdsInCart") ?? [String]()
        var itemRemovedFromUserDefaults = false
        
        
        
        for (index, id) in existingCartItems.enumerated().reversed() {
            
            if "\(itemToRemove.id)" == id && itemRemovedFromUserDefaults == false{
                existingCartItems.remove(at: index)
                print("the id being removed from user defaults is: \(id)")
                itemRemovedFromUserDefaults = true
                newCartItems = existingCartItems
            }
        }
        defaults.set(newCartItems, forKey: "ItemIdsInCart")
    }
    
    
    func clearCart(){
        
        var existingCartItemsUserDefaults = defaults.stringArray(forKey: "ItemIdsInCart") ?? [String]()
        existingCartItemsUserDefaults = []
        defaults.set(existingCartItemsUserDefaults, forKey: "ItemIdsInCart")
        itemsInShoppingCart.removeAll()
        itemsInShoppingCart = [Product]()
    }
    
    func getItemsInCart() -> [Product]{
        return itemsInShoppingCart
    }
    
    func getItemNamesInCart() -> [String]{
        var itemsNames : [String] = []
        for item in itemsInShoppingCart {
            itemsNames.append(item.productName)
        }
        return itemsNames
    }
    
    
    func populateItemsInCart(){
        // Step 1 -> Retrieve user default strings
        let userDefaultItemIDs = retrieveUserDefaults()
        
        //Step 2 -> Count frequency's of how many times the id appears in user default
        var dictQuantities = [String: Int]()
        
        for id in userDefaultItemIDs {
            
            //check if id exists
            let idExists = dictQuantities[id] != nil
            
            if idExists == true {
                if var quantity = dictQuantities[id] {
                    quantity = quantity + 1
                    dictQuantities[id] = quantity
                }
            }
            else if idExists == false {
                dictQuantities[id] = 1
            }
        }
        
        //Step 3 -> Convert the string id to a product and set to the desired quantity
        
        for (id, quantity) in dictQuantities {
            print("The \(id) has a quantity of \(quantity)")
            
            
            for var product in CartStore.products {
                let idUUID = UUID(uuidString: id)
                
                if product.id == idUUID{
                    product.customerQuantity = quantity
                    itemsInShoppingCart.append(product)
                    
                }
            }
        }
    }
    
    func calculateTotalCost() -> Double {
        
        var totalCost = 0.0
        
        for (index, _) in itemsInShoppingCart.enumerated() {
            
            if itemsInShoppingCart[index].customerQuantity > 1{
                totalCost += itemsInShoppingCart[index].productPrice * Double(itemsInShoppingCart[index].customerQuantity)
            }
            else if itemsInShoppingCart[index].customerQuantity == 1{
                totalCost += itemsInShoppingCart[index].productPrice
            }
        }
        
        return totalCost
    }
    
    func retrieveUserDefaults() -> [String]{
        let userDefaultsCartItemIds = defaults.object(forKey: "ItemIdsInCart") as? [String] ?? [String]()
        return userDefaultsCartItemIds
        
    }
    
    
}
