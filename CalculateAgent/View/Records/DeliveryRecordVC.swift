//
//  DeliveryRecordVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class DeliveryRecordVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTable: UITableView = UITableView()
    var records: [DeliveryRecord]?
    var initY = 0
    final let offSetY = 70
    override func viewDidLoad() {
        super.viewDidLoad()
        DeliveryRecordsOps.downloads {
            records in
            self.records = records
            self.myTable.delegate = self
            self.myTable.dataSource = self
            self.myTable.reloadData()
        }
        myTable.frame = CGRect(x: 0, y: initY, width: Int(view.frame.width),
                               height: Int(view.frame.height))
        self.view.addSubview(myTable)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return records!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("MyTableViewCell", owner: self, options: nil)?.first as! MyTableViewCell
        cell.hospitalLabel.text = records![indexPath.row].hospital
        cell.numOfDeliveryLabel.text = String(records![indexPath.row].totalNum)
        cell.dateLabel.text = records![indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (records![indexPath.row].hospital == "医附院") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "YiFu_VC") as! YiFu_showDeliveryVC
            myVC.data = records![indexPath.row]
            self.navigationController?.pushViewController(myVC, animated: true)
        } else if (records![indexPath.row].hospital == "人民") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "RenMin_VC") as! RenMin_showDeliveryVC
            myVC.data = records![indexPath.row]
            self.navigationController?.pushViewController(myVC, animated: true)
        } else if (records![indexPath.row].hospital == "武警") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "WuJing_VC") as! WuJing_showDeliveryVC
            myVC.data = records![indexPath.row]
            self.navigationController?.pushViewController(myVC, animated: true)
        } else if (records![indexPath.row].hospital == "环湖") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "HuanHu_VC") as! HuanHu_showDeliveryVC
            myVC.data = records![indexPath.row]
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
