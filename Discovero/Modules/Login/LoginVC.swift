//
//  LoginVCViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginVC: UIViewController {
    
    let currentView = LoginView()
    var isFromLogin: Bool?
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        currentView.handleConfirmOTP = {[weak self] in
            let otpConfirmVC = OTPConfirmVC()
            guard let self = self, let isFromLogin = isFromLogin else {return}
            otpConfirmVC.isFromLogin = isFromLogin
            navigationController?.pushViewController(otpConfirmVC, animated: true)
        }
    }
}

