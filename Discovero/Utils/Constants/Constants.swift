// Copyright © 2021 Minor. All rights reserved.

import Foundation

enum AppConstants {
    static let appName = "TMGM"
    static let noInternet = "The Internet connection appears to be offline."
    static let noResponse = "There seems to be a problem from our side. Please try again."
    static let tapToChoose = "Tap to Choose"
    
    static func appLanguage() -> String {
        return UserDefaultsHelper.getStringData(forKey: .appLanguage)
    }
}

