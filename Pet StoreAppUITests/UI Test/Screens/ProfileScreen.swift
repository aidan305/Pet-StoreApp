//
//  ProfileScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 22/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

struct Profile{
    var signOutButton: XCUIElement {
        return TestContainer.app.buttons["Sign Out"]
    }
}
