//
//  YiFu_checkoutVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/6/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class YiFu_checkoutVC: UIViewController, UITextFieldDelegate {
    // things for show page
    var showPage: Bool = false
    var editable: Bool = true
    var showRecord: CheckoutRecord?
    
    var records: [DeliveryRecord]?
    var totalNum: [Int] = [0,0,0,0,0,0,0,0,0,0,0]
    var activeTextField: UITextField?
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
    
    var zone2Num: AkiraTextField!
    var zone3Num: AkiraTextField!
    var zone4Num: AkiraTextField!
    var zone5Num: AkiraTextField!
    var zone6Num: AkiraTextField!
    var zone7Num: AkiraTextField!
    var zone8Num: AkiraTextField!
    var zone1Num: AkiraTextField!
    var zone9Num: AkiraTextField!
    var zone10Num: AkiraTextField!
    var zone11Num: AkiraTextField!
    
    var zone2Cash: AkiraTextField!
    var zone3Cash: AkiraTextField!
    var zone4Cash: AkiraTextField!
    var zone5Cash: AkiraTextField!
    var zone6Cash: AkiraTextField!
    var zone7Cash: AkiraTextField!
    var zone8Cash: AkiraTextField!
    var zone1Cash: AkiraTextField!
    var zone9Cash: AkiraTextField!
    var zone10Cash: AkiraTextField!
    var zone11Cash: AkiraTextField!
    var button: UIButton!
    var initY = 70
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
//        DeliveryRecordsOps.getPeriodRecords(hospital: "医附院",
//                                            period: "month"){
//            records in
//            self.records = records
//            self.showDetails(records: self.records!)
//        }
//        if (showPage) {
//            editable = false
//            showPageDetails()
//        } else {
//            editable = true
//            DeliveryRecordsOps.getPeriodRecords(hospital: "医附院",
//                                                period: "month"){
//                                                    records in
//                self.records = records
//                self.showDetails(records: self.records!)
//            }
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(YiFu_checkoutVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(YiFu_checkoutVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(YiFu_checkoutVC.hideKeyboardTap(recognizer:)))
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
        zone2Label.text = "二病区"
        zone2Field.text = "20套"
        UIController.textFieldStyle_Akira(textField: zone2Num, str: "结账套数", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone2Cash, str: "结账金额(¥)", editable:editable)
        self.view.addSubview(zone2Label)
        self.view.addSubview(zone2Field)
        self.view.addSubview(zone2Num)
        self.view.addSubview(zone2Cash)
        initY += offset
        // zone3
        zone3Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone3Label.adjustsFontSizeToFitWidth = true
        zone3Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone3Label.adjustsFontSizeToFitWidth = true
        zone3Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone3Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone3Label.text = "二病区"
        zone3Field.text = "20套"
        zone3Num.delegate = self
        zone3Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone3Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone3Cash, str: "", editable:editable)
        self.view.addSubview(zone3Label)
        self.view.addSubview(zone3Field)
        self.view.addSubview(zone3Num)
        self.view.addSubview(zone3Cash)
        initY += offset
        // zone 4
        zone4Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone4Label.adjustsFontSizeToFitWidth = true
        zone4Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone4Label.adjustsFontSizeToFitWidth = true
        zone4Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone4Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone4Label.text = "二病区"
        zone4Field.text = "20套"
        zone4Num.delegate = self
        zone4Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone4Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone4Cash, str: "", editable:editable)
        self.view.addSubview(zone4Label)
        self.view.addSubview(zone4Field)
        self.view.addSubview(zone4Num)
        self.view.addSubview(zone4Cash)
        initY += offset
        // zone 5
        zone5Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone5Label.adjustsFontSizeToFitWidth = true
        zone5Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone5Label.adjustsFontSizeToFitWidth = true
        zone5Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone5Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone5Label.text = "二病区"
        zone5Field.text = "20套"
        zone5Num.delegate = self
        zone5Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone5Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone5Cash, str: "", editable:editable)
        self.view.addSubview(zone5Label)
        self.view.addSubview(zone5Field)
        self.view.addSubview(zone5Num)
        self.view.addSubview(zone5Cash)
        initY += offset
        // zone 6
        zone6Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone6Label.adjustsFontSizeToFitWidth = true
        zone6Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone6Label.adjustsFontSizeToFitWidth = true
        zone6Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone6Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone6Label.text = "二病区"
        zone6Field.text = "20套"
        zone6Num.delegate = self
        zone6Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone6Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone6Cash, str: "", editable:editable)
        self.view.addSubview(zone6Label)
        self.view.addSubview(zone6Field)
        self.view.addSubview(zone6Num)
        self.view.addSubview(zone6Cash)
        initY += offset
        // zone 7
        zone7Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone7Label.adjustsFontSizeToFitWidth = true
        zone7Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone7Label.adjustsFontSizeToFitWidth = true
        zone7Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone7Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone7Label.text = "二病区"
        zone7Field.text = "20套"
        zone7Num.delegate = self
        zone7Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone7Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone7Cash, str: "", editable:editable)
        self.view.addSubview(zone7Label)
        self.view.addSubview(zone7Field)
        self.view.addSubview(zone7Num)
        self.view.addSubview(zone7Cash)
        initY += offset
        // zone 8
        zone8Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone8Label.adjustsFontSizeToFitWidth = true
        zone8Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone8Label.adjustsFontSizeToFitWidth = true
        zone8Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone8Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone8Label.text = "二病区"
        zone8Field.text = "20套"
        zone8Num.delegate = self
        zone8Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone8Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone8Cash, str: "", editable:editable)
        self.view.addSubview(zone8Label)
        self.view.addSubview(zone8Field)
        self.view.addSubview(zone8Num)
        self.view.addSubview(zone8Cash)
        initY += offset
        // zone 1
        zone1Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone1Label.adjustsFontSizeToFitWidth = true
        zone1Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone1Label.adjustsFontSizeToFitWidth = true
        zone1Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone1Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone1Label.text = "二病区"
        zone1Field.text = "20套"
        zone1Num.delegate = self
        zone1Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone1Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone1Cash, str: "", editable:editable)
        self.view.addSubview(zone1Label)
        self.view.addSubview(zone1Field)
        self.view.addSubview(zone1Num)
        self.view.addSubview(zone1Cash)
        initY += offset
        // zone 9
        zone9Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone9Label.adjustsFontSizeToFitWidth = true
        zone9Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone9Label.adjustsFontSizeToFitWidth = true
        zone9Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone9Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone9Label.text = "二病区"
        zone9Field.text = "20套"
        zone9Num.delegate = self
        zone9Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone9Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone9Cash, str: "", editable:editable)
        self.view.addSubview(zone9Label)
        self.view.addSubview(zone9Field)
        self.view.addSubview(zone9Num)
        self.view.addSubview(zone9Cash)
        initY += offset
        // zone 10
        zone10Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone10Label.adjustsFontSizeToFitWidth = true
        zone10Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone10Label.adjustsFontSizeToFitWidth = true
        zone10Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone10Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone10Num.delegate = self
        zone10Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone10Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone10Cash, str: "", editable:editable)
        self.view.addSubview(zone10Label)
        self.view.addSubview(zone10Field)
        self.view.addSubview(zone10Num)
        self.view.addSubview(zone10Cash)
        initY += offset
        // zone 11
        zone11Label = UILabel(frame: CGRect(x: 10, y: initY, width: 50, height: boxHeight))
        zone11Label.adjustsFontSizeToFitWidth = true
        zone11Field = UILabel(frame: CGRect(x: 70, y: initY, width: 50, height: boxHeight))
        zone11Label.adjustsFontSizeToFitWidth = true
        zone11Num = AkiraTextField(frame: CGRect(x: 130, y: initY-5, width: 80, height: boxHeight))
        zone11Cash = AkiraTextField(frame: CGRect(x: 220, y: initY-5, width: 150, height: boxHeight))
        zone11Label.text = "二病区"
        zone11Field.text = "20套"
        zone11Num.delegate = self
        zone11Cash.delegate = self
        UIController.textFieldStyle_Akira(textField: zone11Num, str: "", editable:editable)
        UIController.textFieldStyle_Akira(textField: zone11Cash, str: "", editable:editable)
        self.view.addSubview(zone11Label)
        self.view.addSubview(zone11Field)
        self.view.addSubview(zone11Num)
        self.view.addSubview(zone11Cash)
        
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(YiFu_checkoutVC.on_click(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: button, str: "确定")
        // load the real page
        if (showPage) {
            showPageDetails()
        } else {
            DeliveryRecordsOps.getPeriodRecords(hospital: "医附院",
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
        totalNum = [0,0,0,0,0,0,0,0,0,0,0]
        for record in records {
            for item in record.list {
                switch item.key {
                case "一病区": totalNum[0] += item.value; break
                case "二病区": totalNum[1] += item.value; break
                case "三病区": totalNum[2] += item.value; break
                case "四病区": totalNum[3] += item.value; break
                case "五病区": totalNum[4] += item.value; break
                case "六病区": totalNum[5] += item.value; break
                case "七病区": totalNum[6] += item.value; break
                case "八病区": totalNum[7] += item.value; break
                case "九病区": totalNum[8] += item.value; break
                case "十病区": totalNum[9] += item.value; break
                case "十一病区": totalNum[10] += item.value; break
                default: break
                }
            }
        }
        zone1Field.text = "\(totalNum[0])套"
        zone2Field.text = "\(totalNum[1])套"
        zone3Field.text = "\(totalNum[2])套"
        zone4Field.text = "\(totalNum[3])套"
        zone5Field.text = "\(totalNum[4])套"
        zone6Field.text = "\(totalNum[5])套"
        zone7Field.text = "\(totalNum[6])套"
        zone8Field.text = "\(totalNum[7])套"
        zone9Field.text = "\(totalNum[8])套"
        zone10Field.text = "\(totalNum[9])套"
        zone11Field.text = "\(totalNum[10])套"

    }
    func showPageDetails () {
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
        if let checkoutRecord = showRecord {
            for item in checkoutRecord.totalDeliveryNums {
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
            for item in checkoutRecord.totalCheckoutNums {
                switch item.key {
                case "一病区": zone1Num.text = "\(item.value)"; break
                case "二病区": zone2Num.text = "\(item.value)"; break
                case "三病区": zone3Num.text = "\(item.value)"; break
                case "四病区": zone4Num.text = "\(item.value)"; break
                case "五病区": zone5Num.text = "\(item.value)"; break
                case "六病区": zone6Num.text = "\(item.value)"; break
                case "七病区": zone7Num.text = "\(item.value)"; break
                case "八病区": zone8Num.text = "\(item.value)"; break
                case "九病区": zone9Num.text = "\(item.value)"; break
                case "十病区": zone10Num.text = "\(item.value)"; break
                case "十一病区": zone11Num.text = "\(item.value)"; break
                default: break
                }
            }
            for item in checkoutRecord.totalCheckoutCash {
                switch item.key {
                case "一病区": zone1Cash.text = "¥\(item.value)"; break
                case "二病区": zone2Cash.text = "¥\(item.value)"; break
                case "三病区": zone3Cash.text = "¥\(item.value)"; break
                case "四病区": zone4Cash.text = "¥\(item.value)"; break
                case "五病区": zone5Cash.text = "¥\(item.value)"; break
                case "六病区": zone6Cash.text = "¥\(item.value)"; break
                case "七病区": zone7Cash.text = "¥\(item.value)"; break
                case "八病区": zone8Cash.text = "¥\(item.value)"; break
                case "九病区": zone9Cash.text = "¥\(item.value)"; break
                case "十病区": zone10Cash.text = "¥\(item.value)"; break
                case "十一病区": zone11Cash.text = "¥\(item.value)"; break
                default: break
                }
            }
        }
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
            zone3Num.text!.isEmpty || zone3Cash.text!.isEmpty ||
            zone4Num.text!.isEmpty || zone4Cash.text!.isEmpty ||
            zone5Num.text!.isEmpty || zone5Cash.text!.isEmpty ||
            zone6Num.text!.isEmpty || zone6Cash.text!.isEmpty ||
            zone7Num.text!.isEmpty || zone7Cash.text!.isEmpty ||
            zone8Num.text!.isEmpty || zone8Cash.text!.isEmpty ||
            zone9Num.text!.isEmpty || zone9Cash.text!.isEmpty ||
            zone10Num.text!.isEmpty || zone10Cash.text!.isEmpty ||
            zone11Num.text!.isEmpty || zone11Cash.text!.isEmpty) {
            let alert = UIAlertController(title: "错误",
                                          message: "请填写所有结款数目及结款金额", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let list1: [String:Int] = [zone1Label.text!:totalNum[0],
                                  zone2Label.text!:totalNum[1],
                                  zone3Label.text!:totalNum[2],
                                  zone4Label.text!:totalNum[3],
                                  zone5Label.text!:totalNum[4],
                                  zone6Label.text!:totalNum[5],
                                  zone7Label.text!:totalNum[6],
                                  zone8Label.text!:totalNum[7],
                                  zone9Label.text!:totalNum[8],
                                  zone10Label.text!:totalNum[9],
                                  zone11Label.text!:totalNum[10]]
        let list2: [String:Int] = [zone1Label.text!:Int(zone1Num.text!)!,
                                   zone2Label.text!:Int(zone2Num.text!)!,
                                   zone3Label.text!:Int(zone3Num.text!)!,
                                   zone4Label.text!:Int(zone4Num.text!)!,
                                   zone5Label.text!:Int(zone5Num.text!)!,
                                   zone6Label.text!:Int(zone6Num.text!)!,
                                   zone7Label.text!:Int(zone7Num.text!)!,
                                   zone8Label.text!:Int(zone8Num.text!)!,
                                   zone9Label.text!:Int(zone9Num.text!)!,
                                   zone10Label.text!:Int(zone10Num.text!)!,
                                   zone11Label.text!:Int(zone11Num.text!)!]
        let list3: [String:Int] = [zone1Label.text!:Int(zone1Cash.text!)!,
                                   zone2Label.text!:Int(zone2Cash.text!)!,
                                   zone3Label.text!:Int(zone3Cash.text!)!,
                                   zone4Label.text!:Int(zone4Cash.text!)!,
                                   zone5Label.text!:Int(zone5Cash.text!)!,
                                   zone6Label.text!:Int(zone6Cash.text!)!,
                                   zone7Label.text!:Int(zone7Cash.text!)!,
                                   zone8Label.text!:Int(zone8Cash.text!)!,
                                   zone9Label.text!:Int(zone9Cash.text!)!,
                                   zone10Label.text!:Int(zone10Cash.text!)!,
                                   zone11Label.text!:Int(zone11Cash.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = "医附院"
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
}
