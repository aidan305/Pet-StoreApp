//
//  RepositoryOrderUpload.swift
//  Pet StoreApp
//
//  Created by aidan egan on 12/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

class RepositoryOrderUpload{
    
    func uploadOrder(email: String, orderID: Int, products: [Product], completion: @escaping() -> Void){
        
        var values = [String : Any]()
        let order = createOrder(orderID: orderID, products: products)
        
        let ref = Database.database().reference()
        let orderReference = ref.child("Orders").child("\(order.id)")
        
        //values are basically are productsInOrder
        
        values = ["Customer Email" : email]
        
        for i in 0..<order.products.count {
            let value = ["Product \(i): name" : order.products[i].productName, "Product \(i): Quantity" : order.products[i].productQuantity] as [String : Any]
            
            values.merge(value)  { (_, second) in second }
        }
        
        orderReference.updateChildValues(values, withCompletionBlock: { error , ref in
            if let error = error {
                print(error)
                return
            }
            print("upload complete to \(ref)")
            completion()
        })
        
    }
    
    
    func createOrder(orderID: Int, products: [Product]) -> Order {
        var orderToReturn: Order
        
        
        var productsInOrder = [SpecificOrderDetails]()
    
        for product in products {
            let productName = product.productName
                
            let productQuantity = product.customerQuantity
            
            let specificProduct = SpecificOrderDetails(productName: productName, productQuantity: productQuantity)
            productsInOrder.append(specificProduct)
            
            
        }
        
        orderToReturn = Order(id: orderID, products: productsInOrder)
        return orderToReturn
    }
}
