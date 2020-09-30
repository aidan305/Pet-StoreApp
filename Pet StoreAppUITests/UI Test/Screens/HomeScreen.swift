//
//  ShopScreen.swift
//  Pet StoreAppUITests
//
//  Created by aidan egan on 21/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import XCTest

struct HomeScreen{
    
    var dogCategory: XCUIElement{
        return TestContainer.app.tables/*@START_MENU_TOKEN@*/.images["dog image"]/*[[".cells.images[\"dog image\"]",".images[\"dog image\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }
    
    var profileTab: XCUIElement{
        return TestContainer.app.tabBars.buttons["Profile"]
    }
}
