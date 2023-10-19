// Copyright © 2021 Minor. All rights reserved.

import Foundation

final class UserDefaultsHelper {
    static let defaults: UserDefaults = .standard
    
    static func setStringData(value: String, key: UserDefaultKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setmodel<T: Codable>(value: T, key: UserDefaultKeys) {   
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    static func getStringData(forKey: UserDefaultKeys) -> String {
        let id = defaults.string(forKey: forKey.rawValue) ?? ""
        return id
    }
    
    static func getModelData<T: Codable>(_ forKey: UserDefaultKeys) -> T? {
       
        let decoder = JSONDecoder()
        if let data = defaults.data(forKey: forKey.rawValue) {
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                // Handle decoding errors here
                print("Error decoding data: \(error)")
            }
        }
        return nil
    }
    
    static func removeData(key: UserDefaultKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    static func removeAllData() {
        UserDefaultsHelper.removeData(key: .isLoggedIn)
        UserDefaultsHelper.removeData(key: .userId)
        UserDefaultsHelper.removeData(key: .userData)
    }
}

enum UserDefaultKeys: String {
    case appLanguage
    case isLoggedIn
    case userId
    case userData
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
