//
//  DiscoveroView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class DITextField: UIView {
    
    let contentVeiw = UIView()
    let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.font(with: 24, family: OpenSans.semiBold)
        return title
    }()
    let textField : UITextField = {
        let TF = UITextField()
        TF.font = UIFont.font(with: 32, family: OpenSans.semiBold)
        return TF
    }()
    let notReceiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("I didn't receive a code", for: .normal)
        return  button
    }()
    let otpTextfield = DIOTPField()
    
    init(title: String, placholder: String, isPrimaryColor: Bool, typePad: UIKeyboardType, isOtpTextField: Bool = true, contentHeight: CGFloat = 74, placeholderHeight: CGFloat = 32) {
        titleLabel.text = title
        titleLabel.textColor = Color.appWhite
        textField.placeholder = placholder
        textField.textColor = isPrimaryColor ? Color.primary : Color.appWhite
        textField.tintColor = Color.appWhite
        textField.keyboardType = typePad
        textField.font = UIFont.font(with: 24, family: OpenSans.regular)
        otpTextfield.isHidden = isOtpTextField
        textField.isHidden = !isOtpTextField
        contentVeiw.constraintHeight(constant: contentHeight)
        super.init(frame: .zero)
        textFieldAttribute(placeholderText: placholder, placeholderHeight: placeholderHeight)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {
        addSubview(contentVeiw)
        contentVeiw.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        contentVeiw.addSubview(titleLabel)
        titleLabel.anchor(top: contentVeiw.topAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        contentVeiw.addSubview(textField)
        textField.anchor(top: titleLabel.bottomAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: contentVeiw.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        contentVeiw.addSubview(otpTextfield)
        otpTextfield.anchor(top: titleLabel.bottomAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        otpTextfield.constraintWidth(constant: 237)
        otpTextfield.constraintHeight(constant: 46)
    }
    
    //MARK: Placeholder attribute set
    func textFieldAttribute(placeholderText: String, placeholderHeight: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.placeholderGray ?? .gray,
            .font: UIFont.font(with: placeholderHeight, family: OpenSans.regular)
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        textField.attributedPlaceholder = attributedPlaceholder
    }
}
