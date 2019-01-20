//
//  KakaoResponseModels.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 27..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation
import ObjectMapper

class KakaoBasicResponse: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var total_count: Int?
    var pageable_count: Int?
    var is_end: Bool?
    
    func mapping(map: Map) {
        total_count <- map["meta.total_count"]
        pageable_count <- map["meta.pageable_count"]
        is_end <- map["meta.is_end"]
    }
}

// MARK: Address Name

class KakaoAddressNameResponse: KakaoBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var documents: [KakaoAddressNameDocument]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        documents <- map["documents"]
    }
}

class KakaoAddressNameDocument: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var region_type: String?
    var address_name: String?
    var region_1depth_name: String?
    var region_2depth_name: String?
    var region_3depth_name: String?
    var region_4depth_name: String?
    var code: String?
    var x: Double?
    var y: Double?
    
    func mapping(map: Map) {
        region_type <- map["region_type"]
        address_name <- map["address_name"]
        region_1depth_name <- map["region_1depth_name"]
        region_2depth_name <- map["region_2depth_name"]
        region_3depth_name <- map["region_3depth_name"]
        region_4depth_name <- map["region_4depth_name"]
        code <- map["code"]
        x <- map["x"]
        y <- map["y"]
    }
}

// MARK: Search

class KakaoSearchResponse: KakaoBasicResponse {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var documents: [KakaoSearchDocument]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        documents <- map["documents"]
    }
}

class KakaoSearchDocument: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var address_name: String?
    var x: Double?
    var y: Double?
    var address_type: String?
    var address: KakaoSearchAddress?
    var road_address: KakaoSearchRoadAddress?

    func mapping(map: Map) {
        address_name <- map["address_name"]
        x <- map["x"]
        y <- map["y"]
        address_type <- map["address_type"]
        address <- map["address"]
        road_address <- map["road_address"]
    }
}

class KakaoSearchAddress: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var address_name: String?
    var region_1depth_name: String?
    var region_2depth_name: String?
    var region_3depth_name: String?
    var region_3depth_h_name: String?
    var h_code: String?
    var b_code: String?
    var mountain_yn: String?
    var main_address_no: String?
    var sub_address_no: String?
    var zip_code: String?
    var x: String?
    var y: String?

    func mapping(map: Map) {
        address_name <- map["address_name"]
        region_1depth_name <- map["region_1depth_name"]
        region_2depth_name <- map["region_2depth_name"]
        region_3depth_name <- map["region_3depth_name"]
        region_3depth_h_name <- map["region_3depth_h_name"]
        h_code <- map["h_code"]
        b_code <- map["b_code"]
        mountain_yn <- map["mountain_yn"]
        main_address_no <- map["main_address_no"]
        sub_address_no <- map["sub_address_no"]
        zip_code <- map["zip_code"]
        x <- map["x"]
        y <- map["y"]
    }
}

class KakaoSearchRoadAddress: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var address_name: String?
    var region_1depth_name: String?
    var region_2depth_name: String?
    var region_3depth_name: String?
    var road_name: String?
    var underground_yn: String?
    var main_building_no: String?
    var sub_building_no: String?
    var building_name: String?
    var zone_no: String?
    var x: String?
    var y: String?
    
    func mapping(map: Map) {
        address_name <- map["address_name"]
        region_1depth_name <- map["region_1depth_name"]
        region_2depth_name <- map["region_2depth_name"]
        region_3depth_name <- map["region_3depth_name"]
        road_name <- map["road_name"]
        underground_yn <- map["underground_yn"]
        main_building_no <- map["main_building_no"]
        sub_building_no <- map["sub_building_no"]
        building_name <- map["building_name"]
        zone_no <- map["zone_no"]
        x <- map["x"]
        y <- map["y"]
    }
}
