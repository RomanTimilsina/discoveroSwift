//
//  MainTabBarView.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class HomeController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let room = UINavigationController(rootViewController: RoomVC())
        let jobs = UINavigationController(rootViewController: RoomVC())
        let sales = UINavigationController(rootViewController: RoomVC())
        let announcements = UINavigationController(rootViewController: RoomVC())
        let matches = UINavigationController(rootViewController: RoomVC())
        let profile = UINavigationController(rootViewController: MyProfileVC())
        
        room.tabBarItem.image = UIImage(named: "roomImage")
        jobs.tabBarItem.image = UIImage(named: "jobsImage")
        sales.tabBarItem.image = UIImage(named: "salesImage")
        announcements.tabBarItem.image = UIImage(named: "announcementsImage")
        matches.tabBarItem.image = UIImage(named: "matchesImage")
        profile.tabBarItem.image = UIImage(named: "profileImage")
        
        room.title = "Room"
        jobs.title = "Jobs"
        sales.title = "Sales"
        announcements.title = "Announcements"
        matches.title = "Matches"
        profile.title = "Profile"
        
        tabBar.selectionIndicatorImage = UIImage(named: "background")
        tabBar.backgroundColor = Color.tabbarColor

        tabBar.tintColor = Color.appWhite
        tabBar.barTintColor = UIColor.red
        
        setViewControllers([room, jobs, sales, announcements, matches, profile], animated: true)
    }
}
