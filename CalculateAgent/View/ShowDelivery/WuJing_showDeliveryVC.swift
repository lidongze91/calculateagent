//
//  WuJing_showDeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class WuJing_showDeliveryVC: UIViewController {
    var data: DeliveryRecord = DeliveryRecord()
    var titleLabel: UILabel!
    var zone6Label: UILabel!
    var zone9Label: UILabel!
    var zone16Label: UILabel!
    // all the fields
    var zone6Field: UILabel!
    var zone9Field: UILabel!
    var zone16Field: UILabel!
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
        zone6Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone6Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone6Label)
        self.view.addSubview(zone6Field)
        initY += offset
        initY += offset
        initY += offset
        zone9Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone9Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone9Label)
        self.view.addSubview(zone9Field)
        initY += offset
        initY += offset
        initY += offset
        zone16Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone16Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone16Label)
        self.view.addSubview(zone16Field)
        showDetails(record: self.data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // assign numbers to the labels
    func showDetails(record: DeliveryRecord) -> Void{
        titleLabel.text = "\(record.date)  \(record.hospital)送货记录📝"
        zone6Label.text = "六楼病区"
        zone9Label.text = "九楼病区"
        zone16Label.text = "十六楼病区"
        for item in record.list {
            switch item.key {
            case "六楼病区": zone6Field.text = "\(item.value)套"; break
            case "九楼病区": zone9Field.text = "\(item.value)套"; break
            case "十六楼病区": zone16Field.text = "\(item.value)套"; break
            default: break
            }
        }
    }
}


