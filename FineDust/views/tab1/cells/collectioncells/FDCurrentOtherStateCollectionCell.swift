//
//  FDCurrentOtherStateCollectionCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentOtherStateCollectionCell: UICollectionViewCell {
    
    static let defaultSize = CGSize(width: 60, height: 80)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(title:String, value:Double) {
        self.titleLabel.text = title.localized
        self.valueLabel.text = "\(value)"
    }
    
}
