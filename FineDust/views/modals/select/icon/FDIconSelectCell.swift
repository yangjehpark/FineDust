//
//  File.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

protocol FDIconSelectCellDelegate {
    func didSelectItemAt(_ indexPath: IndexPath?)
}

class FDIconSelectCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 100
    
    @IBOutlet weak var mainCollectoinView: UICollectionView!
    var delegate: FDIconSelectCellDelegate?
    var icons: [UIImage]? {
        didSet {
            icons?.removeFirst()
            mainCollectoinView.reloadData()
        }
    }
    
    var cellIndexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        mainCollectoinView.allowsSelection = true
        mainCollectoinView.allowsMultipleSelection = false
        mainCollectoinView.dataSource = self
        mainCollectoinView.delegate = self
        mainCollectoinView.fdRegisterCell(FDIconSelectCollectionCell.self)
        mainCollectoinView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainCollectoinView.reloadData()
        if selected {
            DispatchQueue.main.async {
                self.mainCollectoinView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            }
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
            cell.setup(icon, indexPath: indexPath, selected: self.isSelected)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(cellIndexPath)
    }
}

extension FDIconSelectCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return FDIconSelectCollectionCell.defaultSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
