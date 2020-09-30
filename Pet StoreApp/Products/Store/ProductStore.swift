//
//  ProductStore.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

class ProductStore: ObservableObject {
    
    @Published var productCategories : [ProductCategory] = []
    @Published var allProducts: [Product] = []
    var repo = RepositoryProductDownload()
    
    init() {
        repo.getProductCategoriesFromRemote { (productCategoriesFromRemote) in
            self.productCategories = self.setCategoryImages(productCategories: productCategoriesFromRemote)
            
            self.repo.readProductsFromRemote { (productsFromRemote) in
                
                self.allProducts = productsFromRemote
                CartStore.products = productsFromRemote
            }
        }
    }
    
    func setCategoryImages(productCategories: [ProductCategory]) -> [ProductCategory] {
        var productCategoryArrToReturn : [ProductCategory] = []
        
        for category in productCategories {
            if category.categortyName == "Dog" {
                let category = ProductCategory(categortyName: "Dog", image: Image("dog image"))
                productCategoryArrToReturn.append(category)
            }
            else if category.categortyName == "Cat"{
                let category = ProductCategory(categortyName: "Cat", image: Image("cat image"))
                productCategoryArrToReturn.append(category)
            } else if category.categortyName == "Fish"{
                let category = ProductCategory(categortyName: "Fish", image: Image("fish image"))
                productCategoryArrToReturn.append(category)
            } else {
                let category = ProductCategory(categortyName: category.categortyName, image: Image("generic pet image"))
                productCategoryArrToReturn.append(category)
            }
        }
        return productCategoryArrToReturn
    }
    
    func setProductToUserFavouriteLocally(product: Product){
        for (index, singleProduct) in self.allProducts.enumerated() {
            if singleProduct.id == product.id{
                print(allProducts[index].isFavourite)
                self.allProducts[index].isFavourite = true
                print(allProducts[index].isFavourite)
            }
        }
    }
    
    func removeProductFromUsersFavouritesLocally(product: Product){
        for (index, singleProduct) in self.allProducts.enumerated() {
            if singleProduct.id == product.id{
                print(allProducts[index].isFavourite)
                self.allProducts[index].isFavourite = false
                print(allProducts[index].isFavourite)
            }
        }
    }
}




