//
//  ProductListScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

struct ProductListScreen{
    var dogLead: XCUIElement{
        return TestContainer.app.buttons["Dog Lead\n€12.00"]
    }
}
