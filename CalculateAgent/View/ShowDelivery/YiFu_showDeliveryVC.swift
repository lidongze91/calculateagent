//
//  YiFu_showDeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/30/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
class YiFu_showDeliveryVC: UIViewController {
    var data: DeliveryRecord = DeliveryRecord()
    var titleLabel: UILabel!
    var northCampusLabel: UILabel!
    var southCampusLabel: UILabel!
    var zone2Label: UILabel!
    var zone3Label: UILabel!
    var zone4Label: UILabel!
    var zone5Label: UILabel!
    var zone6Label: UILabel!
    var zone7Label: UILabel!
    var zone8Label: UILabel!
    var zone1Label: UILabel!
    var zone9Label: UILabel!
    var zone10Label: UILabel!
    var zone11Label: UILabel!
    // all the fields
    var zone2Field: UILabel!
    var zone3Field: UILabel!
    var zone4Field: UILabel!
    var zone5Field: UILabel!
    var zone6Field: UILabel!
    var zone7Field: UILabel!
    var zone8Field: UILabel!
    var zone1Field: UILabel!
    var zone9Field: UILabel!
    var zone10Field: UILabel!
    var zone11Field: UILabel!
    var initY = 100
    let offset = 40
    let smallOffset = 25
    let gap = 300
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel = UILabel(frame:CGRect(x: 20, y: initY, width: 320, height: 20))
        self.view.addSubview(titleLabel)
        initY += offset
        northCampusLabel = UILabel(frame:CGRect(x: 20, y: initY,
                                                width: 200, height: 20))
        self.view.addSubview(northCampusLabel)
        initY += smallOffset
        zone2Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone2Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        initY += offset
        zone3Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone3Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone3Label)
        self.view.addSubview(zone3Field)
        initY += offset
        zone4Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        self.view.addSubview(zone4Label)
        zone4Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone4Field)
        initY += offset
        zone5Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone5Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone5Label)
        self.view.addSubview(zone5Field)
        initY += offset
        zone6Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone6Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone6Label)
        self.view.addSubview(zone6Field)
        initY += offset
        zone7Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone7Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone7Label)
        self.view.addSubview(zone7Field)
        initY += offset
        zone8Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone8Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone8Label)
        self.view.addSubview(zone8Field)
        initY += 70
        southCampusLabel = UILabel(frame: CGRect(x: 20, y: initY,
                                                 width: 200, height: 20))
        self.view.addSubview(southCampusLabel)
        initY += smallOffset
        zone1Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone1Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone1Label)
        self.view.addSubview(zone1Field)
        initY += offset
        zone9Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone9Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone9Label)
        self.view.addSubview(zone9Field)
        initY += offset
        zone10Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone10Field = UILabel(frame: CGRect(x: gap, y: initY,
                                            width: 100, height: 20))
        self.view.addSubview(zone10Label)
        self.view.addSubview(zone10Field)
        initY += offset
        zone11Label = UILabel(frame: CGRect(x: 30, y: initY, width: 100, height: 20))
        zone11Field = UILabel(frame: CGRect(x: gap, y: initY, width: 100, height: 20))
        self.view.addSubview(zone11Label)
        self.view.addSubview(zone11Field)
        showDetails(record: self.data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // assign numbers to the labels
    func showDetails(record: DeliveryRecord) -> Void{
        titleLabel.text = "\(record.date)  \(record.hospital)送货记录📝"
        northCampusLabel.text = "北院"
        southCampusLabel.text = "南院"
        zone1Label.text = "一病区"
        zone2Label.text = "二病区"
        zone3Label.text = "三病区"
        zone4Label.text = "四病区"
        zone5Label.text = "五病区"
        zone6Label.text = "六病区"
        zone7Label.text = "七病区"
        zone8Label.text = "八病区"
        zone9Label.text = "九病区"
        zone10Label.text = "十病区"
        zone11Label.text = "十一病区"
        for item in record.list {
            switch item.key {
            case "一病区": zone1Field.text = "\(item.value)套"; break
            case "二病区": zone2Field.text = "\(item.value)套"; break
            case "三病区": zone3Field.text = "\(item.value)套"; break
            case "四病区": zone4Field.text = "\(item.value)套"; break
            case "五病区": zone5Field.text = "\(item.value)套"; break
            case "六病区": zone6Field.text = "\(item.value)套"; break
            case "七病区": zone7Field.text = "\(item.value)套"; break
            case "八病区": zone8Field.text = "\(item.value)套"; break
            case "九病区": zone9Field.text = "\(item.value)套"; break
            case "十病区": zone10Field.text = "\(item.value)套"; break
            case "十一病区": zone11Field.text = "\(item.value)套"; break
            default: break
            }
        }
    }
}
