//
//  HtmlConfirmatioEmailTemplate.swift
//  Pet StoreApp
//
//  Created by aidan egan on 27/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

class HtmlConfirmationEmailTemplate {
    
    @ObservedObject var cart = CartStore()
    var numberOfItems : Int
    var totalPriceString = ""
    var orderNumberString = ""
    
    init(numberOfCartItems: Int, totalPrice: String, orderNumber: String){
        numberOfItems = numberOfCartItems
        totalPriceString = totalPrice
        orderNumberString = orderNumber
    }
    
    func generateEMail() -> String {
        
        var htmlEmailStringToReturn = ""
        
        if numberOfItems == 1{
            let htmlEmailStringFor1Item = """
            <!-- #######  YAY, I AM THE SOURCE EDITOR! #########-->
            <h1 style="color: #38c9bb; text-align: left;">Thank you for your order!</h1>
            <h2 style="color: #2e6c80; text-align: left;"><span style="color: #003300;">Order #\(orderNumberString)</span></h2>
            <p>We&rsquo;ll let you know via email once your item(s) have been dispatched (usually 1 to 2 days). <br />Your estimated delivery date will be included in this follow up email.</p>
            <h2 style="color: #38c9bb;">&nbsp;</h2>
            <h2 style="color: #38c9bb;">Order Summary:</h2>
            <table style="height: 143px; width: 457.5px;">
            <tbody>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[0].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[0].productName)</strong></td>
            </tr>
            <tr style="height: 34.1875px;">
            <td style="width: 190px; height: 34.1875px;">
            <h2><strong>Total Cost:</strong></h2>
            </td>
            <td style="width: 252.5px; height: 34.1875px;">
            <h2 style="text-align: left;"><strong>&euro;10.00</strong></h2>
            </td>
            </tr>
            </tbody>
            </table>
            <p>&nbsp;</p>
            <p>Thanks,</p>
            <p>The Pet Store</p>
            <p>Contact us on: 086-98121234</p>
            <p><strong>&nbsp;</strong></p>
            """
            htmlEmailStringToReturn = htmlEmailStringFor1Item
        }
        
        else if numberOfItems == 2{
            let htmlEmailStringFor2Items = """
            <!-- #######  YAY, I AM THE SOURCE EDITOR! #########-->
            <h1 style="color: #38c9bb; text-align: left;">Thank you for your order!</h1>
            <h2 style="color: #2e6c80; text-align: left;"><span style="color: #003300;">Order #\(orderNumberString)</span></h2>
            <p>We&rsquo;ll let you know via email once your item(s) have been dispatched (usually 1 to 2 days). <br />Your estimated delivery date will be included in this follow up email.</p>
            <h2 style="color: #38c9bb;">&nbsp;</h2>
            <h2 style="color: #38c9bb;">Order Summary:</h2>
            <table style="height: 143px; width: 457.5px;">
            <tbody>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[0].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[0].productName)</strong></td>
            </tr>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[1].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[1].productName)</strong></td>
            </tr>
            <tr style="height: 34.1875px;">
            <td style="width: 190px; height: 34.1875px;">
            <h2><strong>Total Cost:</strong></h2>
            </td>
            <td style="width: 252.5px; height: 34.1875px;">
            <h2 style="text-align: left;"><strong>\(totalPriceString)</strong></h2>
            </td>
            </tr>
            </tbody>
            </table>
            <p>&nbsp;</p>
            <p>Thanks,</p>
            <p>The Pet Store</p>
            <p>Contact us on: 086-98121234</p>
            <p><strong>&nbsp;</strong></p>
            """
            htmlEmailStringToReturn = htmlEmailStringFor2Items
        }
        
        else if numberOfItems >= 3{
            let htmlEmailStringFor3Items = """
            <!-- #######  YAY, I AM THE SOURCE EDITOR! #########-->
            <h1 style="color: #38c9bb; text-align: left;">Thank you for your order!</h1>
            <h2 style="color: #2e6c80; text-align: left;"><span style="color: #003300;">Order #\(orderNumberString)</span></h2>
            <p>We&rsquo;ll let you know via email once your item(s) have been dispatched (usually 1 to 2 days). <br />Your estimated delivery date will be included in this follow up email.</p>
            <h2 style="color: #38c9bb;">&nbsp;</h2>
            <h2 style="color: #38c9bb;">Order Summary:</h2>
            <table style="height: 143px; width: 457.5px;">
            <tbody>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[0].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[0].productName)</strong></td>
            </tr>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[1].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[1].productName)</strong></td>
            </tr>
            <tr style="height: 117px;">
            <td style="width: 190px; height: 117px;"><img style="float: left;" src="\(cart.itemsInShoppingCart[2].productImageURLs[0])" alt="interactive connection" width="125" height="117" /></td>
            <td style="width: 252.5px; height: 117px;"><strong>\(cart.itemsInShoppingCart[2].productName)</strong></td>
            </tr>
            <tr style="height: 34.1875px;">
            <td style="width: 190px; height: 34.1875px;">
            <h2>Total Cost:</h2>
            </td>
            <td style="width: 252.5px; height: 34.1875px;">
            <h2 style="text-align: left;">\(totalPriceString)</h2>
            </td>
            </tr>
            </tbody>
            </table>
            <p>&nbsp;</p>
            <p>Thanks,</p>
            <p>The Pet Store</p>
            <p>Contact us on: 086-98121234</p>
            <p><strong>&nbsp;</strong></p>
            """
            htmlEmailStringToReturn = htmlEmailStringFor3Items
            //note only html formats for emails with 3 items purchased if 4 use html for 3
        }
        return htmlEmailStringToReturn
    }
}
