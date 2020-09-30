//
//  Pet_StoreAppTests.swift
//  Pet StoreAppTests
//
//  Created by aidan egan on 22/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//
//Note: These tests are designed to be run altogether one after another

import XCTest
import SwiftUI
@testable import Pet_StoreApp

class Pet_StoreAppTests: XCTestCase {

    @ObservedObject var cart = CartStore()
    
    private let productOne : Product = Product(category: ProductCategory(categortyName: "test category", image: nil, id: UUID()), productName: "Dog Lead", productDescription: "test decription", productPrice: 22.50, flashText: nil, productImageURLs: [URL(fileURLWithPath: "test")], id: UUID(), customerQuantity: 1, isFavourite: false)
    
    private let productTwo : Product = Product(category: ProductCategory(categortyName: "test category", image: nil, id: UUID()), productName: "Dog Lead", productDescription: "test decription", productPrice: 30.50, flashText: nil, productImageURLs: [URL(fileURLWithPath: "test")], id: UUID(), customerQuantity: 1, isFavourite: false)
    

    
    func testTotalCost(){
        cart.itemsInShoppingCart = [productOne, productTwo]
        XCTAssertEqual(cart.calculateTotalCost(), productOne.productPrice + productTwo.productPrice)
    }
    
    func testRemovingProductFromCart(){
        cart.removeItemFromShoppingCart(itemToRemove: productOne)
        cart.removeItemFromShoppingCart(itemToRemove: productTwo)
        XCTAssertFalse(cart.itemsInShoppingCart.contains(productOne))
        XCTAssertFalse(cart.itemsInShoppingCart.contains(productTwo))
    }
}
