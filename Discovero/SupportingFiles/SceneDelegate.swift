//
//  SceneDelegate.swift
//  Discovero
//
//  Created by Sujal Shrestha on 03/09/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureWindowScene(windowScene)
    }
    
    func configureWindowScene(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: RegistrationVC())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

