//
//  Array.swift
//  FineDust
//
//  Created by YangJehPark on 22/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        if #available(iOS 9.0, *) {
            return indices.contains(index) ? self[index] : nil
        } else {
            return startIndex <= index && index < endIndex ? self[index] : nil
        }
    }
}
