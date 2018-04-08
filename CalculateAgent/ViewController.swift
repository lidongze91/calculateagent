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
import NVActivityIndicatorView
class ViewController: UIViewController {
    let serialQueue = DispatchQueue(label: "haha" )
    override func viewDidLoad() {
        super.viewDidLoad()
        let animation = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX-50,
                                                              y: view.frame.midY-50,
                                                              width: 100,
                                                              height: 100),
                                                type: .circleStrokeSpin, color: themeGreen)
        animation.startAnimating()
        let a = animation.isAnimating
        print(view.frame.midX)
        print(view.frame.midY)
        print(a)
        self.view.addSubview(animation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

