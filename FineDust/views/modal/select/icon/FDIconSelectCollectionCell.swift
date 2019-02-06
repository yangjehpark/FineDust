//
//  FDIconSelectCollectionCell.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDIconSelectCollectionCell: FDCurrentCollectionCell {
    
    static let defaultSize = CGSize(width: 80, height: 80)
    @IBOutlet var iconImageView: UIImageView!

    func setup(_ image: UIImage) {
        iconImageView.tintColor = .black
        iconImageView.image = image
    }
}
