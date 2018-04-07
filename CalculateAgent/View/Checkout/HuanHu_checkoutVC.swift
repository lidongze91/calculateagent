//
//  HuanHu_checkoutVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class HuanHu_checkoutVC: UIViewController, UITextFieldDelegate {
    // things for show page
    var showPage: Bool = false
    var editable: Bool = true
    var showRecord: CheckoutRecord?
    
    var records: [DeliveryRecord]?
    var totalNum: [Int] = [0,0]
    var activeTextField: UITextField?
    var zone2Label: UILabel!
    var zone5Label: UILabel!
    // all the fields
    var zone2Field: UILabel!
    var zone5Field: UILabel!
    
    var zone2Num: AkiraTextField!
    var zone5Num: AkiraTextField!
    
    var zone2Cash: AkiraTextField!
    var zone5Cash: AkiraTextField!
    var button: UIButton!
    var initY = 150
    let offset = 45
    let smallOffset = 25
    let gap = 300
    let boxHeight = 53
    override func viewDidLoad() {
        super.viewDidLoad()
        if (showPage) {
            editable = false
        } else {
            editable = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(HuanHu_checkoutVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HuanHu_checkoutVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(HuanHu_checkoutVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        zone2Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone2Label.adjustsFontSizeToFitWidth = true
        zone2Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone2Label.adjustsFontSizeToFitWidth = true
        zone2Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone2Num.delegate = self
        zone2Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone2Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone2Num, str: "结账套数", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone2Cash, str: "结账金额(¥)", editable:editable)
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        self.view.addSubview(zone2Num)
        self.view.addSubview(zone2Cash)
        initY += offset
        initY += offset
        // zone 5
        zone5Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone5Label.adjustsFontSizeToFitWidth = true
        zone5Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone5Label.adjustsFontSizeToFitWidth = true
        zone5Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone5Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone5Num.delegate = self
        zone5Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone5Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone5Cash, str: "", editable:editable)
        self.view.addSubview(zone5Label)
        self.view.addSubview(zone5Field)
        self.view.addSubview(zone5Num)
        self.view.addSubview(zone5Cash)
        // confirm button
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(HuanHu_checkoutVC.on_click(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: button, str: "确定")
        if (showPage) {
            showPageDetails()
        } else {
            DeliveryRecordsOps.getPeriodRecords(hospital: "环湖",
                                                period: "month"){
                                                    records in
                                                    self.records = records
                                                    self.showDetails(records: self.records!)
            }
            self.view.addSubview(button)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // assign numbers to the labels
    func showDetails(records: [DeliveryRecord]) -> Void{
        zone2Label.text = "二病区"
        zone5Label.text = "五病区"
        totalNum = [0,0]
        for record in records {
            for item in record.list {
                switch item.key {
                case "二病区": totalNum[0] += item.value; break
                case "五病区": totalNum[1] += item.value; break
                default: break
                }
            }
        }
        zone2Field.text = "\(totalNum[0])套"
        zone5Field.text = "\(totalNum[1])套"
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let activeTextField = self.activeTextField {
            let diff = self.view.frame.height - activeTextField.frame.maxY
            print(self.view.frame.height)
            print(activeTextField.frame.maxY)
            if diff <= 291 {
                self.view.frame.origin.y -= 233
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y < 0{
            self.view.frame.origin.y += 233
        }
    }
    @objc func hideKeyboardTap(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        activeTextField = nil
    }
    @objc func on_click(_ sender: Any) {
        if (zone2Num.text!.isEmpty || zone2Cash.text!.isEmpty ||
            zone5Num.text!.isEmpty || zone5Cash.text!.isEmpty) {
            let alert = UIAlertController(title: "错误",
                                          message: "请填写所有结款数目及结款金额", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let list1: [String:Int] = [zone2Label.text!:totalNum[0],
                                   zone5Label.text!:totalNum[1]]
        let list2: [String:Int] = [zone2Label.text!:Int(zone2Num.text!)!,
                                   zone5Label.text!:Int(zone5Num.text!)!]
        let list3: [String:Int] = [zone2Label.text!:Int(zone2Cash.text!)!,
                                   zone5Label.text!:Int(zone5Cash.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = "环湖"
        let checkoutRecord = CheckoutRecord(date: formattedDate, hospital: hospital, totalDeliveryNums: list1, totalCheckoutNums: list2, totalCheckoutCash: list3)
        DeliveryRecordsOps.uploadCheckout(checkoutRecord: checkoutRecord) {
            status in
            if (status) {
                let alert = UIAlertController(title: "上传成功✅",
                                              message: "已上传所有数据和金额", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: {
                    action in
                    self.navigationController?.popToRootViewController(animated: false)
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "错误❌",
                                              message: "数据传输失败，请稍后重试", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: {
                    action in
                    self.navigationController?.popToRootViewController(animated: false)
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func showPageDetails () {
        zone2Label.text = "二病区"
        zone5Label.text = "五病区"
        if let checkoutRecord = showRecord {
            for item in checkoutRecord.totalDeliveryNums {
                switch item.key {
                case "二病区": zone2Field.text = "\(item.value)套"; break
                case "五病区": zone5Field.text = "\(item.value)套"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutNums {
                switch item.key {
                case "二病区": zone2Num.text = "\(item.value)"; break
                case "五病区": zone5Num.text = "\(item.value)"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutCash {
                switch item.key {
                case "二病区": zone2Cash.text = "¥\(item.value)"; break
                case "五病区": zone5Cash.text = "¥\(item.value)"; break
                default: break
                }
            }
        }
    }
}

