//
//  RepositoryUserUpload.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//


import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

class RepositoryUser{
    
    let ref = Database.database().reference()

    func registerUserIntoDatabase(id: String, email: String, name: String, _ completion: @escaping () -> Void) {
        let userReference = ref.child("Users").child(id)
        let values = ["email": email , "name" : name]
        
        userReference.updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print(error)
                return
            }
            print("upload complete to \(ref)")
            completion()
            
        })
    }

    func addOrderToUser(orderID : Int, uid: String, _ completion: @escaping () -> Void) {
        let usersOrderRef = ref.child("Users").child(uid).child("Orders")
        var arrOfOrders = [String]()
        var values = [String : String]()
        
        //Step 2) append new order to existing user orders and set values
        readUsersOrders(uid: uid) { (orders) in
            arrOfOrders = orders
            arrOfOrders.append("\(orderID)")
            
            for (index, orderId) in arrOfOrders.enumerated() {
                print("\(index) : \(orderId)")
                values["\(index)"] = "\(orderId)"
            }
            
            print(values)
            
            //Step 3) upload the values to user order ref in FB
            usersOrderRef.updateChildValues(values, withCompletionBlock: { error, ref in
                if let error = error {
                    print(error)
                    return
                }
                print("upload complete to \(ref)")
                completion()
            })
        }
    }
    
    func readUsersOrders(uid: String, _ completion: @escaping ([String]) -> Void) {
        let usersOrderRef = ref.child("Users").child(uid).child("Orders")
        var arrOfOrders : [String] = []
        
        //Step 1) observe the order values that already exist
        usersOrderRef.observeSingleEvent(of: .value, with: {
            snapshot in
            if let arrOfOrder = snapshot.value as? [String] {
                arrOfOrders = arrOfOrder
            }
            completion(arrOfOrders)
        })
    }
}
