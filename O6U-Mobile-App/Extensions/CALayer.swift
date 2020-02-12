//
//  CALayer.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit

extension CALayer {
    /// To Applay Sketch Shadow on in View.
    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 4, spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
