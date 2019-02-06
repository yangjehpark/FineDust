//
//  File.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDIconSelectCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 100
    
    @IBOutlet weak var mainCollectoinView: UICollectionView!
    private var icons: [UIImage]? {
        didSet {
            icons?.removeFirst()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .gray
        
        mainCollectoinView.dataSource = self
        mainCollectoinView.delegate = self
        mainCollectoinView.fdRegisterCell(FDIconSelectCollectionCell.self)
        mainCollectoinView.contentInset = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 0)
    }
    
    func setup(icons: [UIImage]) {
        self.icons = icons
        setSelectedBackgroundColor()
        mainCollectoinView.reloadData()
    }
    
    private func setSelectedBackgroundColor() {
        if let index = DataManager.shared.getCurrentAreaData()?.mainIndex {
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = AQIStandards.getLevelBackgroundColor(AQIStandards.getLevel(index))
            self.selectedBackgroundView = selectedBackgroundView
        }
    }
}

extension FDIconSelectCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let icon = icons?[safe: indexPath.item] {
            let cell = collectionView.fdDequeueCell(FDIconSelectCollectionCell.self, indexPath)
            cell.setup(icon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension FDIconSelectCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return FDIconSelectCollectionCell.defaultSize
    }
}
