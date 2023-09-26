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
    var newCountryModel = countryManager()

    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        registrationView.personalInfoTextField.textField.delegate = self
        observeViewEvents()
    }
    
    func observeViewEvents() {
        registrationView.openPicker = {[weak self] in
            guard let self = self else { return }
            openCountryPicker()
        }
        
        countryPicker.closePicker = {[weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        registrationView.headerView.onClose = {[weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        registrationView.handleSignUp = {[weak self] nameText in
            guard let self, let nameText else {return}
            gotoWelcomePageVC(nameText: nameText)
        }
        
        countryPicker.onPicked = {[weak self] model in
            guard let self = self else {return}
            registrationView.languagePickerTextField.textField.placeholder = ""
            registrationView.languagePickerTextField.textFieldCoverLabel.text = model.name
            registrationView.languagePickerTextField.flagImageView.image = model.flagImage
            isSelected = true
            if let isSelected, let hasName {
                if isSelected && hasName {
                    registrationView.signUpButton.setValidState()
                } else {
                    registrationView.signUpButton.setValidState()
                }
            }
        }
    }
    
    private func gotoWelcomePageVC(nameText: String) {
        let welcomeVC = WelcomeVC()
        welcomeVC.nameText = nameText
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
//    func openCountryPicker() {
//        if let sheet = countryPicker.sheetPresentationController {
//            sheet.prefersGrabberVisible = true
//            sheet.preferredCornerRadius = 30
//            sheet.detents = [.large(),.medium()]
//            sheet.delegate = self
//        }
//        present(countryPicker, animated: true)
//    }
    
    func openCountryPicker() {
        if let country: [CountryModel] = Bundle.main.decode(from: "Countries.json") {
//            print(country[0].name, country[0].dialCode, country[0].code)
            
            
            for (index,_) in country.enumerated() {
                let name = country[index].code.lowercased()
                if let image = UIImage(named: name) {
                    newCountryModel.setData(name: country[index].name, dialCode: country[index].dialCode, code: country[index].code, imageName: country[index].code)
                }
            }
        } else {
            print("Failed to load and decode the JSON file.")
        }
        
        
        countryPicker.countryModel = newCountryModel.getData()
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }

        present(countryPicker, animated: true)
      
    }
}

extension RegistrationVC {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === registrationView.languagePickerTextField.textField {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
