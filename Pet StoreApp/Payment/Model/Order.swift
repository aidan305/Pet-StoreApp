//
//  Order.swift
//  Pet StoreApp
//
//  Created by aidan egan on 12/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct Order: Hashable{
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id && lhs.products == rhs.products
    }
    
    var id: Int
    var products: [SpecificOrderDetails]
}

struct SpecificOrderDetails: Hashable {
    var productName: String
    var productQuantity: Int
}
