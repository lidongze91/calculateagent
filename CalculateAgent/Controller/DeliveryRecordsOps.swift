//
//  UploadRecords.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
import Parse
final class DeliveryRecordsOps {
    typealias parseData = ([DeliveryRecord]) -> ()
    typealias parseCheckoutData = ([CheckoutRecord]) -> ()
    typealias parseStockData = ([StockUpRecord]) -> ()
    typealias parsePaycheckData = ([PaycheckRecord]) -> ()
    typealias statusReport = (Bool)->()
    /************************** 送货记录 Record Operations *******************************/
    // 1. upload delivery record
    static func uploads(deliveryRecord: DeliveryRecord,
                        completion: @escaping statusReport) {
        let record = PFObject(className: "DeliveryRecord")
        let date:String = deliveryRecord.date
        let hospital:String = deliveryRecord.hospital
        let list: [String:Int] = deliveryRecord.list
        record["date"] = date
        record["hospital"] = hospital
        record["list"] = list
        let g = GlobalInventory.shared
        g.goingOut(num: deliveryRecord.totalNum)
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    // 2. download delivery record
    static func downloads(completion: @escaping parseData){
        let query = PFQuery(className: "DeliveryRecord")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("fetch error: \(error.debugDescription)")
            } else if let objects = objects {
                var records: [DeliveryRecord] = []
                for object in objects {
                    let record = DeliveryRecord(date: object["date"] as! String,
                                            hospital: object["hospital"] as! String,
                                            list: object["list"] as! [String:Int])
                    records.append(record)
                }
                completion(records)
            }
        })
    }
    // 3. download delivery records within a range like a month or a year
    static func getPeriodRecords(hospital: String, period: String,
                                 completion: @escaping parseData) {
        let predicate = NSPredicate(format:"hospital == '\(hospital)'")
        let query = PFQuery(className: "DeliveryRecord", predicate: predicate)
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("fetch error: \(error.debugDescription)")
            } else if let objects = objects {
                var records: [DeliveryRecord] = []
                for object in objects {
                    let record = DeliveryRecord(date: object["date"] as! String,
                                                hospital: object["hospital"] as! String,
                                                list: object["list"] as! [String:Int])
                    if (inRange(period: period, recordDate: record.date)) {
                        records.append(record)
                    }
                }
                completion(records)
            }
        })
    }
    // 4. helper function for choosing records within range
    static func inRange(period: String, recordDate: String) -> Bool{
        let date = Date()
        let calendar = Calendar.current
        let year: Int = calendar.component(.year, from: date)
        let month: Int = calendar.component(.month, from: date)
        let strArray = recordDate.components(separatedBy: " / ")
        let recordYear: Int = Int(strArray[0])!
        let recordMonth: Int = Int(strArray[1])!
        if (period == "month") {
            return (recordMonth == month && recordYear == year)
        } else {
            return recordYear == year
        }
    }
    /*********************** 结账记录 records Operations ***********************************/
    static func uploadCheckout(checkoutRecord: CheckoutRecord,
                               completion: @escaping statusReport) {
        let record = PFObject(className: "CheckoutRecord")
        let date:String = checkoutRecord.date
        let hospital:String = checkoutRecord.hospital
        let list1: [String:Int] = checkoutRecord.totalDeliveryNums
        let list2: [String:Int] = checkoutRecord.totalCheckoutNums
        let list3: [String:Int] = checkoutRecord.totalCheckoutCash
        record["date"] = date
        record["hospital"] = hospital
        record["totalDeliveryNums"] = list1
        record["totalCheckoutNums"] = list2
        record["totalCheckoutCash"] = list3
        let g = GlobalCash.shared
        g.goingOut(num: checkoutRecord.totalValue)
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    static func downloadCheckout(completion: @escaping parseCheckoutData) {
        let query = PFQuery(className: "CheckoutRecord")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("fetch error: \(error.debugDescription)")
            } else if let objects = objects {
                var records: [CheckoutRecord] = []
                for object in objects {
                    let record = CheckoutRecord(date: object["date"] as! String,
                                                hospital: object["hospital"] as! String,
                                                totalDeliveryNums: object["totalDeliveryNums"] as! [String:Int],
                                                totalCheckoutNums: object["totalCheckoutNums"] as! [String:Int],
                                                totalCheckoutCash: object["totalCheckoutCash"] as! [String:Int])
                    records.append(record)
                }
                completion(records)
            }
        })
    }
    /*********************** 进货记录 Operations **********************************************/
    static func uploadStock(stockupRecord: StockUpRecord,
                            completion: @escaping statusReport) {
        let record = PFObject(className: "StockUpRecord")
        let date:String = stockupRecord.date
        let totalNum: Int = stockupRecord.totalNum
        record["date"] = date
        record["totalNum"] = totalNum
        let inventory = GlobalInventory.shared
        inventory.goingIn(num: totalNum)
        let cash = GlobalCash.shared
        cash.goingOut(num: 25*totalNum)
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    static func downloadStock(completion: @escaping parseStockData) {
        let query = PFQuery(className: "StockUpRecord")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("fetch error: \(error.debugDescription)")
            } else if let objects = objects {
                var records: [StockUpRecord] = []
                for object in objects {
                    let record = StockUpRecord(date: object["date"] as! String,
                                               totalNum: object["totalNum"] as! Int)
                    records.append(record)
                }
                completion(records)
            }
        })
    }
    /**************************** 回款记录 Operations **************************************/
    static func uploadPaycheck(paycheck: PaycheckRecord,
                               completion: @escaping statusReport) {
        let record = PFObject(className: "PaycheckRecord")
        let date:String = paycheck.date
        let hospital: String = paycheck.hospital
        let totalValue: Int = paycheck.totalValue
        record["date"] = date
        record["hospital"] = hospital
        record["totalValue"] = totalValue
        let g = GlobalCash.shared
        g.goingIn(num: totalValue)
        // to-do: going in cash flow
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    static func downloadPaycheck(completion: @escaping parsePaycheckData) {
        let query = PFQuery(className: "PaycheckRecord")
        query.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("fetch error: \(error.debugDescription)")
            } else if let objects = objects {
                var records: [PaycheckRecord] = []
                for object in objects {
                    let record = PaycheckRecord(date: object["date"] as! String,
                                                hospital: object["hospital"] as! String,
                                                totalValue: object["totalValue"] as! Int)
                    records.append(record)
                }
                completion(records)
            }
        })
    }
    /************************** 税款记录 Operations **************************************/
    static func uploadTax(taxRecord: TaxRecord, completion: @escaping statusReport) {
        let record = PFObject(className: "TaxRecord")
        let date:String = taxRecord.date
        let totalValue: Int = taxRecord.totalValue
        record["date"] = date
        record["totalValue"] = totalValue
        let g = GlobalCash.shared
        g.goingOut(num: totalValue)
        // to-do: going out cash flow
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
