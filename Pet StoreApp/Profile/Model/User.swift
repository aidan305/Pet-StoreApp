//
//  User.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct User {
    var uid: String
    var email: String?
    var name: String?
    var newUser: Bool?
    var orders: [Order]?
}
