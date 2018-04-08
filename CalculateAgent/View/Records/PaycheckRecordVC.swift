//
//  PaycheckRecordVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class PaycheckRecordVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myTable: UITableView = UITableView()
    var records: [PaycheckRecord]?
    var button: UIButton!
    var initY = 0
    final let offSetY = 70
    var animation: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.frame = CGRect(x: 0, y: initY, width: Int(view.frame.width),
                               height: Int(view.frame.height))
        animation = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX-50,
                                                          y: view.frame.midY-50,
                                                          width: 100,
                                                          height: 100),
                                            type: .circleStrokeSpin, color: themeGreen,
                                            padding: 10)
        animation.startAnimating()
        self.view.addSubview(animation)
        DeliveryRecordsOps.downloadPaycheck {
            records in
            self.view.addSubview(self.myTable)
            self.animation.stopAnimating()
            self.records = records
            self.myTable.delegate = self
            self.myTable.dataSource = self
            self.myTable.reloadData()
        }
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
        let cell = Bundle.main.loadNibNamed("PaycheckViewCell", owner: self, options: nil)?.first as! PaycheckViewCell
        cell.date.text = records![indexPath.row].date
        cell.hospital.text = records![indexPath.row].hospital
        cell.totalValue.text = "回款: ¥\(records![indexPath.row].totalValue)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}


