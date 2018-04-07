//
//  PaycheckRecord.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct PaycheckRecord {
    var date: String
    var hospital: String
    var totalValue: Int
    init() {
        date = "01/01"
        hospital = "医附院"
        totalValue = 0
    }
    init(date: String, hospital: String, totalValue: Int) {
        self.date = date
        self.hospital = hospital
        self.totalValue = totalValue
    }
}
