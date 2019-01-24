//
//  FDCurrentStandardColorHeader.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentStandardColorHeader: UITableViewHeaderFooterView {
    
    static let defaultHeight: CGFloat = 3
    
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for view in subviews {
            if let level = AQIStandards.Level(rawValue: view.tag) {
                view.backgroundColor = AQIStandards.getLevelBackgroundColor(level)
            }
        }
    }
}
