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
    var hasName: Bool?
    var isSelected: Bool?
    
    override func loadView() {
        super.loadView()
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.gray900
        registrationView.personalInfoTextField.textField.delegate = self
        
        observeViewEvents()
        
    }
    
    func observeViewEvents() {
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
            let welcomeVC = WelcomeVC()

            guard let self = self, let text = text else {return}
            welcomeVC.name = text
            navigationController?.pushViewController(welcomeVC, animated: true)
        }
            
        countryPicker.onPicked = {[weak self] model in
            guard let self = self else {return}
            
            self.registrationView.pickerTextField.textField.placeholder = ""
            self.registrationView.pickerTextField.textFieldCoverLabel.text = model.countryName
            self.registrationView.pickerTextField.image.image = model.countryImage
            
            self.isSelected = true
            
            if let isSelected = isSelected, let hasName = hasName {
                if isSelected && hasName {
                    registrationView.signUpButton.setValidState()
                } else {
                    registrationView.signUpButton.setValidState()
                }
            }

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
}

extension RegistrationVC {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === registrationView.pickerTextField.textField {
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        registrationView.pickerTextField.textField.resignFirstResponder()
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === registrationView.personalInfoTextField.textField {
            guard let text = textField.text else {return}
            if !text.isEmpty {
                hasName = true
            }
            else {
                hasName = false
            }
        }
        
        guard let isSelected = isSelected , let hasName = self.hasName else {return}
        if isSelected && hasName {
            registrationView.signUpButton.setValidState()
        } else {
            registrationView.signUpButton.setInvalidState()
        }
    }
}
