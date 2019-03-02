//
//  FDCurrentStateCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

protocol FDCurrentStateCellDelegate {
    func stateIconImageViewTouched()
}

class FDCurrentStateCell: FDCurrentTableCell {

    static let defaultHeight: CGFloat = UITableViewAutomaticDimension
    
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var stateIconImageView: UIImageView?
    @IBOutlet weak var stateDescriptionLabel: UILabel?
    @IBOutlet weak var stateAdviceLabel: UILabel?
    @IBOutlet weak var stateIndexLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    var delegate: FDCurrentStateCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationLabel?.numberOfLines = 0
        stateIconImageView?.tintColor = .white
        stateIconImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateIconImageViewTouched)))
    }
    
    override func setup(data: FDData?) {
        super.setup(data: data)
        locationLabel?.text = data?.localizedAddressName ?? data?.pointName
        let level = AQIStandards.getLevel(data?.mainIndex)
        stateIconImageView?.image = AQIStandards.Level.icon(level)
        stateDescriptionLabel?.text = AQIStandards.getLevelTitle(level)
        stateAdviceLabel?.text = AQIStandards.getHealthImplications(level)
        stateIndexLabel?.text = (data?.mainName ?? "Index") + " : " + "\(data?.mainIndex ?? 0)"
        timeLabel?.text = data?.measureTime
    }
    
    @objc func stateIconImageViewTouched() {
        delegate?.stateIconImageViewTouched()
    }
}
