//
//  PaycheckVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/7/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class PaycheckVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView: UIPickerView!
    let hospitals: [String] = ["医附院", "环湖", "人民", "武警"]
    var payCheckField: HoshiTextField!
    var button: UIButton!
    var selectedHospital: String = "医附院"
    final let textFieldWidth = 330
    override func viewDidLoad() {
        super.viewDidLoad()
        payCheckField = HoshiTextField(frame: CGRect(x: 20, y: 300, width: textFieldWidth, height: 70))
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(PaycheckVC.on_click(_:)), for: .touchUpInside)
        UIController.textFieldStyle_Hoshi(textField: payCheckField, str: "支票金额 (¥)")
        UIController.buttonStyle(button: button, str: "确定")
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 50,
                                                width: view.frame.width, height: 250))
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        self.view.addSubview(payCheckField)
        self.view.addSubview(button)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(PaycheckVC.hideKeyboardTap(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hospitals.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedHospital = hospitals[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hospitals[row]
    }
    @objc func on_click(_ sender: Any) {
        if (payCheckField.text!.isEmpty) {
            let alert = UIAlertController(title: "错误",
                                          message: "请填写支票金额", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let hospital:String = self.selectedHospital
        let paycheck = PaycheckRecord(date: formattedDate, hospital: hospital,
                                      totalValue: Int(self.payCheckField.text!)!)
        DeliveryRecordsOps.uploadPaycheck(paycheck: paycheck) {
            status in
            if (status) {
                let alert = UIAlertController(title: "上传成功✅",
                                              message: "已上传支票金额", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: { action in
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
    @objc func hideKeyboardTap(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
