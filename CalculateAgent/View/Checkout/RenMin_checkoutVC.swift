//
//  RenMin_checkoutVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class RenMin_checkoutVC: UIViewController, UITextFieldDelegate {
    // things for show page
    var showPage: Bool = false
    var editable: Bool = true
    var showRecord: CheckoutRecord?
    var records: [DeliveryRecord]?
    var totalNum: [Int] = [0,0,0]
    var activeTextField: UITextField?
    var zone1Label: UILabel!
    var zone2Label: UILabel!
    var zone3Label: UILabel!
    // all the fields
    var zone1Field: UILabel!
    var zone2Field: UILabel!
    var zone3Field: UILabel!
    
    var zone1Num: AkiraTextField!
    var zone2Num: AkiraTextField!
    var zone3Num: AkiraTextField!
    
    var zone1Cash: AkiraTextField!
    var zone2Cash: AkiraTextField!
    var zone3Cash: AkiraTextField!
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
        NotificationCenter.default.addObserver(self, selector: #selector(RenMin_checkoutVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RenMin_checkoutVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(RenMin_checkoutVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        zone1Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone1Label.adjustsFontSizeToFitWidth = true
        zone1Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone1Label.adjustsFontSizeToFitWidth = true
        zone1Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone1Num.delegate = self
        zone1Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone1Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone1Num, str: "结账套数", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone1Cash, str: "结账金额(¥)", editable:editable)
        self.view.addSubview(zone1Label)
        self.view.addSubview(zone1Field)
        self.view.addSubview(zone1Num)
        self.view.addSubview(zone1Cash)
        initY += offset
        initY += offset
        // zone 9
        zone2Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone2Label.adjustsFontSizeToFitWidth = true
        zone2Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone2Label.adjustsFontSizeToFitWidth = true
        zone2Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone2Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone2Num.delegate = self
        zone2Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone2Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone2Cash, str: "", editable:editable)
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        self.view.addSubview(zone2Num)
        self.view.addSubview(zone2Cash)
        initY += offset
        initY += offset
        
        // zone 16
        zone3Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone3Label.adjustsFontSizeToFitWidth = true
        zone3Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone3Label.adjustsFontSizeToFitWidth = true
        zone3Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone3Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone3Num.delegate = self
        zone3Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone3Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone3Cash, str: "", editable:editable)
        self.view.addSubview(zone3Label)
        self.view.addSubview(zone3Field)
        self.view.addSubview(zone3Num)
        self.view.addSubview(zone3Cash)
        // confirm button
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(RenMin_checkoutVC.on_click(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: button, str: "确定")
        // load the real page
        if (showPage) {
            showPageDetails()
        } else {
            DeliveryRecordsOps.getPeriodRecords(hospital: "人民",
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
        zone1Label.text = "脑外"
        zone2Label.text = "脑内一"
        zone3Label.text = "脑内二"
        totalNum = [0,0,0]
        for record in records {
            for item in record.list {
                switch item.key {
                case "脑外": totalNum[0] += item.value; break
                case "脑内一": totalNum[1] += item.value; break
                case "脑内二": totalNum[2] += item.value; break
                default: break
                }
            }
        }
        zone1Field.text = "\(totalNum[0])套"
        zone2Field.text = "\(totalNum[1])套"
        zone3Field.text = "\(totalNum[2])套"
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
        if (zone1Num.text!.isEmpty || zone1Cash.text!.isEmpty ||
            zone2Num.text!.isEmpty || zone2Cash.text!.isEmpty ||
            zone3Num.text!.isEmpty || zone3Cash.text!.isEmpty) {
            let alert = UIAlertController(title: "错误",
                                          message: "请填写所有结款数目及结款金额", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let list1: [String:Int] = [zone1Label.text!:totalNum[0],
                                   zone2Label.text!:totalNum[1],
                                   zone3Label.text!: totalNum[2]]
        let list2: [String:Int] = [zone1Label.text!:Int(zone1Num.text!)!,
                                   zone2Label.text!:Int(zone2Num.text!)!,
                                   zone3Label.text!:Int(zone3Num.text!)!]
        let list3: [String:Int] = [zone1Label.text!:Int(zone1Cash.text!)!,
                                   zone2Label.text!:Int(zone2Cash.text!)!,
                                   zone3Label.text!:Int(zone3Cash.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = "人民"
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
        zone1Label.text = "脑外"
        zone2Label.text = "脑内一"
        zone3Label.text = "脑内二"
        if let checkoutRecord = showRecord {
            for item in checkoutRecord.totalDeliveryNums {
                switch item.key {
                case "脑外": zone1Field.text = "\(item.value)套"; break
                case "脑内一": zone2Field.text = "\(item.value)套"; break
                case "脑内二": zone3Field.text = "\(item.value)套"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutNums {
                switch item.key {
                case "脑外": zone1Num.text = "\(item.value)"; break
                case "脑内一": zone2Num.text = "\(item.value)"; break
                case "脑内二": zone3Num.text = "\(item.value)"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutCash {
                switch item.key {
                case "脑外": zone1Cash.text = "¥\(item.value)"; break
                case "脑内一": zone2Cash.text = "¥\(item.value)"; break
                case "脑内二": zone3Cash.text = "¥\(item.value)"; break
                default: break
                }
            }
        }
    }
}



