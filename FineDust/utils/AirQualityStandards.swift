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
        
        static func icon(_ level: Level) -> UIImage {
            return IconHelper.iconArrays(IconHelper.loadUserDefaultIconOrder())[level.rawValue]
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
            return "Unknown".localized
        case .Good:
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
            return UIColor(r: 0, g: 124, b: 183) // Ibiza Blue
        case .Moderate:
            return UIColor(r: 0, g: 148, b: 153) // Viridian Green
        case .Bad:
            return UIColor(r: 213, g: 215, b: 23) // Sulphur Spring
        case .Unhealthy:
            return UIColor(r: 255, g: 111, b: 97) // Living Coral
        case .Dangerous:
            return UIColor(r: 125, g: 93, b: 153) // Chive Blossom
        case .Hazardous:
            return UIColor(r: 163, g: 40, b: 87) // Vivacious
        }
//        UIColor(r: 238, g: 109, b: 138) // Pink Lemonade
    }
    
    static func getLevelFontColor(_ level: AQIStandards.Level) -> UIColor {
        switch level {
        case .Unknown:
            return .black
        default:
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
            let range = (attributed.string as NSString).range(of: helpStringArray[level.rawValue-1])
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
