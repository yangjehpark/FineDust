//
//  FDForecastSectionHeaderView.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDForecastSectionHeaderView: UITableViewHeaderFooterView {
    
    static let defaultHeight: CGFloat = 60
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(title: String?) {
        self.titleLabel.text = title ?? ""
    }
}
