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
            return "Air quality is considered satisfactory, and air pollution poses little or no risk"
        case .Moderate:
            return "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution."
        case .Bad:
            return "Members of sensitive groups may experience health effects. The general public is not likely to be affected."
        case .Unhealthy:
            return "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects"
        case .Dangerous:
            return "Health warnings of emergency conditions. The entire population is more likely to be affected."
        case .Hazardous:
            return "Health alert: everyone may experience more serious health effects"
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
