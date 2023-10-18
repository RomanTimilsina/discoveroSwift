//
//  WelcomeVCViewController.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let welcomeView = WelcomeView()
    var uid: String?
    var timer: Timer?
    var fireStore = FireStoreDatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    override func loadView() {
        view = welcomeView
    }
}

// MARK: -fetch data from users
extension WelcomeVC {

    func fetchUserData() {
        guard let uid else { return }
        self.fireStore.getUserData(uid: uid, completion: { [weak self] userData in
            guard let self else { return }
            self.welcomeView.welcomeLabel.text = "Welcome \(userData.name)"
            fireStore.saveUserDataToDefault(userData: userData)
            
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        })
    }
    
    @objc func timerFired() {
        navigationController?.pushViewController(HomeController(), animated: true)
    }
}
