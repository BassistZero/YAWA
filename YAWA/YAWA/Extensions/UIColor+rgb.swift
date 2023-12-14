//
//  UIColor+rgb.swift
//  YAWA
//
//  Created by Bassist Zero on 12/5/23.
//

import UIKit.UIColor

extension UIColor {

    /// Initializes a new UIColor instance from CGFloat without need of `value / 255.`
    convenience init?(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) {
        self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
    
}
