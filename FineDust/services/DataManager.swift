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
    
    private var currentAreaData: FDData?
    private var userAreaDataList = [FDData]()
    
    init() {
    }
    
}

extension DataManager {
    
    func getCurrentAreaData() -> FDData? {
        return currentAreaData
    }
    
    func setCurrentAreaData(_ data: AQIData?) {
        guard data != nil else {
            return
        }
        self.currentAreaData = FDData(data!)
    }

    func setCurrentAreaData(_ data: AKData?) {
        guard data != nil else {
            return
        }
        self.currentAreaData = FDData(data!)
    }
    
    func setCurrentAreaData(_ addressName: String) {
        self.currentAreaData?.addressName = addressName
    }
}

extension DataManager {
    
    func getUserAreaDataList() -> [FDData] {
        return userAreaDataList
    }
    
    func getUserAreaData(index: Int?) -> FDData? {
        if index != nil {
            return userAreaDataList[safe: index!]
        } else {
            return userAreaDataList[safe: 0]
        }
    }
    
    func setUserAreaDataList(_ data: AQIData?, index: Int?) {
        guard data != nil else {
            log("No AQIData!")
            return
        }
        self.setUserAreaDataList(FDData(data!), index: index)
    }
    
    func setUserAreaDataList(_ data: AKData?, index: Int?) {
        guard data != nil else {
            log("No AKData!")
            return
        }
        self.setUserAreaDataList(FDData(data!), index: index)
    }
    
    private func setUserAreaDataList(_ data: FDData, index: Int?) {
        if index != nil {
            self.userAreaDataList.insert(data, at: index!)
        } else {
            self.userAreaDataList.append(data)
        }
    }
}
