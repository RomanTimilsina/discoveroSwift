// Copyright © 2021 Minor. All rights reserved.

import Foundation

final class UserDefaultsHelper {
    static let defaults: UserDefaults = .standard
    
    static func setStringData(value: String, key: UserDefaultKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func getStringData(forKey: UserDefaultKeys) -> String {
        let id = defaults.string(forKey: forKey.rawValue) ?? ""
        return id
    }
    
    static func removeData(key: UserDefaultKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    static func removeAllData() {
        UserDefaultsHelper.removeData(key: .isLoggedIn)
        UserDefaultsHelper.removeData(key: .userId)
    }
}

enum UserDefaultKeys: String {
    case appLanguage
    case isLoggedIn
    case userId
}

extension UserDefaults {
    /// Make sure this is always the same name as `UserDefaultKeys.isLoggedIn`
    @objc dynamic public var isLoggedIn: String {
        get { string(forKey: #function) ?? "" }
        set { set(newValue, forKey: #function) }
    }
    
    @objc dynamic public var orderPlaced: String {
        get { string(forKey: #function) ?? "" }
        set { set(newValue, forKey: #function) }
    }
}
