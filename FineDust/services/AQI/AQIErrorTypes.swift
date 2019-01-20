//
//  AQIErrorTypes.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 3..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

enum AQICityFeedError: String {
    /// The request is over quota limits
    case overQuota = "Over quota"
    /// The key is not valid
    case invalidKey = "Invalid key"
    /// The city is unknown
    case unknownCity = "Unknown city"
}

enum AQIIPFeedError: String {
    /// The request is over quota limits
    case overQuota = "Over quota"
    /// The key is not valid
    case invalidKey = "Invalid key"
}

enum AQIGeoFeedError: String {
    /// The request is over quota limits
    case overQuota = "Over quota"
    /// The key is not valid
    case invalidKey = "Invalid key"
}

enum AQINameSearchError: String {
    /// The request is over quota limits
    case overQuota = "Over quota"
    /// The key is not valid
    case invalidKey = "Invalid key"
}

