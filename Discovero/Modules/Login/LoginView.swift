//
//  LoginView.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit
import MBProgressHUD

class LoginView: UIView {
    var onNextClick: ((String) -> Void)?
    
    let view = UIView()
    let headerView = DIHeaderView(title: "Verify your number", hasBack: false, hasBGColor: true)
    let getStartedLabel = UILabel(text: "Let's get started", font: OpenSans.semiBold, size: 14)
    let phoneNumberTextField = DITextField(title: "What’s your phone number?", placholder: "0000 000 000", isPrimaryColor: true, typePad: .numberPad, countryCode: "+1")
    let noticeLabel = UILabel(text: "We’ll call or text to confirm your number. Standard message and data rates apply.",color: Color.appWhite, font: OpenSans.regular, size: 12, numberOfLines: 0, alignment: .left)
    let nextButton = DIButton(buttonTitle: "Next")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        observeEvents()
        backgroundColor = Color.gray900
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headerView)
        headerView.anchor(top:safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 13, left: 0, bottom: 0, right: 0))
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ))
        view.backgroundColor = Color.gray900
        
        addSubview(getStartedLabel)
        getStartedLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(phoneNumberTextField)
        phoneNumberTextField.anchor(top: getStartedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        addSubview(noticeLabel)
        noticeLabel.anchor(top: phoneNumberTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 18))
        
        addSubview(nextButton)
        nextButton.anchor(top: noticeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 12))
    }
    
    private func observeEvents() {
        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        
        phoneNumberTextField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }
    
    @objc func handleNextButton() {
        onNextClick?(phoneNumberTextField.textField.text?.replacingOccurrences(of: " ", with: "") ?? "")
    }
}

//MARK: for space between phone number
extension LoginView {
    @objc func textChanged(_ textField: UITextField) {
        if let enteredText = textField.text {
            let unformattedText = enteredText.replacingOccurrences(of: " ", with: "")
            if unformattedText.count > 10 {
                let truncatedText = String(unformattedText.prefix(10))
                let formattedText = formatPhoneNumber(truncatedText)
                textField.text = formattedText
            } else {
                let formattedText = formatPhoneNumber(unformattedText)
                textField.text = formattedText
            }
        }
    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var formattedPhoneNumber = ""
        for (index, character) in phoneNumber.enumerated() {
            if index > 0 && (index == 4) {
                formattedPhoneNumber += " "
            }
            if index > 0 && (index == 7) {
                formattedPhoneNumber += " "
            }
            formattedPhoneNumber.append(character)
        }
        return formattedPhoneNumber
    }
}

