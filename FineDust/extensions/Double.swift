//
//  Double.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 17..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

extension Double {
    
    init(_ string: String?) {
        self.init()
        guard string != nil else {
            return
        }
        if let value = Double(string!) {
            self = value
        } else {
            return
        }
    }
}
