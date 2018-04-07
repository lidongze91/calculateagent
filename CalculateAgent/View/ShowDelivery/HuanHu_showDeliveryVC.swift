//
//  HuanHu_showDeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class HuanHu_showDeliveryVC: UIViewController {
    var data: DeliveryRecord = DeliveryRecord()
    var titleLabel: UILabel!
    var zone5Label: UILabel!
    var zone2Label: UILabel!
    // all the fields
    var zone2Field: UILabel!
    var zone5Field: UILabel!
    var initY = 100
    let offset = 40
    let smallOffset = 25
    let gap = 300
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel = UILabel(frame:CGRect(x: 20, y: initY, width: 320, height: 20))
        self.view.addSubview(titleLabel)
        initY += offset
        initY += smallOffset
        zone2Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone2Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        initY += offset
        initY += offset
        initY += offset
        zone5Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone5Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone5Label)
        self.view.addSubview(zone5Field)
        showDetails(record: self.data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // assign numbers to the labels
    func showDetails(record: DeliveryRecord) -> Void{
        titleLabel.text = "\(record.date)  \(record.hospital)送货记录📝"
        zone2Label.text = "二病区"
        zone5Label.text = "五病区"
        for item in record.list {
            switch item.key {
            case "二病区": zone2Field.text = "\(item.value)套"; break
            case "五病区": zone5Field.text = "\(item.value)套"; break
            default: break
            }
        }
    }
}

