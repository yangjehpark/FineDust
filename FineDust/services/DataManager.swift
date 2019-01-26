//
//  DataManager.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 17..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private var currentAreaData = FDData()
    
    init() {
    }
    
}

extension DataManager {
    
    func getCurrentAreaData() -> FDData? {
        return currentAreaData
    }
    
    func setCurrentAreaData(_ data: AQIData?) {
        guard let data = data else {
            return
        }
        let backup = currentAreaData
        currentAreaData = FDData(data)
        if let localizedAddress = backup.localizedAddressName {
            currentAreaData.localizedAddressName = localizedAddress
        }
    }

    func setCurrentAreaData(_ data: AKData?) {
        guard let data = data else {
            return
        }
        let backup = currentAreaData
        currentAreaData = FDData(data)
        if let localizedAddress = backup.localizedAddressName {
            currentAreaData.localizedAddressName = localizedAddress
        }
    }
    
    func setCurrentAreaData(_ response: KakaoAddressNameResponse) {
        currentAreaData.localizedAddressName = response.documents?[safe: 0]?.address_name
    }
}
