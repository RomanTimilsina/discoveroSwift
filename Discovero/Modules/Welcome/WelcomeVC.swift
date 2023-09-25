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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameText {
            self.welcomeView.welcomeLabel.text = "Welcome \(nameText)"
        }
    }
    
    override func loadView() {
        view = welcomeView
    }
}
