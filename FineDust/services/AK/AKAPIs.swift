//
//  AKAPIs.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AKAPIs {
    
    /// 측정소 정보 조회 서비스
    class Station {
        static private let endpoint = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/"
        
        /// 1. 근접측정소 목록 조회
        static func getNearbyPoints(_ parameter: AKParameters.NearbyPoint, completionHandler: @escaping (AKNearbyPointResponse?) -> Void) {
            let url = Station.endpoint+"getNearbyMsrstnList?tmX=\(parameter.tmX)&tmY=\(parameter.tmY)&pageNo=\(parameter.pageNo ?? 1)&numOfRows=\(parameter.numOfRows ?? 10)&ServiceKey=\(Constants.airKoreaToken)&_returnType=json"
            let request = Alamofire.request(url)
            request.responseObject { (response: DataResponse<AKNearbyPointResponse>) in
                if let nearbyPointResponse = response.result.value {
                    log(Utils.convertPrettyString(json: nearbyPointResponse.toJSON()))
                    completionHandler(nearbyPointResponse)
                } else {
                    completionHandler(nil)
                }
            }
            log(Utils.convertToCurlCommand(request.request))
        }
    }

    class Measure {
        
        static private let endpoint = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/"
        
        /// 측정소별 실시간 측정정보 조회        
        static func getStationFeed(_ parameter: AKParameters.StationFeed, completionHandler: @escaping (AKStationFeedResponse?) -> Void) {
            let url = Measure.endpoint+"getMsrstnAcctoRltmMesureDnsty?stationName=\(parameter.stationName)&dataTerm=DAILY&pageNo=1&numOfRows=1&ServiceKey=\(Constants.airKoreaToken)&ver=1.0&_returnType=json"
            let request = Alamofire.request(url)
            request.responseObject { (response: DataResponse<AKStationFeedResponse>) in
                if let stationFeedResponse = response.result.value {
                    log(Utils.convertPrettyString(json: stationFeedResponse.toJSON()))
                    completionHandler(stationFeedResponse)
                } else {
                    completionHandler(nil)
                }
            }
            log(Utils.convertToCurlCommand(request.request))
        }
    }
}
