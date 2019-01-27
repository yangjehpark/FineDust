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
        case Perfect
        case Good
        case Moderate
        case Bad
        case Unhealthy
        case Dangerous
        case Hazardous
        static func emoji(_ level: Level) -> String {
            switch level {
            case .Unknown: return "💬"
            case .Perfect, .Good: return "😀"
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
            case 0...10:
                return .Perfect
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
            return "Unknown".localized
        case .Perfect, .Good:
            return "Good".localized
        case .Moderate:
            return "Moderate".localized
        case .Bad:
            return "Bad".localized
        case .Unhealthy:
            return "Unhealthy".localized
        case .Dangerous:
            return "Dangerous".localized
        case .Hazardous:
            return "Hazardous".localized
        }
    }
    
    static func getHealthImplications(_ level: AQIStandards.Level) -> String {
        switch level {
        case .Unknown:
            return " "
        case .Perfect, .Good:
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
        case .Perfect:
            return UIColor(r: 64, g: 148, b: 255)
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
        case .Perfect, .Good, .Unhealthy, .Dangerous, .Hazardous:
            return .white
        }
    }
    
    static var helpString: String {
        return "HelpMessage".localized + "\n(US-EPA 2016)" + "\n\n" +
            helpStringArray[0] + "\n" +
            helpStringArray[1] + "\n" +
            helpStringArray[2] + "\n" +
            helpStringArray[3] + "\n" +
            helpStringArray[4] + "\n" +
            helpStringArray[5] + "\n"
    }
    
    private static var helpStringArray: [String] {
        return [
            "0-50 : " + AQIStandards.getLevelTitle(.Good),
            "51-100 : " +  AQIStandards.getLevelTitle(.Moderate),
            "101-150 : " + AQIStandards.getLevelTitle(.Bad),
            "151-200 : " + AQIStandards.getLevelTitle(.Unhealthy),
            "201-300 : " + AQIStandards.getLevelTitle(.Dangerous),
            "301- : " + AQIStandards.getLevelTitle(.Hazardous),
        ]
    }
    
    static var attributedHelpString: NSMutableAttributedString {
        var attributed = NSMutableAttributedString(string: helpString)
        func addAttribute(level: Level) {
            let range = (attributed.string as NSString).range(of: helpStringArray[level.rawValue-2])
            let attribute = [NSAttributedStringKey.foregroundColor: AQIStandards.getLevelBackgroundColor(level)]
            attributed.addAttributes(attribute, range: range)
        }
        addAttribute(level: .Good)
        addAttribute(level: .Moderate)
        addAttribute(level: .Bad)
        addAttribute(level: .Unhealthy)
        addAttribute(level: .Dangerous)
        addAttribute(level: .Hazardous)
        return attributed
    }
}
