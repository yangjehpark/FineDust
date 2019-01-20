//
//  FDEditAreaCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 6. 7..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDEditAreaCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 80
    
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(index: Int, addressName: String?) {
        indexLabel.text = String(index)
        addressNameLabel.text = addressName ?? " "
    }
}
