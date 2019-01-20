//
//  AQIResponseModels.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 3..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import ObjectMapper

class AQIBasicResponse: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    /// status code, can be ok or error.
    var status: String?
    var message: String?
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
}

class AQICityFeedResponse: AQIBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Station data
    var data: AQIData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class AQIIPFeedResponse: AQIBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Station data
    var data: AQIData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class AQIGeoFeedResponse: AQIBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Station data
    var data: AQIData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class AQIMapQueriesSearchResponse: AQIBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Map data
    var data: [AQIMapData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class AQINameSearchResponse: AQIBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Station data
    var data: [AQIData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class AQIData: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Unique ID for the city monitoring station.
    var idx: Int?
    /// Real-time air quality infomrmation.
    var aqi: Double?
    /// Measurement time infomration.
    var time: AQITime?
    /// Information about the monitoring station.
    var city: AQICity?
    /// Dominent pollution value
    var dominentpol: String?
    /// EPA Attribution for the station
    var attributions: [AQIAttributions]?
    /// Measurement time infomration.
    var aqiInfo: AQIInfo?
    
    func mapping(map: Map) {
        idx <- map["idx"]
        aqi <- map["aqi"]
        time <- map["time"]
        city <- map["city"]
        if city == nil {
            city <- map["station"] // The API of 'search by name' uses 'station'.
        }
        dominentpol <- map["dominentpol"]
        attributions <- map["attributions"]
        aqiInfo <- map["iaqi"]
    }
}

class AQIMapData: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Latitude
    var lat: Double?
    /// Longitude
    var lon: Double?
    /// Unique ID for the city monitoring station.
    var uid: Double?
    /// Real-time air quality infomrmation.
    var aqi: String?
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
        uid <- map["uid"]
        aqi <- map["aqi"]
    }
}

class AQITime: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var v: Double?
    /// Local measurement time time.
    var measureTime: String?
    /// Station timezone.
    var stationTimeZone: String?
    
    func mapping(map: Map) {
        v <- map["v"]
        measureTime <- map["s"]
        stationTimeZone <- map["tz"]
    }
}

class AQICity: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Name of the monitoring station.
    var name: String?
    /// Url for the attribution link.
    var url: String?
    private var geo: [Double?]? {
        didSet {
            if geo?[safe:0] != nil {
                longitude = geo![0]
            }
            if geo?[safe:1] != nil {
                latitude = geo![1]
            }
        }
    }
    /// Latitude of the monitoring station.
    var latitude: Double?
    /// Longitude of the monitoring station.
    var longitude: Double?
    
    func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
        geo <- map["geo"]
    }
}

class AQIAttributions: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var url: String?
    var name: String?
    
    func mapping(map: Map) {
        url <- map["url"]
        name <- map["name"]
    }
}

class AQIInfo: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    /// Indivudal AQI for the Carbon mono dioxide
    var co: Double?
    /// Indivudal AQI for the PM-2.5 (Dust size under 2.5μm)
    var pm25: Double?
    /// Indivudal AQI for the PM-10 (Dust size under 10.0μm )
    var pm10: Double?
    /// Indivudal AQI for the Ozon
    var o3: Double?
    /// Indivudal AQI for the Sulfur dioxide
    var so2: Double?
    /// Indivudal AQI for the Nitrogen dioxide
    var no2: Double?
    /// Atmospheric pressure
    var p: Double?
    /// Wind
    var w: Double?
    /// Humidity
    var h: Double?
    /// Temperature
    var t: Double?
    /// Dew
    var d: Double?
    /// Rain
    var r: Double?
    /// ?
    var wd: Double?
    
    func mapping(map: Map) {
        co <- map["co"]
        pm25 <- map["pm25.v"]
        pm10 <- map["pm10.v"]
        o3 <- map["o3.v"]
        so2 <- map["so2.v"]
        no2 <- map["no2.v"]
        p <- map["p.v"]
        w <- map["w.v"]
        h <- map["h.v"]
        t <- map["t.v"]
        d <- map["d.v"]
        r <- map["r.v"]
        wd <- map["wd.v"]
    }
}
