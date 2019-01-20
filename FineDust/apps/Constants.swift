//
//  Constants.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 3..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

struct Constants {
    /// API API token (see aqicn.org/data-platform/token/)
    static let aqiToken: String = "b8d0ddafcae067a27e51b715c3eafb4100eeeea2"
    /// AirVisual API token (see airvisual.com/user/api)
    static let airVisualToken: String = "r2ZzRybSq7C3akxcx"
    /// AirKorea API token (see data.or.kr)
    static let airKoreaToken: String = "Mz%2BWTL5niZE5gvQ9oCfxSZMzLaOLvOqd3TgA5VgXpuj4XAqBqX%2BhgZXncXXPNzCikIwbwdkhuK9vmZN7HNczMg%3D%3D"
    /// Kakao native app key
    static let kakaoNativeAppToken = "4cd8ab41575f50c1842c2a8b185409a3"
    /// Kakao REST API key
    static let kakaoAPIToken = "96d1878576c3920fd2dab624e7d5cd51"
    /// Kakao Admin key
    static let kakaoAdminToken = "60a0f5ff67914e93c97e2bdc9060c5be"

    /// 서울특별시 좌표
    static let Seoul: GeoCoordinate = (37.5652894, 126.8494668)
    /// 세종시 좌표
    static let Sejong: GeoCoordinate = (36.4929988, 127.2664714)
}
