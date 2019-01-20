//
//  AKResponseModels.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import ObjectMapper

class AKBasicResponse: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    /// 결과 코드
    var resultCode: Int?
    /// 결과 메세지
    var resultMsg: String?
    /// 한 페이지 결과 수
    var numOfRows: Int?
    /// 페이지 번호
    var pageNo: Int?
    /// 전체 결과 수
    var totalCount: Int?
    
    func mapping(map: Map) {
        resultCode <- map["resultCode"]
        resultMsg <- map["resultMsg"]
        numOfRows <- map["numOfRows"]
        pageNo <- map["pageNo"]
        totalCount <- map["totalCount"]
    }
}

class AKNearbyPointResponse: AKBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var list: [AKNearbyPointItem]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        list <- map["list"]
    }
}

class AKNearbyPointItem: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    /// 측정소 명
    var stationName: String?
    /// 측정소 주소
    var addr: String?
    /// 거리(km)
    var tm: Double?

    func mapping(map: Map) {
        stationName <- map["stationName"]
        addr <- map["addr"]
        tm <- map["tm"]
    }
}

class AKStationFeedResponse: AKBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var list: [AKData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        list <- map["list"]
    }
}

class AKData: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    /// 오염도 측정 일시 (YYYY-MM-DD HH:MM)
    var dataTime: String?
    /// 측정망 정보 (국가배경, 교외대기, 도시대기, 도로변대기)
    var mangName: String?
    /// 일산화탄소 지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var coGrade: String?
    /// 일산화탄소 농도 (단위 : ppm)
    var coValue: String?
    /// 통합대기환경지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var khaiGrade: String?
    /// 통합대기환경수치
    var khaiValue: String?
    /// 이산화질소 지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var no2Grade : String?
    /// 이산화질소 농도 (단위 : ppm)
    var no2Value : String?
    /// 오존 지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var o3Grade : String?
    /// 오존 농도 (단위 : ppm)
    var o3Value : String?
    /// 미세먼지(PM10) 지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var pm10Grade : String?
    /// 미세먼지(PM10) 1시간 등급 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var pm10Grade1h : String?
    /// 미세먼지(PM10) 농도
    var pm10Value: String?
    /// 미세먼지(PM10) 24시간예측이동농도
    var pm10Value24 : String?
    /// 미세먼지(PM2.5) 24시간 등급 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var pm25Grade : String?
    /// 미세먼지(PM2.5) 1시간 등급 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var pm25Grade1h : String?
    /// 미세먼지(PM2.5) 농도(단위 : ㎍/㎥)
    var pm25Value : String?
    /// 미세먼지(PM2.5) 24시간예측이동농도(단위 : ㎍/㎥)
    var pm25Value24 : String?
    /// 아황산가스 지수 (Grade 1:좋음, 2:보통, 3:나쁨, 4:매우나쁨)
    var so2Grade : String?
    /// 아황산가스 농도 (단위 : ppm)
    var so2Value : String?
    
    func mapping(map: Map) {
        dataTime <- map["dataTime"]
        mangName <- map["mangName"]
        coGrade <- map["coGrade"]
        coValue <- map["coValue"]
        khaiGrade <- map["khaiGrade"]
        khaiValue <- map["khaiValue"]
        no2Grade <- map["no2Grade"]
        no2Value <- map["no2Value"]
        o3Grade <- map["o3Grade"]
        o3Value <- map["o3Value"]
        pm10Grade <- map["pm10Grade"]
        pm10Grade1h <- map["pm10Grade1h"]
        pm10Value <- map["pm10Value"]
        pm10Value24 <- map["pm10Value24"]
        pm25Grade <- map["pm25Grade"]
        pm25Grade1h <- map["pm25Grade1h"]
        pm25Value <- map["pm25Value"]
        pm25Value24 <- map["pm25Value24"]
        so2Grade <- map["so2Grade"]
        so2Value <- map["so2Value"]
    }
}
