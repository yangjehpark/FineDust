//
//  String.swift
//  FineDust
//
//  Created by USER on 2018. 3. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}
