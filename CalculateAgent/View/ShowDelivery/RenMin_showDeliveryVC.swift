//
//  RenMin_showDeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class RenMin_showDeliveryVC: UIViewController {
    var data: DeliveryRecord = DeliveryRecord()
    var titleLabel: UILabel!
    var zone1Label: UILabel!
    var zone2Label: UILabel!
    var zone3Label: UILabel!
    // all the fields
    var zone1Field: UILabel!
    var zone2Field: UILabel!
    var zone3Field: UILabel!
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
        zone1Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone1Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone1Label)
        self.view.addSubview(zone1Field)
        initY += offset
        initY += offset
        initY += offset
        zone2Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone2Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        initY += offset
        initY += offset
        initY += offset
        zone3Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone3Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone3Label)
        self.view.addSubview(zone3Field)
        showDetails(record: self.data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // assign numbers to the labels
    func showDetails(record: DeliveryRecord) -> Void{
        titleLabel.text = "\(record.date)  \(record.hospital)送货记录📝"
        zone1Label.text = "脑外"
        zone2Label.text = "脑内一"
        zone3Label.text = "脑内二"
        for item in record.list {
            switch item.key {
            case "脑外": zone1Field.text = "\(item.value)套"; break
            case "脑内一": zone2Field.text = "\(item.value)套"; break
            case "脑内二": zone3Field.text = "\(item.value)套"; break
            default: break
            }
        }
    }
}
