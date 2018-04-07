//
//  YiFu_DeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class YiFu_DeliveryVC: UIViewController {
    private var deliveryRecord: DeliveryRecord?
    // all the labels
    var yifuyuanLabel: UILabel!
    var northCampusLabel: UILabel!
    var southCampusLabel: UILabel!
    
    // fields
    var zone1Field: HoshiTextField!
    var zone2Field: HoshiTextField!
    var zone3Field: HoshiTextField!
    var zone4Field: HoshiTextField!
    var zone5Field: HoshiTextField!
    var zone6Field: HoshiTextField!
    var zone7Field: HoshiTextField!
    var zone8Field: HoshiTextField!
    var zone9Field: HoshiTextField!
    var zone10Field: HoshiTextField!
    var zone11Field: HoshiTextField!
    
    var button: UIButton!
    final let textFieldWidth = 140
    var initY = 100
    final let offSetY = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        zone2Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        zone3Field = HoshiTextField(frame: CGRect(x: 210, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone4Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        zone5Field = HoshiTextField(frame: CGRect(x: 210, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone6Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        zone7Field = HoshiTextField(frame: CGRect(x: 210, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone8Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone1Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        zone9Field = HoshiTextField(frame: CGRect(x: 210, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone10Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        zone11Field = HoshiTextField(frame: CGRect(x: 210, y: initY, width: textFieldWidth, height: 40))
        button = UIButton(frame: CGRect(x: 20, y: 500, width: 330, height: 50))
        button.addTarget(self, action: #selector(YiFu_DeliveryVC.on_click(_:)), for: .touchUpInside)
        UIController.textFieldStyle_Hoshi(textField: zone2Field, str: "二病区")
        UIController.textFieldStyle_Hoshi(textField: zone3Field, str: "三病区")
        UIController.textFieldStyle_Hoshi(textField: zone4Field, str: "四病区")
        UIController.textFieldStyle_Hoshi(textField: zone5Field, str: "五病区")
        UIController.textFieldStyle_Hoshi(textField: zone6Field, str: "六病区")
        UIController.textFieldStyle_Hoshi(textField: zone7Field, str: "七病区")
        UIController.textFieldStyle_Hoshi(textField: zone8Field, str: "八病区")
        UIController.textFieldStyle_Hoshi(textField: zone1Field, str: "一病区")
        UIController.textFieldStyle_Hoshi(textField: zone9Field, str: "九病区")
        UIController.textFieldStyle_Hoshi(textField: zone10Field, str: "十病区")
        UIController.textFieldStyle_Hoshi(textField: zone11Field, str: "十一病区")
        UIController.buttonStyle(button: button, str: "确定")
        self.view.addSubview(button)
        self.view.addSubview(zone1Field)
        self.view.addSubview(zone2Field)
        self.view.addSubview(zone3Field)
        self.view.addSubview(zone4Field)
        self.view.addSubview(zone5Field)
        self.view.addSubview(zone6Field)
        self.view.addSubview(zone7Field)
        self.view.addSubview(zone8Field)
        self.view.addSubview(zone9Field)
        self.view.addSubview(zone10Field)
        self.view.addSubview(zone11Field)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(YiFu_DeliveryVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func on_click(_ sender: Any) {
        if (zone1Field.text!.isEmpty || zone2Field.text!.isEmpty || zone3Field.text!.isEmpty || zone4Field.text!.isEmpty ||
        zone5Field.text!.isEmpty || zone6Field.text!.isEmpty ||
        zone7Field.text!.isEmpty || zone8Field.text!.isEmpty ||
        zone9Field.text!.isEmpty || zone10Field.text!.isEmpty ||
            zone11Field.text!.isEmpty) {
            let alert = UIAlertController(title: "错误", message: "请填写所有病区数目", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        var list: [String:Int] = [zone1Field.placeholder!:Int(zone1Field.text!)!,
                                  zone2Field.placeholder!:Int(zone2Field.text!)!,
                                  zone3Field.placeholder!:Int(zone3Field.text!)!,
                                  zone4Field.placeholder!:Int(zone4Field.text!)!,
                                  zone5Field.placeholder!:Int(zone5Field.text!)!,
                                  zone6Field.placeholder!:Int(zone6Field.text!)!,
                                  zone7Field.placeholder!:Int(zone7Field.text!)!,
                                  zone8Field.placeholder!:Int(zone8Field.text!)!,
                                  zone9Field.placeholder!:Int(zone9Field.text!)!,
                                  zone10Field.placeholder!:Int(zone10Field.text!)!,
                                  zone11Field.placeholder!:Int(zone11Field.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = "医附院"
        deliveryRecord = DeliveryRecord(date:formattedDate, hospital: hospital, list: list)
        if let deliveryRecord = deliveryRecord {
            DeliveryRecordsOps.uploads(deliveryRecord: deliveryRecord) {
                status in
                if (status) {
                    let alert = UIAlertController(title: "上传成功✅",
                                                  message: "已上传送货数量", preferredStyle: UIAlertControllerStyle.alert)
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
    @objc func hideKeyboardTap(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func backtoRoot() -> Void {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
