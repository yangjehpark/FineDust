//
//  IconHelper.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class IconHelper {
    
    // privates
    private static let iconArrays = [
        defaultImages,
        Basic.girlImages,
        Basic.boyImages,
        Basic.huskyImages,
        Basic.catImages,
        ]
    private static var defaultImages: [UIImage] {
        // https://www.iconfinder.com/iconsets/for-interface
        return getImageArray("default")
    }
    private static var unknown = UIImage(named: "fail")!
    
    // publics
    static let UserDefaultKeyName = "UserDefautIconNumber"
    static let defaultInset = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    static var iconArraysCount: Int {
        return iconArrays.count
    }
    static func iconArrays(_ index: Int) -> [UIImage] {
        if let result = iconArrays[safe: index] {
            return result
        } else {
            saveUserDefaultIconOrder(0)
            return iconArrays[0]
        }
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
        
        static var huskyImages: [UIImage] {
            // https://www.iconfinder.com/iconsets/siberian-husky-emoticons-1
            return getImageArray("husky")
        }
        
        static var catImages: [UIImage] {
            // https://www.iconfinder.com/icons/2915293/cat_emoji_emotion_expression_face_feeling_smile_icon
            return getImageArray("cat")
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
