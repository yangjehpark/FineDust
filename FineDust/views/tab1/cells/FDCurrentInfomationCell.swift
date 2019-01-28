//
//  FDCurrentInfomationCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentInfomationCell: FDCurrentTableCell {
 
    static let defaultHeight: CGFloat = UITableViewAutomaticDimension
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup(data: FDData?) {
        super.setup(data: data)

        guard let attributions = data?.attributions else {
            return
        }
        
        var text = ""
        for attribution in attributions {
            text += "- " + attribution + "\n"
        }
        contentLabel.text = text
    }
}
