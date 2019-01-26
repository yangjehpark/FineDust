//
//  FDCurrentCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(data: FDData?) {
        changeFontColor(AQIStandards.getLevelFontColor(AQIStandards.getLevel(data?.mainIndex)))
    }
    
    func changeFontColor(_ color: UIColor) {
        for subview in self.subviews {
            if subview.isKind(of: UILabel.self) {
                (subview as! UILabel).textColor = color
            }
        }
    }
}
