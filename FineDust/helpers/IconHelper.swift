//
//  IconHelper.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class IconHelper {
    
    static let iconArrays: [[UIImage]] = [
        defaultImages,
    ]
    
    private static var unknown = UIImage(named: "fail")!

    private static var defaultImages: [UIImage] {
        return [
            unknown,
            UIImage(named: "default1")!.withRenderingMode(.alwaysTemplate),
            UIImage(named: "default2")!.withRenderingMode(.alwaysTemplate),
            UIImage(named: "default3")!.withRenderingMode(.alwaysTemplate),
            UIImage(named: "default4")!.withRenderingMode(.alwaysTemplate),
            UIImage(named: "default5")!.withRenderingMode(.alwaysTemplate),
            UIImage(named: "default6")!.withRenderingMode(.alwaysTemplate),
        ]
    }
}
