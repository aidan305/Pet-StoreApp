//
//  Pet_StoreAppUITests.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 09/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

class Pet_StoreAppUITests: XCTestCase {

    func testPerformAPurchase() {
        XCUIApplication().activate()
        let app = XCUIApplication()
        
        XCTContext.runActivity(named: "process an order end to end for the purchase of a dog lead item") { _ in
            sleep(5)
            let shopScreen = HomeScreen()
            let productListScreen = ProductListScreen()
            let shippingAddressScreen = ShippingAddressScreen()
            let checkoutCartScreen = CheckoutScreen()
            let productDetailsScreen = ProductDetailsScreen()
            
            //Selecting product step
            shopScreen.dogCategory.tap()
            productListScreen.dogLead.waitForExistence(timeout: 15)
            productListScreen.dogLead.tap()
            productDetailsScreen.addToCart.waitForExistence(timeout: 15)
            productDetailsScreen.addToCart.tap()
            
            //Shipping step
            checkoutCartScreen.selectAddressButton.tap()
            shippingAddressScreen.email.typeText("eganjessie@hotmail.com")
            shippingAddressScreen.name.tap()
            shippingAddressScreen.name.typeText("aidan")
            shippingAddressScreen.address.tap()
            shippingAddressScreen.address.typeText("cowper")
            shippingAddressScreen.apt.tap()
            shippingAddressScreen.apt.typeText("100")
            shippingAddressScreen.zipCode.tap()
            shippingAddressScreen.zipCode.typeText("12345")
            shippingAddressScreen.city.tap()
            shippingAddressScreen.city.typeText("Schenectady\n")
            //shippingAddressScreen.state.tap()
            //shippingAddressScreen.state.typeText("NY")
            shippingAddressScreen.nextButton.tap()
            shippingAddressScreen.doneButton.waitForExistence(timeout: 15)
            shippingAddressScreen.doneButton.tap()
            
            //Payment step
            checkoutCartScreen.cardHolderName.tap()
            checkoutCartScreen.cardHolderName.typeText("Aidan Egan")
            checkoutCartScreen.cardNumber.tap()
            checkoutCartScreen.cardNumber.typeText("4242424242424242042112312345\n")
            checkoutCartScreen.submitPaymentButton.waitForExistence(timeout: 15)
            checkoutCartScreen.submitPaymentButton.tap()
            
            let orderSummaryLabel = app.staticTexts["Order No"]
            XCTAssertTrue(orderSummaryLabel.waitForExistence(timeout: 15))
        }
    }

    func testCreateAccount(){
        XCUIApplication().activate()
        
        XCTContext.runActivity(named: "Create a new account and confirm the user is signed in") { _ in
            sleep(5)
            let tabs = HomeScreen()
            let signUpScreen = SignUpScreen()
            let profile = Profile()
            
            tabs.profileTab.tap()
            signUpScreen.name.tap()
            signUpScreen.name.typeText("tester")
            signUpScreen.email.tap()
            signUpScreen.email.typeText("testPetStore@mail\(Int.random(in: 1..<10000)).com")
            signUpScreen.password.tap()
            signUpScreen.password.typeText("Password1")
            signUpScreen.confirmPassword.tap()
            signUpScreen.confirmPassword.typeText("Password1\n")
            signUpScreen.signUpButton.tap()
            tabs.profileTab.waitForExistence(timeout: 10)
            tabs.profileTab.tap()
            
            XCTAssertTrue(profile.signOutButton.exists)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
