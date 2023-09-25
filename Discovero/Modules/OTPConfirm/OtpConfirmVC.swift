//
//  otpConfirmVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class OTPConfirmVC: UIViewController {
    
    let currentView = OTPConfirmView()
    var isFromLogin: Bool?
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        currentView.codeTextField.otpTextfield.configure()
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        currentView.codeTextField.otpTextfield.onOtpFilled = {[weak self] text, isOTPTextFilled in
            guard let self = self, let isFromLogin = isFromLogin else {return}
            if isOTPTextFilled {
                gotoNextPage(isFromLogin: isFromLogin)
            }
        }
        
        currentView.didNotReceiveCode = {[weak self] in
            guard let self else {return}
        }
    }
    
    private func gotoNextPage(isFromLogin: Bool) {
        let registrationVC = RegistrationVC()
        navigationController?.pushViewController(isFromLogin ? HomeController() : registrationVC, animated: true)
    }
}
