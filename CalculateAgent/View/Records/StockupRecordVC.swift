//
//  StockupRecordVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class StockupRecordVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myTable: UITableView = UITableView()
    var records: [StockUpRecord]?
    var button: UIButton!
    var initY = 0
    final let offSetY = 70
    override func viewDidLoad() {
        super.viewDidLoad()
        DeliveryRecordsOps.downloadStock {
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
        let cell = Bundle.main.loadNibNamed("StockupViewCell", owner: self, options: nil)?.first as! StockupViewCell
        cell.date.text = records![indexPath.row].date
        cell.totalNum.text = "进货\(records![indexPath.row].totalNum)套"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

