//
//  SignUpScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

struct SignUpScreen{
    
    var name: XCUIElement{
        return TestContainer.app.textFields["SignUpName"]
    }
    
    var email: XCUIElement{
        return TestContainer.app.textFields["SignUpEmail"]
    }
    
    var password: XCUIElement{
        return TestContainer.app.secureTextFields["SignUpPassword"]
    }
    
    var confirmPassword: XCUIElement{
        return TestContainer.app.secureTextFields["SignUpConfirmPassword"]
    }
    
    var signUpButton: XCUIElement{
        return TestContainer.app.buttons["SignUpButton"]
    }
    
}
