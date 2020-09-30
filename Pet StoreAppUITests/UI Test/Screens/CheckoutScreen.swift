//
//  CheckoutScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import XCTest

struct CheckoutScreen{
    
    var selectAddressButton: XCUIElement{
        return TestContainer.app.buttons["Select address"]
    }
    
    var cardHolderName: XCUIElement{
        return TestContainer.app.textFields["CardHolder Name"]
    }
    
    var cardNumber: XCUIElement{
        return TestContainer.app.textFields["card number"]
    }

    var submitPaymentButton: XCUIElement{
        return TestContainer.app.buttons["Submit payment"]
    }
}
