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
    private static var unknown = UIImage(named: "fail")!
    
    static let iconArrays: [[UIImage]] = [
        defaultImages,
        Basic.girlImages,
    ]
    
    private static var defaultImages: [UIImage] {
        return getImageArray("default")
    }
    
    class Basic {
        
        static var girlImages: [UIImage] {
            return getImageArray("girl")
        }
    }
    
    static func getImageArray(_ imageName: String) -> [UIImage] {
        var array = [UIImage](arrayLiteral: unknown)
        for i in 1...6 {
            array.append(UIImage(named: "\(imageName)\(String(i))")!.withRenderingMode(.alwaysTemplate))
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
