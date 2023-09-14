//
//  otpConfirm.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class OTPConfirmView: UIView {
    
    let headerView = DIHeaderView(title: "Confirm your number", hasBack: false)
    let view = UIView()
    let getStartedLabel = UILabel(text: "Confirm your number", font: OpenSans.semiBold, size: 14)
    let codeTextField = DITextField(title: "Ener the 6 digit code", placholder: "0000 000 000", isPrimaryColor: true, typePad: .numberPad, isOtpTextField: false, contentHeight: 90)
    let titleDescLabel = UILabel(text: "We’ll call or text to confirm your number. Standard message and data rates apply.",color: Color.appWhite, font: OpenSans.regular, size: 12, numberOfLines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setupUI()
       
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
    }
}
