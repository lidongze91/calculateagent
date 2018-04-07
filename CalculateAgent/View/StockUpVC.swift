//
//  StockUpVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import TextFieldEffects
class StockUpVC: UIViewController {
    var field: HoshiTextField!
    var button: UIButton!
    final let textFieldWidth = 330
    override func viewDidLoad() {
        super.viewDidLoad()
        field = HoshiTextField(frame: CGRect(x: 20, y: 300, width: textFieldWidth, height: 70))
        button = UIButton(frame: CGRect(x: 20, y: 600, width: 330, height: 50))
        button.addTarget(self, action: #selector(StockUpVC.on_click(_:)), for: .touchUpInside)
        UIController.textFieldStyle_Hoshi(textField: field, str: "入库数量")
        UIController.buttonStyle(button: button, str: "确定")
        self.view.addSubview(button)
        self.view.addSubview(field)
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(StockUpVC.hideKeyboardTap(recognizer:)))
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
        if (field.text!.isEmpty) {
            let alert = UIAlertController(title: "错误", message: "请填写入库数量", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let g = GlobalInventory.shared
        g.goingIn(num: Int(field.text!)!)
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let formattedDate:String = "\(year) / \(month) / \(day)"
        let stock = StockUpRecord(date: formattedDate, totalNum: Int(field.text!)!)
        DeliveryRecordsOps.uploadStock(stockupRecord: stock) {
            status in
            if (status) {
                let alert = UIAlertController(title: "上传成功✅",
                                              message: "已上传入库数量", preferredStyle: UIAlertControllerStyle.alert)
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
    @objc func hideKeyboardTap(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
