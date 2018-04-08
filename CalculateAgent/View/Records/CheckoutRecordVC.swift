//
//  CheckoutRecordVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class CheckoutRecordVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTable: UITableView = UITableView()
    var records: [CheckoutRecord]?
    var cashNums: [Int] = []
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
        DeliveryRecordsOps.downloadCheckout {
            records in
            self.view.addSubview(self.myTable)
            self.animation.stopAnimating()
            self.records = records
            self.loadCashNums()
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
        let cell = Bundle.main.loadNibNamed("CheckoutViewCell", owner: self, options: nil)?.first as! CheckoutViewCell
        cell.hospital.text = records![indexPath.row].hospital
        cell.cash.text = "¥\(cashNums[indexPath.row])"
        cell.date.text = records![indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (records![indexPath.row].hospital == "医附院") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "YiFu_checkoutVC") as! YiFu_checkoutVC
            myVC.showRecord = records![indexPath.row]
            myVC.showPage = true
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        else if (records![indexPath.row].hospital == "人民") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "RenMin_checkoutVC") as! RenMin_checkoutVC
            myVC.showRecord = records![indexPath.row]
            myVC.showPage = true
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        else if (records![indexPath.row].hospital == "武警") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "WuJing_checkoutVC") as! WuJing_checkoutVC
            myVC.showRecord = records![indexPath.row]
            myVC.showPage = true
            self.navigationController?.pushViewController(myVC, animated: true)
        } else if (records![indexPath.row].hospital == "环湖") {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "HuanHu_checkoutVC") as! HuanHu_checkoutVC
            myVC.showRecord = records![indexPath.row]
            myVC.showPage = true
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func loadCashNums() {
        for item in records! {
            var totalNum = 0
            for num in item.totalCheckoutCash {
                totalNum += num.value
            }
            cashNums.append(totalNum)
        }
    }
    
}

