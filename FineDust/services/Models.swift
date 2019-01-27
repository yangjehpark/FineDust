//
//  Models.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

class FDData {

    /// Dominent index of air pollution
    var mainIndex: Double?
    /// Dominent thing of air pollution
    var mainName: String?
    /// Carbon mono dioxide
    var co: Double?
    /// PM-2.5 (Dust size under 2.5μm)
    var pm25: Double?
    /// PM-10 (Dust size under 10.0μm )
    var pm10: Double?
    /// Ozon
    var o3: Double?
    /// Sulfur dioxide
    var so2: Double?
    /// Nitrogen dioxide
    var no2: Double?
    /// 오염도 측정 일시
    var measureTime: String?
    /// 측정소 이름
    var pointName: String?
    /// 측정소 주소 (by kakao API)
    var localizedAddressName: String?
    
    convenience init(_ data: AQIData) {
        self.init()
        
        mainIndex = data.aqi
        mainName = "AQI"
        co = data.aqiInfo?.co
        pm25 = data.aqiInfo?.pm25
        pm10 = data.aqiInfo?.pm10
        o3 = data.aqiInfo?.o3
        so2 = data.aqiInfo?.so2
        no2 = data.aqiInfo?.so2
        measureTime = data.time?.measureTime
        pointName = data.city?.name
    }
    
    convenience init(_ data: AKData) {
        self.init()
        
        mainIndex = Double(data.khaiValue)
        mainName = "통합대기환경수치"
        co = Double(data.coValue)
        pm25 = Double(data.pm25Value)
        pm10 = Double(data.pm10Value)
        o3 = Double(data.o3Value)
        so2 = Double(data.so2Value)
        no2 = Double(data.no2Value)
        measureTime = data.dataTime
        pointName = data.mangName
    }
}
