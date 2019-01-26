//
//  FDCurrentStateCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentStateCell: FDCurrentCell {

    static let defaultHeight: CGFloat = UITableViewAutomaticDimension
    
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var stateEmojiLabel: UILabel?
    @IBOutlet weak var stateDescriptionLabel: UILabel?
    @IBOutlet weak var stateAdviceLabel: UILabel?
    @IBOutlet weak var stateIndexLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationLabel?.numberOfLines = 0
        
    }
    
    override func setup(data: FDData?) {
        locationLabel?.text = data?.localizedAddressName ?? data?.pointName
        let level = AQIStandards.getLevel(data?.mainIndex)
        stateEmojiLabel?.text = AQIStandards.Level.emoji(level)
        stateDescriptionLabel?.text = AQIStandards.getLevelTitle(level)
        stateAdviceLabel?.text = AQIStandards.getHealthImplications(level)
        stateIndexLabel?.text = (data?.mainName ?? "") + " : " + "\(data?.mainIndex ?? 0)"
        timeLabel?.text = data?.measureTime
    }
}
