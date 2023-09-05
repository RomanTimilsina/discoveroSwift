//
//  otpConfirmVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class OTPConfirmVC: UIViewController {
    
    let otpConfirm = OTPConfirmView()
    
    override func loadView() {
        super.loadView()
        view = otpConfirm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.gray900
        loginEvents()
    }
    
    func loginEvents() {
        otpConfirm.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
            
        }
    }
}
