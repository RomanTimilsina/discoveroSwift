//
//  DiscoveroView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class DITextField: UIView {
    
    let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "OpenSans-Regular", size: 24)
        return title
    }()
    
    let textField : UITextField = {
        let TF = UITextField()
        TF.font = UIFont(name: "OpenSans-Regular", size: 24)
        return TF
    }()
    
    let notReceiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("I didn't receive a code", for: .normal)
        return  button
    }()
    
//    let otpTextfield = DIOTPField()
    
    init(title: String, placholder: String, isPrimaryColor: Bool, typePad: UIKeyboardType, isOtpTextField: Bool = true) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = Color.appWhite
        
        textField.placeholder = placholder
        textField.textColor = isPrimaryColor ? Color.primary : Color.appWhite
        textFieldAttribute(placeholderText: placholder)
        textField.tintColor = Color.appWhite
        textField.keyboardType = typePad
//        otpTextfield.isHidden = !isOtpTextField
        textField.isHidden = isOtpTextField
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {
        addSubview(titleLabel)
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        addSubview(textField)
        textField.anchor(top: titleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 0, bottom: 20, right: 0))
        
//        addSubview(otpTextfield)
//        otpTextfield.anchor(top: titleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 0, bottom: 20, right: 0))
    }
    
    func textFieldAttribute(placeholderText: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.placeholderGray ?? .gray,
            .font: UIFont(name: "OpenSans-regular", size: 32) ?? UIFont()
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        
        textField.attributedPlaceholder = attributedPlaceholder
    }
}
