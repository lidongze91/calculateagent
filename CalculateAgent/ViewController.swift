//
//  ViewController.swift
//  CalculateAgent
//
//  Created by Dongze Li on 3/29/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit
import Parse
import TextFieldEffects
class ViewController: UIViewController {
    let serialQueue = DispatchQueue(label: "haha" )
    override func viewDidLoad() {
        super.viewDidLoad()
        let g = GlobalCash.shared
        g.goingOut(num: 130000)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

