//
//  LoginView.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginView: UIView {
    
    let headerView = DIHeaderView(title: "Verify your number", isBack: false)
    
    let getStartedLabel = UILabel(text: "Let's get started", font: OpenSans.semiBold, size: 14)
    
    let loginTextField = DITextField(title: "What’s your phone number?", placholder: "0000 000 000", isPrimaryColor: true, typePad: .numberPad)
    
    let dataRateLabel = UILabel(text: "We’ll call or text to confirm your number. Standard message and data rates apply.",color: Color.appWhite, font: OpenSans.regular, size: 12, numberOfLines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogin() {
        addSubview(headerView)
        headerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 45, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        
        addSubview(getStartedLabel)
        getStartedLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(loginTextField)
        loginTextField.anchor(top: getStartedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        addSubview(dataRateLabel)
        dataRateLabel.anchor(top: loginTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 18))
    }
}

