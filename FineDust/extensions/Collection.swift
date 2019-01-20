//
//  Collection.swift
//  BitMax
//
//  Created by USER on 2018. 3. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

import Foundation

extension Collection {
    /// An method for the anti-'out of bound' exception. If it is out of bounded, it returns 'null'.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
