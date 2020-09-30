//
//  Product.swift
//  Pet StoreApp
//
//  Created by aidan egan on 23/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI



struct Product: Hashable {

    var category: ProductCategory
    var productName: String
    var productDescription: String
    var productPrice: Double
    var flashText: String? 
    var productImageURLs: [URL]
    var id: UUID
    var customerQuantity = 0
    var isFavourite: Bool
}

struct ProductCategory: Hashable {
    var categortyName: String
    var image: Image?
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

