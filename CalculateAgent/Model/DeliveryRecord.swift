//
//  DeliveryRecord.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
struct DeliveryRecord {
    var date: String
    var hospital: String
    var list: [String:Int]
    var totalNum: Int
    init() {
        date = "01/01"
        hospital = "医附院"
        list = [String:Int]()
        totalNum = 0
    }
    init(date: String, hospital: String, list: [String:Int]) {
        self.date = date
        self.hospital = hospital
        var num = 0
        for item in list {
            num += item.value
        }
        self.totalNum = num
        self.list = list
    }
}
