//
//  ProductDetailsScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

struct ProductDetailsScreen{
    var addToCart: XCUIElement{
        return TestContainer.app.buttons["Add To Cart"]
    }
}
