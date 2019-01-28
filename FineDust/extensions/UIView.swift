//
//  UIView.swift
//  FineDust
//
//  Created by YangJehPark on 28/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

extension UIView {
    
    func changeSublabelsFontColor(_ views: [UIView], _ color: UIColor) {
        for view in views {
            if let label = view as? UILabel {
                label.textColor = color
            }
            changeSublabelsFontColor(view.subviews, color)
        }
    }
}

