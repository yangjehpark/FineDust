//
//  AQIAPIs.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 3..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AQIAPIs {
    
    static private let endpoint = "https://api.waqi.info/"
    
    static func getCityFeed(parameter: AQIParameters.CityFeed, completionHandler: @escaping (AQICityFeedResponse?) -> Void) {
        let url = endpoint+"feed/\(parameter.city)/?token=\(parameter.token)"
        let request = Alamofire.request(url)
        request.responseObject { (response: DataResponse<AQICityFeedResponse>) in
            
            if AQIAPIs.isSuccess(response.result) {
                let cityFeedResponse = response.result.value!
                log(Utils.convertPrettyString(json: cityFeedResponse.toJSON()))
                completionHandler(cityFeedResponse)
            } else {
                log("fail")
                completionHandler(nil)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }
    
    static func getIPFeed(parameter: AQIParameters.IPFeed, completionHandler: @escaping (AQIIPFeedResponse?, Error?) -> Void) {
        let url = endpoint+"feed/here/?token=\(parameter.token)"
        let request = Alamofire.request(url)
        request.responseObject { (response: DataResponse<AQIIPFeedResponse>) in
            
            if AQIAPIs.isSuccess(response.result) {
                let ipFeedResponse = response.result.value!
                log(Utils.convertPrettyString(json: ipFeedResponse.toJSON()))
                completionHandler(ipFeedResponse, nil)
            } else {
                log("fail")
                completionHandler(nil, response.error)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }

    static func getGeoFeed(parameter: AQIParameters.GeoFeed, completionHandler: @escaping (AQIGeoFeedResponse?, Error?) -> Void) {
        let url = endpoint+"feed/geo:\(parameter.lat);\(parameter.lng)/?token=\(parameter.token)"
        let request = Alamofire.request(url)
        request.responseObject { (response: DataResponse<AQIGeoFeedResponse>) in
            
            if AQIAPIs.isSuccess(response.result) {
                let geoFeedResponse = response.result.value!
                log(Utils.convertPrettyString(json: geoFeedResponse.toJSON()))
                completionHandler(geoFeedResponse, nil)
            } else {
                log("fail")
                completionHandler(nil, response.error)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }

    static func getMapQueries(parameter: AQIParameters.MapQuery, completionHandler: @escaping (AQIMapQueriesSearchResponse?) -> Void) {
        let url = endpoint+"map/bounds/?latlng=\(parameter.latlng)&token=\(parameter.token)"
        let request = Alamofire.request(url)
        request.responseObject { (response: DataResponse<AQIMapQueriesSearchResponse>) in
            
            if AQIAPIs.isSuccess(response.result) {
                let mapQueryResponse = response.result.value!
                log(Utils.convertPrettyString(json: mapQueryResponse.toJSON()))
                completionHandler(mapQueryResponse)
            } else {
                log("fail")
                completionHandler(nil)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }
    
    static func getNameSearch(parameter: AQIParameters.NameSearch,  completionHandler: @escaping (AQINameSearchResponse?) -> Void) {
        let url = endpoint+"search/?token=\(parameter.token)&keyword=\(parameter.keyword)"
        let request = Alamofire.request(url)
        request.responseObject { (response: DataResponse<AQINameSearchResponse>) in

            if AQIAPIs.isSuccess(response.result) {
                let nameSearchResponse = response.result.value!
                log(Utils.convertPrettyString(json: nameSearchResponse.toJSON()))
                completionHandler(nameSearchResponse)
            } else {
                log("fail")
                completionHandler(nil)
            }
        }
        log(Utils.convertToCurlCommand(request.request))
    }
}

extension AQIAPIs {
    
    static func isSuccess<T>(_ result: Result<T>) -> Bool {
        if result.isSuccess {
            if let basicResponse = result.value as? AQIBasicResponse, basicResponse.status == "ok"  {
                return true
            }
        }
        return false
    }
}
