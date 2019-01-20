//
//  UserAreaManager.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 9..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import Foundation

// MARK: Shared instance

class UserAreaManager {
    
    static let shared = UserAreaManager()

    init() {
        self.load()
    }
    
    private var userAreas = [UserArea]()
    private let key = "userAreas"
    
    var count: Int {
        return userAreas.count
    }
}

extension UserAreaManager {
    
    func save(area: UserArea) {
        userAreas.append(area)
        sync()
    }
    
    func delete(index: Int) {
        userAreas.remove(at: index)
        sync()
    }
    
    func load() {
        if let data = UserDefaults.standard.object(forKey: key) as? Data, let decoded = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UserArea] {
            userAreas = decoded
        }
    }
    
    func get(index: Int) -> UserArea? {
        return userAreas[safe: index] ?? nil
    }
    
    func change(fromIndex:Int, toIndex:Int) {
        let fromUserArea = userAreas.remove(at: fromIndex)
        userAreas.insert(fromUserArea, at: toIndex)
        sync()
    }
    
    func has(addressName: String) -> Bool {
        for userArea in userAreas {
            if userArea.name == addressName {
                return true
            }
        }
        return false
    }

    private func sync() {
        UserDefaults.standard.removeObject(forKey: key)
        let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: userAreas)
        UserDefaults.standard.set(encoded, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

// MARK: Model

class UserArea: NSObject, NSCoding {
    
    init(name: String, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var name: String
    var latitude: String
    var longitude: String

    // NSCoding
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let latitude = aDecoder.decodeObject(forKey: "latitude") as! String
        let longitude = aDecoder.decodeObject(forKey: "longitude") as! String
        self.init(name: name, latitude: latitude, longitude: longitude)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
    
    // Equatable
    static func ==(lhs: UserArea, rhs: UserArea) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        }
    }
}
