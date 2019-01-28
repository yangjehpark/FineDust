//
//  FDCurrentCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(data: FDData?) {
        changeSublabelsFontColor(self.subviews, AQIStandards.getLevelFontColor(AQIStandards.getLevel(data?.mainIndex)))
    }
}

class FDCurrentCollectionCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(data: FDData?) {
        changeSublabelsFontColor(self.subviews, AQIStandards.getLevelFontColor(AQIStandards.getLevel(data?.mainIndex)))
    }
}
