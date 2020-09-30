//
//  Array.swift
//  Pet StoreApp
//
//  Created by aidan egan on 25/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
