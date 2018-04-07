//
//  WuJing_DeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/5/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class WuJing_DeliveryVC: UIViewController {
    private var deliveryRecord: DeliveryRecord?
    var titleLabel: UILabel!
    // fields
    var zone6Field: HoshiTextField!
    var zone9Field: HoshiTextField!
    var zone16Field: HoshiTextField!
    var button: UIButton!
    final let textFieldWidth = 330
    var initY = 180
    final let offSetY = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        zone6Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone9Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone16Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(WuJing_DeliveryVC.on_click(_:)), for: .touchUpInside)
        UIController.textFieldStyle_Hoshi(textField: zone6Field, str: "六楼病区")
        UIController.textFieldStyle_Hoshi(textField: zone9Field, str: "九楼病区")
        UIController.textFieldStyle_Hoshi(textField: zone16Field, str: "十六楼病区")
        UIController.buttonStyle(button: button, str: "确定")
        self.view.addSubview(button)
        self.view.addSubview(zone6Field)
        self.view.addSubview(zone9Field)
        self.view.addSubview(zone16Field)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(WuJing_DeliveryVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func on_click(_ sender: Any) {
        if (zone6Field.text!.isEmpty || zone6Field.text!.isEmpty ||
            zone16Field.text!.isEmpty) {
            let alert = UIAlertController(title: "错误", message: "请填写所有病区数目", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        var list: [String:Int] = [zone6Field.placeholder!:Int(zone6Field.text!)!,
                                  zone9Field.placeholder!:Int(zone9Field.text!)!,
                                  zone16Field.placeholder!:Int(zone16Field.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(month)/\(day)"
        let hospital:String = "武警"
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
}
