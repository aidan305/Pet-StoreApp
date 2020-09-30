//
//  PaymentConfirmationEmailViewController.swift
//  Pet StoreApp
//
//  Created by aidan egan on 27/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftSMTP
import SwiftUI

class PaymentConfirmationEmailViewController {
   @ObservedObject var cart = CartStore()
    var itemNamesForEmail = ""
    
    init(){
        itemNamesForEmail = getItemNamesInEmailFormat()
    }

    func getItemNamesInEmailFormat() -> String{
        //Need the items to be listed in email as text with line after each product name
        var itemNamesString = ""

        for item in cart.getItemNamesInCart() {
            itemNamesString.append("\(item)\n")
        }

        return itemNamesString
    }
    
    func sendEmail(orderID: String, name: String, email: String){
        let smtp = SMTP(
            hostname: "smtp.gmail.com",     // SMTP server address
            email: "petshopemail29@gmail.com",        // username to login
            password: "Test123!"            // password to login
        )

        let htmlConfirmationEmailTemplate = HtmlConfirmationEmailTemplate(numberOfCartItems: cart.itemsInShoppingCart.count, totalPrice: StripeCheckoutViewController.totalCostLabel.text ?? "price unknown", orderNumber: orderID)
        
        let drLight = Mail.User(name: "Pet Store", email: "petstore@gmail.com")
        let customerEmail = Mail.User(name: name, email: email)
        

        let mail = Mail(
            from: drLight,
            to: [customerEmail],
            subject: "Pet shop order.",
            //text: "Thank you for your order \(orderID). The total cost is \(StripeCheckoutViewController.totalCostLabel.text ?? "unknown amount contact store") The <b>items purchased</b> were \(itemNamesForEmail)",
            attachments: [Attachment(htmlContent: htmlConfirmationEmailTemplate.generateEMail())]
        )

        smtp.send(mail) { (error) in
            if let error = error {
                print("The error sending the email is \(error)")
            }
        }
    }
}
