//
//  PersonalInfoVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class RegistrationVC: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate {
    let registrationView = RegistrationView()
    lazy var countryPicker = DIPickerVC()
    var country: DIPickerModel?
    let welcomeVC = WelcomeVC()
    
    override func loadView() {
        super.loadView()
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.gray900
        registrationView.personalInfoTextField.textField.delegate = self
        
        if let country = country {
            print(country.countryName)
            registrationView.pickerTextField.textField.placeholder = country.countryName
        }
        loginEvents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func loginEvents() {
        
        
        registrationView.openPicker = { [weak self] in
            guard let self = self else { return }
            self.openCountryPicker()
        }
        
        countryPicker.closePicker = { [weak self] in
            guard let self = self else { return }
            registrationView.backgroundColor = UIColor.white.withAlphaComponent(0)
            self.dismiss(animated: true, completion: nil)
        }
        
        registrationView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        registrationView.handleSignUp = {[weak self] text in
            guard let self = self, let text = text else {return}
            welcomeVC.name = text
            navigationController?.pushViewController(welcomeVC, animated: true)
            
        }
    }
    
    func openCountryPicker() {
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            
            sheet.detents = [.large(),.medium()]
            
            sheet.delegate = self
        }
        registrationView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        present(countryPicker, animated: true)
    }
    
    // MARK: - UISheetPresentationControllerDelegate
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        registrationView.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registrationView.pickerTextField.textField.resignFirstResponder()
            return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === registrationView.personalInfoTextField.textField {
            guard let text = textField.text else {return}
            if !text.isEmpty {
                registrationView.signUpButton.setValidState()
            }
        }
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardSize.height
                UIView.animate(withDuration: 0.3) {
                    self.registrationView.verticalStack.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
                    self.registrationView.verticalStack.isHidden = false
                }
            }
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            UIView.animate(withDuration: 0.3) {
                self.registrationView.verticalStack.transform = CGAffineTransform(translationX: 0, y: 100)
                self.registrationView.verticalStack.transform = .identity
            }
        }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
}
