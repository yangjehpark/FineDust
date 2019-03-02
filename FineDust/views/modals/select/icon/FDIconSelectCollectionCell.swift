//
//  FDIconSelectCollectionCell.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDIconSelectCollectionCell: UICollectionViewCell {
    
    static let defaultSize = CGSize(width: 100, height: 100)
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ image: UIImage, indexPath: IndexPath, selected: Bool) {
        iconImageView.image = image
        if selected {
            DispatchQueue.main.async {
                if let level = AQIStandards.Level.init(rawValue: indexPath.item+1) {
                    self.iconImageView.tintColor = AQIStandards.getLevelBackgroundColor(level)
                }
            }
        } else {
            iconImageView.tintColor = .black
        }
        
    }
}
