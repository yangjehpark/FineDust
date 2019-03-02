//
//  IconHelper.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class IconHelper {
    
    static let UserDefaultKeyName = "UserDefautIconNumber"
    static let defaultInset = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    
    private static var unknown = UIImage(named: "fail")!
    
    static let iconArrays: [[UIImage]] = [
        defaultImages,
        Basic.girlImages,
        Basic.boyImages,
        Basic.robotImages,
        Basic.botImages,
    ]
    
    private static var defaultImages: [UIImage] {
        // https://www.iconfinder.com/iconsets/for-interface
        return getImageArray("default")
    }
    
    class Basic {
        
        static var girlImages: [UIImage] {
            // https://www.iconfinder.com/iconsets/cutie-emotions
            return getImageArray("girl")
        }
        
        static var boyImages: [UIImage] {
            // https://www.iconfinder.com/iconsets/cutie-emotions
            return getImageArray("boy")
        }
        
        static var robotImages: [UIImage] {
            // https://www.iconfinder.com/iconsets/cute-line-robot
            return getImageArray("robot")
        }
        
        static var botImages: [UIImage] {
            // https://www.iconfinder.com/iconsets/chat-bot-emoji-linear-outline
            return getImageArray("bot")
        }
    }
    
    static func getImageArray(_ imageName: String) -> [UIImage] {
        var array = [UIImage](arrayLiteral: unknown)
        for i in 1...6 {
            let image = UIImage(named: "\(imageName)\(String(i))")!
                .withRenderingMode(.alwaysTemplate)
                .withAlignmentRectInsets(defaultInset)
            array.append(image)
        }
        return array
    }
}

extension IconHelper {
    
    static func saveUserDefaultIconOrder(_ value: Int) {
        UserDefaults.standard.set(value, forKey: IconHelper.UserDefaultKeyName)
        UserDefaults.standard.synchronize()
    }
    
    static func loadUserDefaultIconOrder() -> Int {
        return UserDefaults.standard.integer(forKey: IconHelper.UserDefaultKeyName)
    }
    
}
