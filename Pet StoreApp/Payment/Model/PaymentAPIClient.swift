//
//  PaymentAPIClient.swift
//  Pet StoreApp
//
//  Created by aidan egan on 05/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//


import Foundation
import Stripe
import Alamofire

class PaymentAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    
    
    let backendURL = "https://pet-store-stripe-backend.herokuapp.com"
    static let sharedClient = PaymentAPIClient()
    var customerName = ""
    
    func createPaymentIntent(customerId: String , orderID: Int, cost: String, completion: @escaping STPJSONResponseCompletionBlock) {
           var url = URL(string: backendURL)!
           url.appendPathComponent("create_payment_intent")
           
           AF.request(url, method: .post, parameters: [ "amount" : cost , "country" : "it", "description" : "Order Number: \(orderID)", "customer" : "\(customerId)"])
               
               //        AF.request(url, method: .post, parameters: [ "amount" : 5000 , "country" : "it", "description" : "eganjessie@hotmail.com", "customer" : "\(customerId)"])
               .validate(statusCode: 200..<300)
               .responseJSON { (response) in
                   switch (response.result){
                   case .failure(let error):
                       completion(nil, error)
                   case .success(let jsonResponse):
                       completion(jsonResponse as? [String : Any], nil)
                   }
           }
       }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
           let url = URL(string: backendURL)!.appendingPathComponent("ephemeral_keys")
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
           urlComponents.queryItems = [URLQueryItem(name: "api_version", value: apiVersion), URLQueryItem(name: customerName, value: customerName), URLQueryItem(name: "email", value: "eganjessie123@hotmail.com")]
           var request = URLRequest(url: urlComponents.url!)
           request.httpMethod = "POST"
           
           
           let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
               if let response = response as? HTTPURLResponse {
                   if response.statusCode == 200 {
                       if let data = data {
                           if let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??) {
                               completion(json, nil)
                           }
                       }
                   }
               }
               else {
                   completion(nil, error)
                   return
               }
           })
           task.resume()
       }
}
