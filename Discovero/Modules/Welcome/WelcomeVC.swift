//
//  WelcomeVCViewController.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class WelcomeVC: UIViewController {

    let welcome = WelcomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = welcome
    }
}
