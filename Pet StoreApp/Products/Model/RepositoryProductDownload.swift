//
//  RepositoryProductDownload.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

class RepositoryProductDownload{
    
    var tempProductCategoryArray : [ProductCategory] = []
    var tempProductArray : [Product] = []
    var totalProducts : Int = 0
    let productDBRef = Database.database().reference(withPath: "Product Categories")
    @ObservedObject var profile = ProfileStore()
    @ObservedObject var session = SessionStore()
    var usersFavouriteProductIDs : [String] = []
    
    
    func readProductsFromRemote(_ completion: @escaping ([Product]) -> Void) {
        
      profile.readUsersFavouritesIDsFromFirebase(uid: globalUserID ?? "") { usersFavouriteProductIDs in
            self.usersFavouriteProductIDs = usersFavouriteProductIDs
            
            self.productDBRef.observeSingleEvent(of: .value) { snapshot in
                if let allProductCategories = snapshot.value as? [String : Any] {
                    
                    for productCategory in allProductCategories {
                        
                        self.productDBRef.child(productCategory.key).observe(.value) { ProductSnapshot in
                            
                            
                            let productCategory = ProductCategory(categortyName: productCategory.key)
                            
                            if let products = ProductSnapshot.value as? [String: Any]{
                                
                                for product in products {
                                    let productID = product.key
                                    
                                    
                                    if let indivdualProduct = product.value as? [String: Any]{
                                        let name = indivdualProduct["Name"] as! String
                                        let description = indivdualProduct["Description"] as! String
                                        let price = Double(indivdualProduct["Price"] as! String)
                                        let imageUrls = indivdualProduct["Images"] as? [String]
                                        let flashText = indivdualProduct["FlashText"] as? String
                                        
                                        let newURLArray = self.stringArrToURLArr(stringArray: imageUrls!)
                                        
                                        print("The PRODUCT is \(name)")
                                        let product = Product(category: productCategory, productName: name, productDescription: description, productPrice: price ?? 10.0, flashText: flashText, productImageURLs: newURLArray, id: UUID(uuidString: productID) ?? UUID(), isFavourite: self.checkIfProductIsFavourite(productID: product.key))
                                        self.tempProductArray.append(product)
                                    }
                                }
                                if self.totalProducts == self.tempProductArray.count && self.totalProducts > 0{
                                    completion(self.tempProductArray)
                                }
                            }
                        }
                    }
                }
            }
       }
    }
    
    func checkIfProductIsFavourite(productID: String) -> Bool {
        
        var isFavourite: Bool = false
        
        if globalUserID != nil {
            if self.usersFavouriteProductIDs.contains(where: {$0 == productID.uppercased()}) {
                isFavourite = true
            }else{
                isFavourite = false
            }
        }
        return isFavourite
    }
        
    func getProductCategoriesFromRemote(_ completion: @escaping ([ProductCategory]) -> Void) {
        
        productDBRef.observe(.value) { snapshot in
            if let allProductCategories = snapshot.value as? [String : Any] {
                for productCategory in allProductCategories {
                    let productCategoryToAdd = ProductCategory(categortyName: productCategory.key)
                    self.tempProductCategoryArray.append(productCategoryToAdd)
                    
                    if allProductCategories.count == self.tempProductCategoryArray.count{
                        self.getTotalNumberOFProducts()
                        completion(self.tempProductCategoryArray)
                    }
                }
            }
        }
    }
    
    func getTotalNumberOFProducts() {
        for category in tempProductCategoryArray{
            let categoryRef = productDBRef.child("\(category.categortyName)")
            categoryRef.observe(.value) { snapshot in
                self.totalProducts = Int(snapshot.childrenCount) + self.totalProducts
            }
        }
    }
    
    func stringArrToURLArr(stringArray: [String]) -> [URL] {
        var urlArrayToReturn : [URL] = []
        for index in 0...stringArray.count - 1 {
            if let url = URL(string: stringArray[index]) {
                urlArrayToReturn.append(url)
            }
        }
        return urlArrayToReturn
    }
}

