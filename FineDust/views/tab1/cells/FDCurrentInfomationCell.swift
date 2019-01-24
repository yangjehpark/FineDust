//
//  FDCurrentInfomationCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentInfomationCell: FDCurrentCell {
 
    static let defaultHeight: CGFloat = UITableViewAutomaticDimension
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup(data: FDData?) {
        /*
        guard let attributions = data?.attributions else {
            return
        }
        
        var text = ""
        for attribution in attributions {
            if attribution.name != nil {
                text = text + "- " + attribution.name! + "\n"
            }
        }
        contentLabel.text = text
         */
        contentLabel.text = " "
    }
}
