//
//  AirQualityStandards.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class AQIStandards {
    
    enum Level: Int {
        case Unknown = 0
        case Good
        case Moderate
        case Bad
        case Unhealthy
        case Dangerous
        case Hazardous
        static func emoji(_ level: Level) -> String {
            switch level {
            case .Unknown: return "💬"
            case .Good: return "😀"
            case .Moderate: return "😧"
            case .Bad: return "🤭"
            case .Unhealthy: return "😷"
            case .Dangerous: return "😰"
            case .Hazardous: return "😱"
            }
        }
    }
    
    
    static func getLevel(_ value: Double?) -> AQIStandards.Level {
        if value != nil {
            switch value! {
            case 0...50:
                return .Good
            case 51...100:
                return .Moderate
            case 101...150:
                return .Bad
            case 151...200:
                return .Unhealthy
            case 201...300:
                return .Dangerous
            case 301...:
                return .Hazardous
            default:
                return .Unknown
            }
        } else {
            return .Unknown
        }
    }
    
    static func getLevelTitle(_ level: AQIStandards.Level) -> String {
        switch level {
        case .Unknown:
            return "Unknown"
        case .Good:
            return "Good"
        case .Moderate:
            return "Moderate"
        case .Bad:
            return "Bad"
        case .Unhealthy:
            return "Unhealthy"
        case .Dangerous:
            return "Dangerous"
        case .Hazardous:
            return "Hazardous"
        }
    }
    
    static func getHealthImplications(_ level: AQIStandards.Level) -> String {
        switch level {
        case .Unknown:
            return " "
        case .Good:
            return "AQIGood".localized
        case .Moderate:
            return "AQIModerate".localized
        case .Bad:
            return "AQIBad".localized
        case .Unhealthy:
            return "AQIUnhealthy".localized
        case .Dangerous:
            return "AQIDangerous".localized
        case .Hazardous:
            return "AQIHazardous".localized
        }
    }
    
    static func getLevelBackgroundColor(_ level: AQIStandards.Level) -> UIColor {
        switch level {
        case .Unknown:
            return .white
        case .Good:
            return UIColor(r: 64, g: 148, b: 104)
        case .Moderate:
            return UIColor(r: 250, g: 218, b: 90)
        case .Bad:
            return UIColor(r: 242, g: 156, b: 75)
        case .Unhealthy:
            return UIColor(r: 189, g: 40, b: 57)
        case .Dangerous:
            return UIColor(r: 92, g: 26, b: 145)
        case .Hazardous:
            return UIColor(r: 115, g: 21, b: 36)
        }
    }
    
    static func getLevelFontColor(_ level: AQIStandards.Level) -> UIColor {
        switch level {
        case .Unknown, .Moderate, .Bad:
            return .black
        case .Good, .Unhealthy, .Dangerous, .Hazardous:
            return .white
        }
    }
}
