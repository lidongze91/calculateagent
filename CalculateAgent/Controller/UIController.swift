//
//  UIController.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/2/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects
let backgroundColor = UIColor(red: 4/255, green: 13/255, blue: 20/255, alpha: 1)
let themeGreen = UIColor(red: 33/255, green: 206/255, blue: 153/255, alpha: 1)
let themeRed = UIColor(red: 243/255, green: 85/255, blue: 48/255, alpha: 1)
let lightGreen = UIColor(red: 33/255, green: 206/255, blue: 153/255, alpha: 0.5)
class UIController {
    static func textFieldStyle_Hoshi(textField: HoshiTextField, str: String) {
        textField.borderActiveColor = themeGreen
        textField.borderInactiveColor = themeRed
        textField.placeholder = str
        textField.placeholderColor = .black
        textField.placeholderFontScale = 1
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .right
        textField.textColor = .black
        textField.isEnabled = true
        textField.keyboardType = .numberPad
    }
    static func textFieldStyle_Akira(textField: AkiraTextField, str: String,
                                     editable: Bool) {
        textField.borderColor = themeGreen
        textField.placeholder = str
        textField.isEnabled = editable
        textField.keyboardType = .numberPad
    }
    static func textFieldStyle_Kaede(textField: KaedeTextField, str: String) {
        textField.placeholder = str
        textField.textAlignment = .right
        textField.isEnabled = true
        textField.keyboardType = .numberPad
        textField.foregroundColor = themeGreen
    }
    static func buttonStyle (button: UIButton, str: String) {
        button.backgroundColor = themeGreen
        button.setTitle(str, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(backgroundColor, for: .highlighted)
        button.layer.cornerRadius = button.frame.size.width / 20
        button.isEnabled = true
    }
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }}
