//
//  StripeCheckoutViewController+CustomerShippingProcessing.swift
//  Pet StoreApp
//
//  Created by aidan egan on 05/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import UIKit
import Stripe

extension StripeCheckoutViewController: STPPaymentContextDelegate{
    
    
    func initialSetup() {
        let customerContext = STPCustomerContext(keyProvider: PaymentAPIClient.sharedClient)
        paymentContext = STPPaymentContext(customerContext: customerContext)
        paymentContext.delegate = self
        paymentContext.hostViewController = self
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        let upsGround = PKShippingMethod()
        upsGround.amount = 0
        upsGround.label = "UPS Ground"
        upsGround.detail = "Arrives in 3-5 days"
        upsGround.identifier = "ups_ground"
        let fedEx = PKShippingMethod()
        //fedEx.amount = 5.99
        fedEx.label = "FedEx"
        fedEx.detail = "Arrives tomorrow"
        fedEx.identifier = "fedex"
        
        if address.country == "US" || address.country == "IE"{
            completion(.valid, nil, [upsGround, fedEx], upsGround)
        }
        else {
            completion(.invalid, nil, nil, nil)
        }
    }
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        print("contextDidChange")
        
        if let cityAddress = paymentContext.shippingAddress?.city {
            addShippingBtn.setTitle("\(cityAddress)", for: .normal)
        }
        else{
            if let country = paymentContext.shippingAddress?.country{
                addShippingBtn.setTitle("\(country)", for: .normal)
            }
        }
        
        if let email = paymentContext.shippingAddress?.email {
            print("the customer email is: \(email)")
            customerEmailFromShippingForm = email
        }
        
        if let name = paymentContext.shippingAddress?.name{
            customerName = name
        }
    }
    
    
    
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        print("created payment result")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        print("did finish with")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        print("Error occurred \(error)")
    }
    
    
}
