//
//  HospitalSelectionVC.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class HospitalSelectionVC: UIViewController {
    var yifu_btn: UIButton!
    var huanhu_btn: UIButton!
    var wujing_btn: UIButton!
    var renmin_btn: UIButton!
    var initY = 120
    var gap = 100
    final let width = 140
    final let height = 45
    override func viewDidLoad() {
        super.viewDidLoad()
        let x1 = 30
        yifu_btn = UIButton(frame: CGRect(x: x1, y: initY, width: 315, height: height))
        yifu_btn.addTarget(self, action: #selector(HospitalSelectionVC.yifu_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: yifu_btn, str: "医附院")
        initY += gap
        wujing_btn = UIButton(frame: CGRect(x: x1, y: initY, width: 315, height: height))
        wujing_btn.addTarget(self, action: #selector(HospitalSelectionVC.wujing_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: wujing_btn, str: "武警")
        initY += gap
        huanhu_btn = UIButton(frame: CGRect(x: x1, y: initY, width: 315, height: height))
        huanhu_btn.addTarget(self, action: #selector(HospitalSelectionVC.huanhu_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: huanhu_btn, str: "环湖")
        initY += gap
        renmin_btn = UIButton(frame: CGRect(x: x1, y: initY, width: 315, height: height))
        renmin_btn.addTarget(self, action: #selector(HospitalSelectionVC.renmin_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: renmin_btn, str: "人民")
        self.view.addSubview(yifu_btn)
        self.view.addSubview(wujing_btn)
        self.view.addSubview(huanhu_btn)
        self.view.addSubview(renmin_btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func yifu_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "YiFu_DeliveryVC") as! YiFu_DeliveryVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func huanhu_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "HuanHu_DeliveryVC") as! HuanHu_DeliveryVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func wujing_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "WuJing_DeliveryVC") as! WuJing_DeliveryVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func renmin_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "RenMin_DeliveryVC") as! RenMin_DeliveryVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }

}
