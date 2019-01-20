//
//  Log.swift
//  BitMax
//
//  Created by USER on 2018. 2. 23..
//  Copyright © 2018년 USER. All rights reserved.
//

import Foundation

/// Basic log
func log(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
    if (Log.logEnabled()) {
        print("\(Log.time())\(Log.fileNameAndLine(file,line)) \(message)")
    }
}

struct Log {

    /// debug
    static func d(_ message: Any, file: String = #file, line: Int = #line) {
        print("\(Log.time())\(Log.fileNameAndLine(file,line)) debug \(message)")
    }
    
    /// info
    static func i(_ message: Any, file: String = #file, line: Int = #line) {
        print("\(Log.time())\(Log.fileNameAndLine(file,line)) info \(message)")
    }
    
    /// warning
    static func w(_ message: Any, file: String = #file, line: Int = #line) {
        print("\(Log.time())\(Log.fileNameAndLine(file,line)) warning \(message)")
    }
    
    /// error
    static func e(_ message: Any, file: String = #file, line: Int = #line) {
        print("\(Log.time())\(Log.fileNameAndLine(file,line)) error \(message)")
    }
}

extension Log {
    /// Time stamp for Log
    fileprivate static func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "(HH:mm:ss:SSSS)"
        return dateFormatter.string(from: Date())
    }
    
    /// Simplified file name
    fileprivate static func fileNameAndLine(_ file: String, _ line: Int) -> String {
        return "["+(file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")+":\(line)]"
    }
    
    /// show or ignore
    fileprivate static func logEnabled() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// show or ignore
    fileprivate static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
