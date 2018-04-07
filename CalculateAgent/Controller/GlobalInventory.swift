//
//  Inventory.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
import Parse
class GlobalInventory {
    fileprivate let queue =
        DispatchQueue(
            label: "com.calculateAgent.queue", // 1
            attributes: .concurrent)
    var remainNum: Int
    static let shared = GlobalInventory()
    typealias inventory = (Int)->()
    init() {
        remainNum = 0
    }
    // fetch the global variables from the parse server
    func fetch(completion: @escaping inventory) {
        let query = PFQuery(className: "GlobalInventory")
        query.getFirstObjectInBackground() {
            (object: PFObject?, error: Error?) -> Void in
            if object == nil {
                self.createNewGlobalInventory() {
                    num in
                    completion(num)
                }
            }
            else {
                if error != nil {
                    print("fetch error: \(error.debugDescription)")
                } else if let object = object {
                    let res: Int = object["numOfRemainingPackage"] as! Int
                    completion(res)
                }
            }
        }
    }
    func update(remainNum: Int) {
        let query = PFQuery(className:"GlobalInventory")
        query.getFirstObjectInBackground {
            (object: PFObject?, error: Error?) -> Void in
            if error != nil {
                print("update error \(error.debugDescription)")
            } else if let object = object {
                object["numOfRemainingPackage"] = remainNum
                object.saveInBackground()
            }
        }
    }
    private func createNewGlobalInventory(completion: @escaping inventory) {
        let record = PFObject(className: "GlobalInventory")
        record["numOfRemainingPackage"] = 0
        record.saveInBackground {(success: Bool, error: Error?) in
            if (success) {
                completion(0)
                print ("saved to parse server successfully!")
            } else {
                print ("upload data failed")
            }
            
        }
    }
    func goingIn(num: Int) {
        queue.async(flags: .barrier) {
            self.fetch() { inventoryNum in
                self.remainNum = inventoryNum + num
                self.update(remainNum: self.remainNum)
            }
        }
    }
    func goingOut(num: Int) {
        queue.async(flags: .barrier) {
            self.fetch() { inventoryNum in
                self.remainNum = inventoryNum - num
                self.update(remainNum: self.remainNum)
            }
        }
    }
    func updateRemainNum(label: UILabel) {
        self.fetch() { inventoryNum in
            self.remainNum = inventoryNum
            label.text = "库存剩余:  \(self.remainNum)套"
        }
    }
}
