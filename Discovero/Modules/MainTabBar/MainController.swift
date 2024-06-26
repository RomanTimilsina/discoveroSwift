//
//  MainTabBarView.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//
import UIKit

class HomeController: UITabBarController, UITabBarControllerDelegate {
    let lineView = UIView()
    var xVal: CGFloat = 0
    var itemWidth: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        navigationController?.navigationBar.isHidden = true
        addDetialInTab()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        itemWidth = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
        
        lineView.frame = CGRect(x: xVal, y: tabBar.bounds.minY, width: itemWidth, height: 2)
        lineView.backgroundColor = Color.primary
        
        tabBar.addSubview(lineView)
    }
}

// MARK: Navigating, Setting Image and Title
extension HomeController{
    
    func addDetialInTab(){
        let room = UINavigationController(rootViewController: RoomVC() )
        let jobs = UINavigationController(rootViewController: JobVC())
        let sales = UINavigationController(rootViewController: MyProfileVC())
        let announcements = UINavigationController(rootViewController: MyProfileVC())
        //        let matches = UINavigationController(rootViewController: RoomVC())
        let profile = UINavigationController(rootViewController: MyProfileVC())
        
        room.tabBarItem.image = UIImage(named: "roomImage")
        jobs.tabBarItem.image = UIImage(named: "jobsImage")
        sales.tabBarItem.image = UIImage(named: "salesImage")
        announcements.tabBarItem.image = UIImage(named: "announcementsImage")
        //        matches.tabBarItem.image = UIImage(named: "matchesImage")
        profile.tabBarItem.image = UIImage(named: "profileImage")
        
        room.title = "Room"
        jobs.title = "Jobs"
        sales.title = "Sales"
        announcements.title = "Announcements"
        //        matches.title = "Matches"
        profile.title = "Profile"
        
        tabBar.tintColor = Color.appWhite
        tabBar.barTintColor = Color.tabbarColor
        
        setViewControllers([room, jobs, sales, announcements, profile], animated: true)
    }
}

//MARK: Creating TabBar and Positioning
extension HomeController {
   
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            xVal = CGFloat(Int(itemWidth) * selectedIndex-1)
        }
    }
}


