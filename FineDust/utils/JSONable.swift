//
//  JSONable.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 4..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

// REFERENCE = http://minsone.github.io/mac/ios/how-to-make-json-data-using-mirror-in-swift2

// 사용할 구조체를 선언하였으므로, Mirror를 확장하여 john의 속성을 읽을 수 있도록 합시다.
// Mirror는 children이라는 속성을 가지는데, children은 AnyForwardCollection로 각 속성의 이름, 값을 Child 라는 타입으로 가지고 있습니다. 깊은 탐색을 하기 위해서 속성의 이름과 속성을 Array Tuple로 만듭니다.
extension Mirror {
    var properties: [(String, Child)] {
        return self.children.reduce([(String, Child)]()) {
            guard let propertyName = $1.label else {
                return $0
            }
            return $0 + [(propertyName, $1)]
        }
    }
}

// 다음으로 직렬화 에러 코드 Enum을 선언합니다.
enum CouldNotSerializeError {
    case NoImplementation(source: Any, type: Mirror)
}

// CouldNotSerializeError는 Error type을 가지도록 합니다.
extension CouldNotSerializeError: Error {
    
}

// 다음으로 JSON 프로토콜과 확장을 선언합니다.
protocol JSONable {
    func toJSON() throws -> AnyObject?
}

// 이제 JSON의 toJSON을 구현합니다.
// Mirror을 통해 객체에 속성이 몇개인지를 읽고, 값이 JSON 프로토콜을 가진다면 딕셔너리에 저장하고, 그렇지 않으면 직렬화 에러를 던집니다.
extension JSONable {
    func toJSON() throws -> AnyObject? {
        let mirror = Mirror(reflecting: self)
        if !mirror.properties.isEmpty {
            var result = [String:AnyObject]()
            for (key, child) in mirror.properties {
                guard let value = child.value as? JSONable else {
                    throw CouldNotSerializeError.NoImplementation(source: self, type: mirror)
                }
                result[key] = try value.toJSON()
            }
            return result as AnyObject
        }
        return self as? AnyObject
    }
    
    func toParameter() -> [String: Any]? {
        do {
            if let json = try self.toJSON() {
                if let returnValue = json as? [String: Any] {
                    return returnValue
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}

// 이제 Man, Address, PostCode를 JSON으로 확장하고, String, Int, Bool도 확장합니다.
extension String: JSONable { }
extension Int: JSONable { }
extension Double: JSONable { }
extension Bool: JSONable { }

// 그리고 옵셔널도 확장합니다.
extension Optional: JSONable {
    func toJSON() throws -> AnyObject? {
        guard let value = self else { return nil }
        if let json = value as? JSONable {
            return try json.toJSON()
        }
        throw CouldNotSerializeError.NoImplementation(source: value, type: Mirror(reflecting: value))
    }
}
