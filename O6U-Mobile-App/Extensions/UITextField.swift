//
//  UITextField.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//


import UIKit

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}
