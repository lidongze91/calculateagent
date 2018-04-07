//
//  MenuViewController.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    var deliveryBtn: UIButton!
    var stockupBtn: UIButton!
    var checkoutBtn: UIButton!
    var paycheckBtn: UIButton!
    var taxBtn: UIButton!
    
    var deliveryRecordBtn: UIButton!
    var stockupRecordBtn: UIButton!
    var checkoutRecordBtn: UIButton!
    var paycheckRecordBtn: UIButton!
    
    var cashLabel: UILabel!
    var inventoryLabel: UILabel!
    var initY = 80
    var gap = 65
    final let width = 140
    final let height = 45
    override func viewDidLoad() {
        let x1 = 30
        let x2 = Int(view.frame.width-170)
        super.viewDidLoad()
        deliveryBtn = UIButton(frame: CGRect(x: x1, y: initY, width: width, height: height))
        deliveryBtn.addTarget(self, action: #selector(MenuVC.delivery_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: deliveryBtn, str: "送货")
        deliveryRecordBtn = UIButton(frame: CGRect(x: x2, y: initY, width: width, height: height))
        deliveryRecordBtn.addTarget(self, action: #selector(MenuVC.deliveryRecord_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: deliveryRecordBtn, str: "送货记录")
        initY += gap
        stockupBtn = UIButton(frame: CGRect(x: x1, y: initY, width: width, height: height))
        stockupBtn.addTarget(self, action: #selector(MenuVC.stockup_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: stockupBtn, str: "进货")
        stockupRecordBtn = UIButton(frame: CGRect(x: x2, y: initY, width: width, height: height))
        stockupRecordBtn.addTarget(self, action: #selector(MenuVC.stockupRecord_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: stockupRecordBtn, str: "进货记录")
        initY += gap
        checkoutBtn = UIButton(frame: CGRect(x: x1, y: initY, width: width, height: height))
        checkoutBtn.addTarget(self, action: #selector(MenuVC.checkout_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: checkoutBtn, str: "结账")
        checkoutRecordBtn = UIButton(frame: CGRect(x: x2, y: initY, width: width, height: height))
        checkoutRecordBtn.addTarget(self, action: #selector(MenuVC.checkoutRecord_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: checkoutRecordBtn, str: "结账记录")
        initY += gap
        paycheckBtn = UIButton(frame: CGRect(x: x1, y: initY, width: width, height: height))
        paycheckBtn.addTarget(self, action: #selector(MenuVC.paycheck_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: paycheckBtn, str: "回款")
        paycheckRecordBtn = UIButton(frame: CGRect(x: x2, y: initY, width: width, height: height))
        paycheckRecordBtn.addTarget(self, action: #selector(MenuVC.paycheckRecord_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: paycheckRecordBtn, str: "回款记录")
        initY += gap
        taxBtn = UIButton(frame: CGRect(x: x1, y: initY, width: 315, height: height))
        taxBtn.addTarget(self, action: #selector(MenuVC.tax_onClick(_:)), for: .touchUpInside)
        UIController.buttonStyle(button: taxBtn, str: "税款")
        initY += 2*gap
        cashLabel = UILabel(frame: CGRect(x: x1, y: initY, width: 315, height: height*2))
        let c = GlobalCash.shared
        cashLabel.adjustsFontSizeToFitWidth = true
        cashLabel.font = cashLabel.font.withSize(20)
        cashLabel.textColor = themeGreen
        c.updateRemainNum(label: cashLabel)
        
        initY += gap
        
        inventoryLabel = UILabel(frame: CGRect(x: x1, y: initY, width: 315, height: height*2))
        let g = GlobalInventory.shared
        inventoryLabel.adjustsFontSizeToFitWidth = true
        inventoryLabel.font = inventoryLabel.font.withSize(20)
        inventoryLabel.textColor = themeGreen
        g.updateRemainNum(label: inventoryLabel)
        self.view.addSubview(inventoryLabel)
        self.view.addSubview(cashLabel)
        self.view.addSubview(deliveryBtn)
        self.view.addSubview(stockupBtn)
        self.view.addSubview(checkoutBtn)
        self.view.addSubview(paycheckBtn)
        self.view.addSubview(taxBtn)
        self.view.addSubview(deliveryRecordBtn)
        self.view.addSubview(stockupRecordBtn)
        self.view.addSubview(checkoutRecordBtn)
        self.view.addSubview(paycheckRecordBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        let g = GlobalInventory.shared
        g.updateRemainNum(label: inventoryLabel)
        let c = GlobalCash.shared
        c.updateRemainNum(label: cashLabel)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func delivery_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "HospitalSelectionVC") as! HospitalSelectionVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func stockup_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "StockUpVC") as! StockUpVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func checkout_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "HospitalSelectionVC2") as! HospitalSelectionVC2
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func paycheck_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "PaycheckVC") as! PaycheckVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func tax_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TaxVC") as! TaxVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func deliveryRecord_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "DeliveryRecordVC") as! DeliveryRecordVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func stockupRecord_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "StockupRecordVC") as! StockupRecordVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func checkoutRecord_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "CheckoutRecordVC") as! CheckoutRecordVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func paycheckRecord_onClick(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "PaycheckRecordVC") as! PaycheckRecordVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
}
