//
//  otpConfirm.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class OTPConfirmView: UIView {
    var didNotReceiveCode: (() -> Void)?
    var onNextClick: ((String) -> Void)?
    
    let headerView = DIHeaderView(title: "Confirm your number", hasBack: true)
    let view = UIView()
    let getStartedLabel = UILabel(text: "Confirm your number", font: OpenSans.semiBold, size: 14)
    let codeTextField = DITextField(title: "Enter the 6 digit code", placholder: "0000 000 000", isPrimaryColor: true, typePad: .numberPad, isOtpTextField: false, contentHeight: 90)
    let titleDescLabel = UILabel(text: "We’ll call or text to confirm your number. Standard message and data rates apply.",color: Color.appWhite, font: OpenSans.regular, size: 12, numberOfLines: 0, alignment: .left)
    let codeNotReceivedLabel = UILabel(text: "I didn't receive a code",color: Color.primary, font: OpenSans.semiBold, size: 14)
    let nextButton = DIButton(buttonTitle: "Next")
    let alert = UIAlertController(title: "Alert Title", message: "Can't select more than 3 languages", preferredStyle: .alert)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupUI()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 13, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerView.topAnchor, trailing: trailingAnchor)
        view.backgroundColor = Color.gray900
        
        addSubview(getStartedLabel)
        getStartedLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(codeTextField)
        codeTextField.anchor(top: getStartedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        addSubview(titleDescLabel)
        titleDescLabel.anchor(top: codeTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 12, bottom: 0, right: 18))
        
        addSubview(nextButton)
        nextButton.anchor(top: titleDescLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        
        addSubview(codeNotReceivedLabel)
        codeNotReceivedLabel.anchor(top: nextButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        codeNotReceivedLabel.centerXInSuperview()
    }
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // Handle OK button tap here
        print("OK button tapped")
    }
    
    private func observeEvents() {
        let resendCode = UITapGestureRecognizer(target: self, action: #selector(handleResendCode))
        codeNotReceivedLabel.addGestureRecognizer(resendCode)
        codeNotReceivedLabel.isUserInteractionEnabled = true
        
        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        
        alert.addAction(okAction)
    }
    
    @objc func handleNextButton() {
        onNextClick?(codeTextField.otpTextfield.text ?? "")
    }
    
    @objc func handleResendCode() {
        didNotReceiveCode?()
    }
}
