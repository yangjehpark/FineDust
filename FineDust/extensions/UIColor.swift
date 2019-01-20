//
//  UIColor.swift
//  BitMax
//
//  Created by USER on 2018. 3. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:Int, g:Int, b:Int, a:Float? = nil) {
        self.init(red: CGFloat(r)/256, green: CGFloat(g)/256, blue: CGFloat(b)/256, alpha: CGFloat(a ?? 1))
    }
    
    public convenience init(red: Int32, green: Int32, blue: Int32, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 256.0, green: CGFloat(green) / 256.0, blue: CGFloat(blue) / 256.0, alpha: alpha)
    }
    
    convenience init(RGB rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(RGB rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
