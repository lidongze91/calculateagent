//
//  Item.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/30/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct Item {
    var name: String
    var SKU: String
    var expiraionDate: String
    init(name: String, SKU: String, expirationDate: String) {
        self.name = name
        self.SKU = SKU
        self.expiraionDate = expirationDate
    }
}
