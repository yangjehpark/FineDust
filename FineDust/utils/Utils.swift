//
//  Utils.swift
//  BitBox
//
//  Created by John Yu on 2018. 1. 30..
//  Copyright © 2018년 BB. All rights reserved.
//

import UIKit

class Utils {
    
    static var isiPhoneX: Bool {
        return (UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436)
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    static func convertToCurlCommand(_ request: URLRequest?) -> String {
        guard request != nil else {
            return "Error: Request is null"
        }
        let method = request!.httpMethod ?? "GET"
        var returnValue = "curl -X \(method) "
        
        if let httpBody = request!.httpBody, request!.httpMethod == "POST" {
            let maybeBody = String(data: httpBody, encoding: String.Encoding.utf8)
            if let body = maybeBody {
                returnValue += "-d \"\(escapeTerminalString(body))\" "
            }
        }
        
        for (key, value) in request!.allHTTPHeaderFields ?? [:] {
            let escapedKey = escapeTerminalString(key as String)
            let escapedValue = escapeTerminalString(value as String)
            returnValue += " -H \"\(escapedKey): \(escapedValue)\" "
        }
        
        let URLString = request!.url?.absoluteString ?? "<unknown url>"
        
        returnValue += "\"\(escapeTerminalString(URLString))\""
        returnValue += " -i -v"
        
        return returnValue
    }
    
    static func escapeTerminalString(_ value: String) -> String {
        return value.replacingOccurrences(of: "\"", with: "\\\"")
    }
    
    static func convertPrettyString(json: [String: Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        } catch {
            return "Fail to convert pretty string"
        }
    }
    
    static func isInternetConnected() -> Bool {
        return true
    }
    
    static func isGeoInfoAutorized() -> Bool {
        return true
    }
}
