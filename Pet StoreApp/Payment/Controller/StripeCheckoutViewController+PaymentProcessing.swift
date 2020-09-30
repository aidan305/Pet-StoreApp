//
//  StripeCheckoutViewController+PaymentProcessing.swift
//  Pet StoreApp
//
//  Created by aidan egan on 05/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//



import UIKit
import SwiftUI
import Stripe
import Alamofire


//MARK: Payment Processing Code
//Step 1: Create payment intent by making request to backend  -> func createPaymentIntent
//Step 2: Use the api secret returned to construct the stripe payment parameters (card details)
//Step 3: Confirm the payment intent client side
//extension StripeCheckoutViewController {

extension StripeCheckoutViewController{

    //First create customer, then create payment intent and finally confirm payment
    func performPaymentProcess(){
        
        apiClient.customerName = customerNameTextField.text ?? "No Customer Name Entered"
        
        apiClient.createCustomerKey(withAPIVersion: "2020-03-02") {
            (CustomerInfoJson, error) in
            
            let customerDetails = CustomerInfoJson!["associated_objects"] as! [Any]
            let customerDictionary = customerDetails[0] as! [String: Any]
            let custId = customerDictionary["id"] as! String
            
            self.apiClient.createPaymentIntent(customerId: custId, orderID: self.orderID, cost: "\(self.calculateTotalCostForStripe())"){ (paymentIntentResponse, error) in
                if let error = error {
                    print(error)
                    //add something here to display this error text to user if payment intent fails to correct
                }
                else {
                    guard let responseDictionary = paymentIntentResponse as? [String :  Any] else {
                        print("incorrect response")
                        return
                    }
                    
                   // if responseDictionary != nil {
                        let clientSecret = responseDictionary["secret"] as! String
                        self.confirmPaymentIntent(clientSecret: clientSecret)
                    //}
                }
            }
        }
    }
    
    func confirmPaymentIntent(clientSecret: String){
        //First construct the stripe payment paramters
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        
        let paymentMethodParams = STPPaymentMethodParams(card: self.stripepaymentCardTextField.cardParams, billingDetails: nil, metadata: nil)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        //Then confirm the payment
        STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
            
            //self.textOutputView.text = "Finished loading"
            print("Finshed Loading")
            switch (status) {
            case .canceled:
                print("Payment Cancelled")
            //self.textOutputView.text = "Payment Cancelled"
            case .failed:
                print("Payment Failed")
            //self.textOutputView.text = "Payment Failed"
            case .succeeded:
                self.stripepaymentCardTextField.clear()
                self.customerNameTextField.text = ""
                StripeCheckoutViewController.totalCostLabel.text = ""
                self.addShippingBtn.setTitle("", for: .normal)
                print("Payment Success!")
                
                print("done order upload")
                
                //Payment confirmation email
                let emailConfirmationVC = PaymentConfirmationEmailViewController()
                emailConfirmationVC.sendEmail(orderID: "\(self.orderID)", name: self.customerName, email: self.customerEmailFromShippingForm)
                
                
                //Present the payment confirmation screen (SwiftUI view) when the payment is successful and order uploaded
                
                
                let swiftUIView = PaymentConfirmationView(totalPriceToDisplay: StripeCheckoutViewController.self.totalCostLabel.text ?? "Error Occured", custEmail: self.customerEmailFromShippingForm, orderId: self.orderID, tabSelection: .constant(1))
                
                var viewCtrl : UIHostingController<PaymentConfirmationView>
                viewCtrl = UIHostingController(rootView: swiftUIView)
                StripeCheckoutViewController.confirmationScreenVC = viewCtrl
                viewCtrl.modalPresentationStyle = .automatic
                self.loadingViewController.dismiss(animated: false, completion: nil) //remove loading view
                self.present(viewCtrl, animated: true)
                
            @unknown default:
                print("Unknown payment error")
                
            }
        }
    }
    //Create a delete func here viewCtrl.dismiss and call from PaymentConfirmationView
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
