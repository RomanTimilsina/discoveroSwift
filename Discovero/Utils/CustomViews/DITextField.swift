//
//  DiscoveroView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class DITextField: UIView {
    
    var handleCountryCode: (() -> Void)?
    
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
    let textFieldCoverLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    let flagImageView = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
    let countryCodeLabel = UILabel(text: "", color: Color.primary, font: OpenSans.regular, size: 32)
    var searchText: String = "Search for country"
    var button = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 0)
    var textfieldFontSize = 32
    var myConstraints: [NSLayoutConstraint] = []
    
    lazy var textCover = HorizontalStackView(arrangedSubViews: [textFieldCoverLabel, flagImageView], spacing: 5, distribution: .equalCentering)
    let lineView = UIView()
    let otpTextfield = DIOTPField()
    var lineBool = true
    
    init(title: String,
         placholder: String,
         isPrimaryColor: Bool = false,
         typePad: UIKeyboardType,
         isOtpTextField: Bool = true,
         contentHeight: CGFloat = 74,
         placeholderHeight: CGFloat = 32,
         textHeight: CGFloat = 24,
         countryCode: String = "",
         searchLabel: String = "Search for country",
         lineColor: UIColor = .clear,
         isButton: Bool = false,
         hasLine: Bool = true
    ) {
        lineBool = hasLine
        lineView.backgroundColor = lineColor
        titleLabel.text = title
        titleLabel.textColor = Color.appWhite
        textField.placeholder = placholder
        textField.textColor = isPrimaryColor ? Color.primary : Color.appWhite
        textField.tintColor = Color.appWhite
        textField.keyboardType = typePad
        textField.font = UIFont.font(with: CGFloat(textfieldFontSize), family: OpenSans.regular)
        titleLabel.font = UIFont.font(with: textHeight, family: OpenSans.regular)
        otpTextfield.isHidden = isOtpTextField
        textField.isHidden = !isOtpTextField
        contentVeiw.constraintHeight(constant: contentHeight)
        
        super.init(frame: .zero)
        textFieldAttribute(placeholderText: placholder, placeholderHeight: placeholderHeight)
        countryCodeLabel.text = countryCode
        if countryCode.isEmpty {
            countryCodeLabel.isHidden = true
        }
        setConstraint()
        textFieldCoverLabel.font = UIFont.font(with: 24, family: OpenSans.regular)
        textFieldCoverLabel.tintColor = Color.appWhite
        searchText = searchLabel
        
        observeEvents()
        textField.isEnabled = true
        if isButton {
            addSubview(button)
            button.fillSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {
        addSubview(contentVeiw)
        contentVeiw.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        contentVeiw.addSubview(titleLabel)
        titleLabel.anchor(top: contentVeiw.topAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        contentVeiw.addSubview(countryCodeLabel)
        countryCodeLabel.anchor(top: titleLabel.bottomAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        contentVeiw.addSubview(textField)
        textField.anchor(top: titleLabel.bottomAnchor, leading: countryCodeLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        countryCodeLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        textField.constraintHeight(constant: 30)
        
        contentVeiw.addSubview(textCover)
        textCover.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        flagImageView.constraintHeight(constant: 25)
        
        contentVeiw.addSubview(otpTextfield)
        otpTextfield.anchor(top: titleLabel.bottomAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        otpTextfield.constraintWidth(constant: 237)
        otpTextfield.constraintHeight(constant: 46)
        
        if lineBool {
            addSubview(lineView)
            let constraint = lineView.anchor(top: contentVeiw.bottomAnchor, leading: contentVeiw.leadingAnchor, bottom: nil, trailing: contentVeiw.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
            lineView.constraintHeight(constant: 2)
            lineView.backgroundColor = Color.gray800
        }
        
    }
    
    func observeEvents() {
        let countryCodeTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCountryCode))
        countryCodeLabel.addGestureRecognizer(countryCodeTapGesture)
        countryCodeLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapCountryCode() {
        handleCountryCode?()
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
