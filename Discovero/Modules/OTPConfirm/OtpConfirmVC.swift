//
//  otpConfirmVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

class OTPConfirmVC: UIViewController {
    
    let currentView = OTPConfirmView()
    var verificationId: String?
    
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
        
        currentView.didNotReceiveCode = {[weak self] in
            guard let self else {return}
            // need to add didNtReceiveCode
        }
        
        currentView.onNextClick = {[weak self] otpText in
            guard let self else {return}
            showHUD()
            gotoNextPage(verificationID: verificationId ?? "", verificationCode: otpText)
        }
    }
    
    private func gotoNextPage(verificationID: String, verificationCode: String) {
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                // Show alert
                return
            }
            self.hideHUD()
            if let uid = authResult?.user.uid {
                //In Helpers folder FireStoreDatabaseHelper()sends to login/ register
                FireStoreDatabaseHelper(navigationController: self.navigationController!).checkAuthentication(uid: uid)
            }
        }
    }
}
