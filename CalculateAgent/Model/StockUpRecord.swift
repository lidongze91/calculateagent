//
//  BuyInRecord.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/30/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct StockUpRecord {
    var date: String
    var totalNum: Int
    init() {
        date = "01/01"
        totalNum = 0
    }
    init(date: String, totalNum: Int) {
        self.date = date
        self.totalNum = totalNum
    }
}
