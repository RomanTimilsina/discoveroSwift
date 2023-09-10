//
//  MainTabBarView.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class MainController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let Room = UINavigationController(rootViewController: DICreateAdVC())
        let Jobs = UINavigationController(rootViewController: DICreateAdVC())
        let Sales = UINavigationController(rootViewController: DICreateAdVC())
        let Announcements = UINavigationController(rootViewController: DICreateAdVC())
        let Matches = UINavigationController(rootViewController: DICreateAdVC())
        let Profile = UINavigationController(rootViewController: DICreateAdVC())

        Room.tabBarItem.image = UIImage(named: "roomImage")
        Jobs.tabBarItem.image = UIImage(named: "jobsImage")
        Sales.tabBarItem.image = UIImage(named: "salesImage")
        Announcements.tabBarItem.image = UIImage(named: "announcementsImage")
        Matches.tabBarItem.image = UIImage(named: "matchesImage")
        Profile.tabBarItem.image = UIImage(named: "profileImage")

        Room.title = "Room"
        Jobs.title = "Jobs"
        Sales.title = "Sales"
        Announcements.title = "Announcements"
        Matches.title = "Matches"
        Profile.title = "Profile"

        tabBar.backgroundColor = Color.gray700
        tabBar.tintColor = Color.appWhite
        tabBar.barTintColor = UIColor.red

        setViewControllers([Room, Jobs, Sales, Announcements, Profile], animated: true)
        
    }
}
