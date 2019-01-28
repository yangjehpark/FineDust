//
//  FDCurrentHeaderView.swift
//  FineDust
//
//  Created by YangJehPark on 28/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentHeaderView: UITableViewHeaderFooterView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(data: FDData?) {
        changeSublabelsFontColor(self.subviews, AQIStandards.getLevelFontColor(AQIStandards.getLevel(data?.mainIndex)))
    }
}
