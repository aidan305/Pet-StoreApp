//
//  ShippingAddressScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import XCTest

struct ShippingAddressScreen{
    var email: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeEmailIdentifier"]
    }
    
    var name: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeNameIdentifier"]
    }
    
    var address: XCUIElement {
        return TestContainer.app.textFields["ShippingAddressFieldTypeLine1Identifier"]
    }
    
    var apt: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeLine2Identifier"]
    }
    
    var zipCode: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeZipIdentifier"]
    }
    
    var city: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeCityIdentifier"]
    }
    
    var state: XCUIElement{
        return TestContainer.app.textFields["ShippingAddressFieldTypeStateIdentifier"]
    }
    
    var nextButton: XCUIElement{
        return TestContainer.app.buttons["ShippingViewControllerNextButtonIdentifier"]
    }
    
    var doneButton: XCUIElement{
        return TestContainer.app.buttons["ShippingMethodsViewControllerDoneButtonIdentifier"]
    }
}
