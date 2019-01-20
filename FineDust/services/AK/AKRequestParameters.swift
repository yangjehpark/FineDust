//
//  AKRequestParameters.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import Alamofire

struct AKParameters {
    
    class NearbyPoint: JSONable {
        
        init(tmX: Double, tmY: Double, _ pageNo: Int? = nil, _ numOfRows: Int? = nil, ver: Double? = nil) {
            self.tmX = tmX
            self.tmY = tmY
            if pageNo != nil {
                self.pageNo = pageNo
            }
            if numOfRows != nil {
                self.numOfRows = numOfRows
            }
            if let versionString = getVerString(ver) {
                self.ver = versionString
            }
        }
        /// TM측정방식 X좌표
        var tmX: Double
        /// TM측정방식 Y좌표
        var tmY: Double
        /// 페이지 번호
        var pageNo: Int?
        /// 한 페이지 결과 수
        var numOfRows: Int?
        /**
         버전
        1. 버전 1.0을 호출할 경우 : 도로명주소검색(juso.go.kr) API가 제공하는 API의 X,Y 좌표로 가까운 측정소를 표출
        2. 버전을 포함하지 않고 호출할 경우 : TM좌표 기반의 가까운 측정소 정보를 표출
         */
        var ver: String?
        
        private func getVerString(_ ver: Double?) -> String? {
            guard ver != nil else {
                return nil
            }
            switch ver! {
            case 1:
                return "1.0"
            default:
                return nil
            }
        }
    }
    
    class StationFeed: JSONable {
        
        init(stationName: String, ver: Double?) {
            
            self.stationName = stationName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            if let versionString = getVerString(ver) {
                self.ver = versionString
            }
        }
        /// 측정소명
        var stationName: String
        /**
         버전
        - 버전을 포함하지 않고 호출할 경우 : PM2.5 데이터가 포함되지 않은 원래 오퍼레이션 결과 표출.
        - 버전 1.0을 호출할 경우 : PM2.5 데이터가 포함된 결과 표출.
        - 버전 1.1을 호출할 경우 : PM10, PM2.5 24시간 예측이동 평균데이터가 포함된 결과 표출.
        - 버전 1.2을 호출할 경우 : 측정망 정보 데이터가 포함된 결과 표출.
        - 버전 1.3을 호출할 경우 : PM10, PM2.5 1시간 등급 자료가 포함된 결과 표출
         */
        var ver: String?

        private func getVerString(_ ver: Double?) -> String? {
            guard ver != nil else {
                return nil
            }
            switch ver! {
            case 1:
                return "1.0"
            case 1.1:
                return "1.1"
            case 1.2:
                return "1.2"
            case 1.3:
                return "1.3"
            default:
                return nil
            }
        }
    }    
}
