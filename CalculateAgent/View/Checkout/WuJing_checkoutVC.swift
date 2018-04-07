//
//  WuJing_checkoutVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class WuJing_checkoutVC: UIViewController, UITextFieldDelegate {
    // things for show page
    var showPage: Bool = false
    var editable: Bool = true
    var showRecord: CheckoutRecord?
    var records: [DeliveryRecord]?
    var totalNum: [Int] = [0,0,0]
    var activeTextField: UITextField?
    var zone6Label: UILabel!
    var zone9Label: UILabel!
    var zone16Label: UILabel!
    // all the fields
    var zone6Field: UILabel!
    var zone9Field: UILabel!
    var zone16Field: UILabel!
    
    var zone6Num: AkiraTextField!
    var zone9Num: AkiraTextField!
    var zone16Num: AkiraTextField!
    
    var zone6Cash: AkiraTextField!
    var zone9Cash: AkiraTextField!
    var zone16Cash: AkiraTextField!
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
        NotificationCenter.default.addObserver(self, selector: #selector(WuJing_checkoutVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WuJing_checkoutVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(WuJing_checkoutVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        zone6Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone6Label.adjustsFontSizeToFitWidth = true
        zone6Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone6Label.adjustsFontSizeToFitWidth = true
        zone6Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone6Num.delegate = self
        zone6Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone6Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone6Num, str: "结账套数", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone6Cash, str: "结账金额(¥)", editable:editable)
        self.view.addSubview(zone6Label)
        self.view.addSubview(zone6Field)
        self.view.addSubview(zone6Num)
        self.view.addSubview(zone6Cash)
        initY += offset
        initY += offset
        // zone 9
        zone9Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone9Label.adjustsFontSizeToFitWidth = true
        zone9Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone9Label.adjustsFontSizeToFitWidth = true
        zone9Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone9Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone9Num.delegate = self
        zone9Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone9Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone9Cash, str: "", editable:editable)
        self.view.addSubview(zone9Label)
        self.view.addSubview(zone9Field)
        self.view.addSubview(zone9Num)
        self.view.addSubview(zone9Cash)
        initY += offset
        initY += offset
        
        // zone 16
        zone16Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone16Label.adjustsFontSizeToFitWidth = true
        zone16Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone16Label.adjustsFontSizeToFitWidth = true
        zone16Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone16Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone16Num.delegate = self
        zone16Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone16Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone16Cash, str: "", editable:editable)
        self.view.addSubview(zone16Label)
        self.view.addSubview(zone16Field)
        self.view.addSubview(zone16Num)
        self.view.addSubview(zone16Cash)
        // confirm button
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(WuJing_checkoutVC.on_click(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: button, str: "确定")
        // load the real page
        if (showPage) {
            showPageDetails()
        } else {
            DeliveryRecordsOps.getPeriodRecords(hospital: "武警",
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
        zone6Label.text = "六楼病区"
        zone9Label.text = "九楼病区"
        zone16Label.text = "十六楼病区"
        totalNum = [0,0,0]
        for record in records {
            for item in record.list {
                switch item.key {
                case "六楼病区": totalNum[0] += item.value; break
                case "九楼病区": totalNum[1] += item.value; break
                case "十六楼病区": totalNum[2] += item.value; break
                default: break
                }
            }
        }
        zone6Field.text = "\(totalNum[0])套"
        zone9Field.text = "\(totalNum[1])套"
        zone16Field.text = "\(totalNum[2])套"
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
        if (zone6Num.text!.isEmpty || zone6Cash.text!.isEmpty ||
            zone9Num.text!.isEmpty || zone9Cash.text!.isEmpty ||
            zone16Num.text!.isEmpty || zone16Cash.text!.isEmpty) {
            let alert = UIAlertController(title: "错误",
                                          message: "请填写所有结款数目及结款金额", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let list1: [String:Int] = [zone6Label.text!:totalNum[0],
                                   zone9Label.text!:totalNum[1],
                                   zone16Label.text!: totalNum[2]]
        let list2: [String:Int] = [zone6Label.text!:Int(zone6Num.text!)!,
                                   zone9Label.text!:Int(zone9Num.text!)!,
                                   zone16Label.text!:Int(zone16Num.text!)!]
        let list3: [String:Int] = [zone6Label.text!:Int(zone6Cash.text!)!,
                                   zone9Label.text!:Int(zone9Cash.text!)!,
                                   zone16Label.text!:Int(zone16Cash.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = "武警"
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
        zone6Label.text = "六楼病区"
        zone9Label.text = "九楼病区"
        zone16Label.text = "十六楼病区"
        if let checkoutRecord = showRecord {
            for item in checkoutRecord.totalDeliveryNums {
                switch item.key {
                case "六楼病区": zone6Field.text = "\(item.value)套"; break
                case "九楼病区": zone9Field.text = "\(item.value)套"; break
                case "十六楼病区": zone16Field.text = "\(item.value)套"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutNums {
                switch item.key {
                case "六楼病区": zone6Num.text = "\(item.value)"; break
                case "九楼病区": zone9Num.text = "\(item.value)"; break
                case "十六楼病区": zone16Num.text = "\(item.value)"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutCash {
                switch item.key {
                case "六楼病区": zone6Cash.text = "¥\(item.value)"; break
                case "九楼病区": zone9Cash.text = "¥\(item.value)"; break
                case "十六楼病区": zone16Cash.text = "¥\(item.value)"; break
                default: break
                }
            }
        }
    }
}


