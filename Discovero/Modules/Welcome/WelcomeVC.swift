//
//  WelcomeVCViewController.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let welcomeView = WelcomeView()
    var nameText:  String?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameText {
            self.welcomeView.welcomeLabel.text = "Welcome \(nameText)"
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
    }
    
    @objc func timerFired() {
        navigationController?.pushViewController(HomeController(), animated: true)
    }
    
    override func loadView() {
        view = welcomeView
    }
}
