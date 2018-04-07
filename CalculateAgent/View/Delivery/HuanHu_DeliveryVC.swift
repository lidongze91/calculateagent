//
//  HuanHu_DeliveryVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/5/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class HuanHu_DeliveryVC: UIViewController {
    private var deliveryRecord: DeliveryRecord?
    var titleLabel: UILabel!
    // fields
    var zone5Field: HoshiTextField!
    var zone2Field: HoshiTextField!
    var button: UIButton!
    final let textFieldWidth = 330
    var initY = 180
    final let offSetY = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        zone2Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        initY += offSetY
        zone5Field = HoshiTextField(frame: CGRect(x: 20, y: initY, width: textFieldWidth, height: 40))
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(HuanHu_DeliveryVC.on_click(_:)), for: .touchUpInside)
        UIController.textFieldStyle_Hoshi(textField: zone2Field, str: "二病区")
        UIController.textFieldStyle_Hoshi(textField: zone5Field, str: "五病区")
        UIController.buttonStyle(button: button, str: "确定")
        self.view.addSubview(button)
        self.view.addSubview(zone2Field)
        self.view.addSubview(zone5Field)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(HuanHu_DeliveryVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func on_click(_ sender: Any) {
        if (zone2Field.text!.isEmpty || zone5Field.text!.isEmpty) {
            let alert = UIAlertController(title: "错误", message: "请填写所有病区数目", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        var list: [String:Int] = [zone2Field.placeholder!:Int(zone2Field.text!)!,
                                  zone5Field.placeholder!:Int(zone5Field.text!)!]
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(month)/\(day)"
        let hospital:String = "环湖"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
