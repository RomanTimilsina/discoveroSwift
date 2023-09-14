//
//  WelcomeVCViewController.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class WelcomeVC: UIViewController {

    let welcome = WelcomeView()
    var name:  String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.welcome.welcomeLabel.text = "Welcome \(name)"
        }
    }
    
    override func loadView() {
        super.loadView()
        view = welcome
    }
}
