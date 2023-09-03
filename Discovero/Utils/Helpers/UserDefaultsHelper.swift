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
        UserDefaultsHelper.removeData(key: .country)
        UserDefaultsHelper.removeData(key: .defaultCountry)
        UserDefaultsHelper.removeData(key: .defaultCountryCode)
        UserDefaultsHelper.removeData(key: .jurisdiction)
        UserDefaultsHelper.removeData(key: .memberName)
        UserDefaultsHelper.removeData(key: .language)
        UserDefaultsHelper.removeData(key: .loginID)
        UserDefaultsHelper.removeData(key: .verificationStatus)
        UserDefaultsHelper.removeData(key: .verificationComplete)
        UserDefaultsHelper.removeData(key: .email)
        UserDefaultsHelper.removeData(key: .isIb)
        UserDefaultsHelper.removeData(key: .retailDemo)
    }
}

enum UserDefaultKeys: String {
    case appLanguage
    case country
    case defaultCountry
    case defaultCountryCode
    case jurisdiction
    case memberName
    case language
    case loginID
    case verificationStatus
    case isOnboardingShown
    case verificationComplete
    case email
    case isIb
    case retailDemo
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
