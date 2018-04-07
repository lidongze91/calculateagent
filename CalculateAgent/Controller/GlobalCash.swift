//
//  GlobalCash.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
import Parse
class GlobalCash {
    fileprivate let queue =
        DispatchQueue(
            label: "com.calculateAgent.queue", // 1
            attributes: .concurrent)
    var remainCash: Int
    static let shared = GlobalCash()
    typealias cash = (Int)->()
    init() {
        remainCash = 0
    }
    // fetch the global variables from the parse server
    func fetch(completion: @escaping cash) {
        let query = PFQuery(className: "GlobalCash")
        query.getFirstObjectInBackground() {
            (object: PFObject?, error: Error?) -> Void in
            if object == nil {
                self.createNewGlobalCash() {
                    num in
                    completion(num)
                }
            }
            else {
                if error != nil {
                    print("fetch error: \(error.debugDescription)")
                } else if let object = object {
                    let res: Int = object["numOfRemainingCash"] as! Int
                    completion(res)
                }
            }
        }
    }
    func update(remainCash: Int) {
        let query = PFQuery(className:"GlobalCash")
        query.getFirstObjectInBackground {
            (object: PFObject?, error: Error?) -> Void in
            if error != nil {
                print("update error \(error.debugDescription)")
            } else if let object = object {
                object["numOfRemainingCash"] = remainCash
                object.saveInBackground()
            }
        }
    }
    private func createNewGlobalCash(completion: @escaping cash) {
        let record = PFObject(className: "GlobalCash")
        record["numOfRemainingCash"] = 0
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
            self.fetch() { cashNum in
                self.remainCash = cashNum + num
                self.update(remainCash: self.remainCash)
            }
        }
    }
    func goingOut(num: Int) {
        queue.async(flags: .barrier) {
            self.fetch() { cashNum in
                self.remainCash = cashNum - num
                self.update(remainCash: self.remainCash)
            }
        }
    }
    func updateRemainNum(label: UILabel) {
        self.fetch() { cashNum in
            self.remainCash = cashNum
            label.text = "资金余额：¥\(self.remainCash)"
        }
    }
}
