//
//  LoginView.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginView: UIView {
    
    var handleConfirmOTP: (() -> Void)?
    
    let view = UIView()
    
    let headerView = DIHeaderView(title: "Verify your number", hasBack: false, hasBGColor: true)
    
    let getStartedLabel = UILabel(text: "Let's get started", font: OpenSans.semiBold, size: 14)
    
    let phoneNumberTextField = DITextField(title: "What’s your phone number?", placholder: "0000 000 000", isPrimaryColor: true, typePad: .numberPad)
    
    let noticeLabel = UILabel(text: "We’ll call or text to confirm your number. Standard message and data rates apply.",color: Color.appWhite, font: OpenSans.regular, size: 12, numberOfLines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogin()
        backgroundColor = Color.appBlack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogin() {
      
       
        addSubview(headerView)
        headerView.anchor(top:safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 13, left: 0, bottom: 0, right: 0))
//        headerView.constraintHeight(constant: 40)
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ))
        view.backgroundColor = Color.gray900
        
        addSubview(getStartedLabel)
        getStartedLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(phoneNumberTextField)
        phoneNumberTextField.anchor(top: getStartedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        phoneNumberTextField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        addSubview(noticeLabel)
        noticeLabel.anchor(top: phoneNumberTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 18))
    }
    
    @objc func textChanged(_ textfield: UITextField) {
        if let enteredText = textfield.text {
            if enteredText.count > 9 {
                handleConfirmOTP?()
            }
        }
    }
}
