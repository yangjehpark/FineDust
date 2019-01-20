//
//  FDAddAreaSearchCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 6. 7..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDAddAreaSearchCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 40
    
    @IBOutlet weak var addressTextCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .gray
    }
    
    func setup(_ datum: KakaoSearchDocument) {
        addressTextCell.text = datum.address?.address_name
    }
}
