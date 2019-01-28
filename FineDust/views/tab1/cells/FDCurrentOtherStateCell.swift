//
//  FDCurrentOtherStateCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentOtherStateCell: FDCurrentTableCell {
    
    static let defaultHeight: CGFloat = FDCurrentOtherStateCollectionCell.defaultSize.height
    
    @IBOutlet weak var mainCollectoinView: UICollectionView!
    typealias Info = (title:String, value:Double)
    private var infoList = [Info]()
    private var data = FDData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainCollectoinView.dataSource = self
        mainCollectoinView.fdRegisterCell(FDCurrentOtherStateCollectionCell.self)
        mainCollectoinView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    override func setup(data: FDData?) {
        super.setup(data: data)
        guard let data = data else {
            return
        }
        self.data = data
        
        infoList.removeAll()
        
        // must
        if data.pm10 != nil {
           infoList.append(("pm10", data.pm10!))
        }
        if data.pm25 != nil {
            infoList.append(("pm25", data.pm25!))
        }

        // helpful
        if data.no2 != nil {
            infoList.append(("No2", data.no2!))
        }
        if data.so2 != nil {
            infoList.append(("So2", data.so2!))
        }
        if data.co != nil {
            infoList.append(("CO", data.co!))
        }
        if data.o3 != nil {
            infoList.append(("O3", data.o3!))
        }
        
        mainCollectoinView.reloadData()
    }
}

extension FDCurrentOtherStateCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.fdDequeueCell(FDCurrentOtherStateCollectionCell.self, indexPath)
        cell.setup(data: data)
        cell.setup(title: infoList[indexPath.item].title, value: infoList[indexPath.item].value)
        return cell
    }
}
