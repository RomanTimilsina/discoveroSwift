//
//  otpConfirmVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class OTPConfirmVC: UIViewController {
    
    let otpConfirm = OTPConfirmView()
    let onBoardingPage = OnBoardingPageView()
    let registration = RegistrationVC()
    var logged: Bool?
    
    override func loadView() {
        super.loadView()
        view = otpConfirm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = Color.gray900
        otpConfirm.loginTextField.otpTextfield.configure()
        loginEvents()
        
        
        func loginEvents() {
            otpConfirm.headerView.onClose = {[weak self] in
                guard let self = self else {return}
                navigationController?.popViewController(animated: true)
            }
            print()
            
            otpConfirm.loginTextField.otpTextfield.onOtpFilled = {[weak self] text, isFilled in
                guard let self = self, let isLogin = logged else {return}
                if isFilled {
                    if isLogin {
                        navigationController?.pushViewController(MainController(), animated: true)
                    } else {
                        
                            navigationController?.pushViewController(registration, animated: true)
                    }
                }
            }
        }
    }
}
