//
//  KakaoAPI.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 17..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import Alamofire

class KakaoAPI {
    
    static let endpoint = "https://dapi.kakao.com/"
    static let header: HTTPHeaders = ["Authorization":"KakaoAK \(Constants.kakaoAPIToken)"]
    
    static func getAddressName(parameter: KakaoParameters.Geo, completionHandler: @escaping (KakaoAddressNameResponse?) -> Void) {
        let url = endpoint+"v2/local/geo/coord2regioncode.json?x=\(parameter.lng)&y=\(parameter.lat)"
        let request = Alamofire.request(url, headers: header)
        request.responseObject { (response: DataResponse<KakaoAddressNameResponse>) in
            
            if response.result.isSuccess {
                let kakaoAddressNameResponse = response.result.value!
                log(Utils.convertPrettyString(json: kakaoAddressNameResponse.toJSON()))
                completionHandler(kakaoAddressNameResponse)
            } else {
                log("fail")
                completionHandler(nil)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }
    
    static func searchAddress(parameter: KakaoParameters.Search, completionHandler: @escaping (KakaoSearchResponse?) -> Void) {
        let url = endpoint+"v2/local/search/address.json?query=\(parameter.query)&size=\(parameter.size)&page=\(parameter.page)"
        let request = Alamofire.request(url, headers: header)
        request.responseObject { (response: DataResponse<KakaoSearchResponse>) in
            if response.result.isSuccess {
                let kakaoSearchResponse = response.result.value!
                log(Utils.convertPrettyString(json: kakaoSearchResponse.toJSON()))
                completionHandler(kakaoSearchResponse)
            } else {
                log("fail")
                completionHandler(nil)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }
}
