//
//  LoginVCViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginVC: UIViewController {
    
    let login = LoginView()
    let otpConfirm = OTPConfirmVC()
    var isLogin: Bool?
    
    override func loadView() { 
        super.loadView()
        view = login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.gray900
        
        loginEvents()
    }
    
    func loginEvents() {
        login.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        login.confirmOTP = {[weak self] in
            guard let self = self, let isLogin = isLogin else {return}
            otpConfirm.logged = isLogin
                navigationController?.pushViewController(otpConfirm, animated: true)
            }
        }
    }

