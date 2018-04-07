//
//  CheckoutRecord.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct CheckoutRecord {
    var date: String
    var hospital: String
    var totalDeliveryNums: [String:Int]
    var totalCheckoutNums: [String:Int]
    var totalCheckoutCash: [String:Int]
    var totalValue: Int
    init() {
        date = "01/01"
        hospital = "医附院"
        totalDeliveryNums = [String:Int]()
        totalCheckoutNums = [String:Int]()
        totalCheckoutCash = [String:Int]()
        totalValue = 0
    }
    init(date: String, hospital: String,
         totalDeliveryNums: [String:Int], totalCheckoutNums: [String:Int],
         totalCheckoutCash: [String:Int]) {
        self.date = date
        self.hospital = hospital
        self.totalDeliveryNums = totalDeliveryNums
        self.totalCheckoutNums = totalCheckoutNums
        self.totalCheckoutCash = totalCheckoutCash
        var temp = 0
        for item in totalCheckoutCash {
            temp += item.value
        }
        self.totalValue = temp
    }
}
