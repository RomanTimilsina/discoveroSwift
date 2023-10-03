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
        
        //        fireStore.handleNextPage = { [weak self] vc in
        //            guard let self else { return }
        //            navigationController?.pushViewController(vc, animated: true)
        //        }
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
                //In Helpers folder FireStoreDatabaseHelper()sends to login/ register
                //                FireStoreDatabaseHelper(navigationController: self.navigationController!).checkAuthentication(uid: uid, phone: phoneNumber)
                self.fireStore.checkAuthentication(uid: uid, phone: phoneNumber) { documents in

                    let uids = documents.map { $0.data()["uid"] as? String ?? "" }
                    if let document = documents.first(where: { $0.data()["uid"] as? String == uid }) {
                        let name = document.data()["name"] as? String ?? ""
                        let welcomeVC = WelcomeVC()
                        welcomeVC.nameText = name
                        UserDefaultsHelper.setStringData(value: uid, key: .userId)
                        UserDefaultsHelper.setStringData(value: "set", key: .isLoggedIn)
                        
                        self.navigationController?.pushViewController(welcomeVC, animated: true)

                    } else {
                        let register = RegistrationVC(phoneNumber: self.phoneNumber, userId: uid)
                        self.navigationController?.pushViewController(register, animated: true)
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
                            // Handle each tick (update UI, display remaining time, etc.)
                            self.currentView.codeNotReceivedLabel.text = "Remaining time for resend otp: \(remainingSeconds)s"
                        },
                        completionHandler: { [weak self]  in
                            guard let self = self else { return }
                            // Handle timer completion (e.g., enable a button)
                            self.currentView.codeNotReceivedLabel.text = "I didn't receive a code"
                        }
                    )
                }
        }
    }

