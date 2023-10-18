//
//  EmailVC.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class ProfileItemVC: UIViewController  {
    
    var onTitle: String?
    var onPlaceholder: String?
    
    let email = ProfileItemView(title: "", placeholder: "")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        email.Field.titleLabel.text = "What's your \(onTitle ?? "")"
        email.Field.textField.placeholder = onPlaceholder ?? ""
        email.Field.textField.text = ""
        email.Field.textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        if let text = email.Field.textField.text {
            if text.isEmpty {
                email.saveButton.setInvalidState()
            } else {
                email.saveButton.setValidState()
            }
        }
        loginEvents()
    }
    
    override func loadView() {
        view = email
    }
    
    func loginEvents() {
        email.header.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func checkAndUpdateSaveButtonState() {
        if let text = email.Field.textField.text {
            if text.isEmpty {
                email.saveButton.setInvalidState()
            } else {
                email.saveButton.setValidState()
            }
        }
    }
}

// MARK: - textfield delegates
extension ProfileItemVC: UITextFieldDelegate {
    // MARK: Activate button if textfield has name
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            if updatedText.isEmpty {
                email.saveButton.setInvalidState()
            } else {
                email.saveButton.setValidState()
            }
        }
        return true
    }
}
