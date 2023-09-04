//
//  LoginVCViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginVC: UIViewController {
    
    let login = LoginView()
    
    override func loadView() {
        super.loadView()
        view = login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        loginEvents()
    }
    
    func loginEvents() {
        login.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
            
        }
    }
}
