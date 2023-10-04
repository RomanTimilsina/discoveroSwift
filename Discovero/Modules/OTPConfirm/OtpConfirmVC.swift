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
    let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
    var phoneNumber = ""
    var fireStore =  FireStoreDatabaseHelper()
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        currentView.codeTextField.otpTextfield.configure()
        observeViewEvents()
        self.currentView.nextButton.setInvalidState()
    }
    
    func findExtensionCode(for countryCode: String) -> String? {
        if let country = countries.first(where: { $0.code == countryCode }) {
            return country.dialCode
        } else {
            return nil // Country code not found in the array
        }
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.didNotReceiveCode = { [weak self] in
            guard let self else { return }
            self.showHUD()
            self.resendOTP(phoneNum: self.phoneNumber)
        }
        
        currentView.onNextClick = { [weak self] otpText in
            guard let self else { return }
            showHUD()
            gotoNextPage(verificationID: verificationId ?? "", verificationCode: otpText)
        }
        
        currentView.codeTextField.otpTextfield.onOtpFilled = { [weak self] text, isFilled in
            guard let self else { return }
            if isFilled {
                self.currentView.nextButton.setValidState()
            } else {
                self.currentView.nextButton.setInvalidState()
            }
        }
    }
    
    private func gotoWelcomePage(name: String) {
        let welcomeVC = WelcomeVC()
        welcomeVC.nameText = name
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    private func gotoHomePage() {
        let homeVC = HomeController()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func gotoRegisterPage(uid: String) {
        let register = RegistrationVC(phoneNumber: self.phoneNumber, userId: uid)
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    private func gotoNextPage(verificationID: String, verificationCode: String) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self = self else { return }
            self.hideHUD()
            if let error = error {
                print("Error: ", error.localizedDescription)
                self.currentView.alert.message = "\(error.localizedDescription)"
                self.present(self.currentView.alert, animated: true, completion: nil)
                return
            }
            
            if let uid = authResult?.user.uid {
                self.fireStore.checkAuthentication(uid: uid, phone: phoneNumber) { name, uid in
                    if !name.isEmpty {
//                        self.gotoWelcomePage(name: name)
                        self.gotoHomePage()
                        UserDefaultsHelper.setStringData(value: uid, key: .userId)
                        UserDefaultsHelper.setStringData(value: "set", key: .isLoggedIn)
                    } else {
                        self.gotoRegisterPage(uid: uid)
                    }
                }
            }
        }
    }
}

extension OTPConfirmVC {
    private func resendOTP( phoneNum: String) {
        let phoneNumber = phoneNum
        let timer = CountdownTimer()
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
                guard let self = self else { return }
                self.hideHUD()
                if let error = error {
                    self.hideHUD()
                    print("Error: ", error.localizedDescription)
                    self.currentView.alert.message = "\(error)"
                    self.present(self.currentView.alert, animated: true, completion: nil)
                    return
                }
                timer.start(
                    tickHandler: { [weak self] remainingSeconds in
                        guard let self = self else { return }
                        self.currentView.codeNotReceivedLabel.text = "Remaining time for resend otp: \(remainingSeconds)s"
                    },
                    completionHandler: { [weak self]  in
                        guard let self = self else { return }
                        self.currentView.codeNotReceivedLabel.text = "I didn't receive a code"
                    }
                )
            }
    }
}

