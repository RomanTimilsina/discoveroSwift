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
    var sendDataBack: ((String) -> Void)?
    let currentView = ProfileItemView(title: "", placeholder: "")
    var isItEmail: Bool?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAndUpdateSaveButtonState()

        currentView.emailTextField.titleLabel.text = "What's your \(onTitle ?? "")"
        currentView.emailTextField.textField.placeholder = onPlaceholder ?? ""
        currentView.emailTextField.textField.text = ""
        currentView.emailTextField.textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        observeViewEvents()
    }
    
    override func loadView() {
        view = currentView
    }
    
    func observeViewEvents() {
        currentView.header.onClose = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onClickedSave = { [weak self] text in
            guard let self else { return }
            sendDataBack?(text)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func checkAndUpdateSaveButtonState() {
        if let text = currentView.emailTextField.textField.text {
            if text.isEmpty {
                currentView.saveButton.setInvalidState()
            } else {
                currentView.saveButton.setValidState()
            }
        }
    }
}

// MARK: - Textfield delegates
extension ProfileItemVC: UITextFieldDelegate {
    // MARK: Activate button if textfield has name
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            if updatedText.isEmpty {
                currentView.saveButton.setInvalidState()
            } else {
                currentView.saveButton.setValidState()
            }
        }
        return true
    }
}
