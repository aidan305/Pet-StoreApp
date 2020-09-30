//
//  Utils.swift
//  Pet StoreApp
//
//  Created by aidan egan on 12/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

class Utils {
    
func generateOrderNumber() -> Int {
       let randomInt = Int.random(in: 100000..<1000000)
       return randomInt
   }
}

extension UITextField {
    
func cornerRadius(value: CGFloat) {
    self.layer.cornerRadius = value
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.masksToBounds = true
}}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
