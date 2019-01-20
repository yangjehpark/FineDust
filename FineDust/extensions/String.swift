//
//  String.swift
//  FineDust
//
//  Created by USER on 2018. 3. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

import Foundation

// MARK: - Localize
protocol Localize {
    var localized: String { get }
}

extension String: Localize {
    var localized: String {
        return self.localizedWithComment(comment: "")
    }
    
    func localizedWithComment(comment: String) -> String {
        var result = Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        
        if result == self {
            result = Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable_dev")
        }
        
        return result
    }
}
