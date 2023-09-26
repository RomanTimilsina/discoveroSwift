//
//  AppDelegate.swift
//  Discovero
//
//  Created by Sujal Shrestha on 03/09/2023.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift


//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        return true
//    }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
      IQKeyboardManager.shared.enable = true
      return true
    }
}
