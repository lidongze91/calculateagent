//
//  TexRecord.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct TaxRecord {
    var date: String
    var totalValue: Int
    init() {
        date = "01/01"
        totalValue = 0
    }
    init(date: String, totalValue: Int) {
        self.date = date
        self.totalValue = totalValue
    }
}
