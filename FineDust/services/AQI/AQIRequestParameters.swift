//
//  AQIRequestParameters.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 3..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import Alamofire

struct AQIParameters {

    class CityFeed: JSONable {
        init(city: String, _ callBack: String? = nil) {
            self.city = city
            self.callBack = callBack
        }
        var token = Constants.aqiToken
        /// Name of the city (eg beijing), or id (eg @7397)
        var city: String
        /// optional JSONP callback function name
        var callBack: String?        
    }
    
    class IPFeed: JSONable {
        init(_ callBack: String? = nil) {
            self.callBack = callBack
        }
        var token = Constants.aqiToken
        /// optional JSONP callback function name
        var callBack: String?
    }
    
    class GeoFeed: JSONable {
        init(lat: Double, lng: Double, optional: String?) {
            self.lat = lat
            self.lng = lng
            self.optional = optional
        }
        /// Latitude
        var lat: Double
        /// Longitude
        var lng: Double
        var token = Constants.aqiToken
        /// callback JSONP callback function name
        var optional: String?
    }
    
    class MapQuery: JSONable {
        init(lat1: Double, lng1: Double, lat2: Double, lng2: Double, _ callback: String? = nil) {
            self.latlng = String(lat1)+","+String(lng1)+String(lat2)+","+String(lng2)
            self.callback = callback
        }
        /// Map bounds in the form lat1,lng1,lat2,lng2 (ex, latlng=39.379436,116.091230,40.235643,116.784382)
        var latlng: String
        var token = Constants.aqiToken
        /// callback JSONP callback function name
        var callback: String?
    }
    
    class NameSearch: JSONable {
        init(keyword: String, _ callback: String? = nil) {
            self.keyword = keyword
            self.callback = callback
        }
        /// Name of the station your are looking for (eg beijing, bulgaria, bangalore)
        var keyword: String
        var token = Constants.aqiToken
        /// optional JSONP callback function name
        var callback: String?
    }
}
