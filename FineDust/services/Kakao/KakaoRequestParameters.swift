//
//  KakaoRequestParameters.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 27..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

struct KakaoParameters {
    
    struct Geo: JSONable {
        init(lat: Double, lng: Double) {
            self.lat = lat
            self.lng = lng
        }
        /// Latitude
        var lat: Double
        /// Longitude
        var lng: Double
    }
    
    struct Search: JSONable {
        init(query: String, page: Int?, size: Int?) {
            if let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                self.query = encoded
            } else {
                log("Encode error")
                self.query = ""
            }
            if page != nil {
                self.page = page!
            }
            if size != nil {
                self.size = size!
            }
        }
        /// 검색을 원하는 질의어
        var query: String
        /// 결과 페이지 번호 (기본값 1)
        var page: Int = 1
        /// 한 페이지에 보여질 문서의 개수(기본 10, 최소1-최대30)
        var size: Int = 30
    }
}
