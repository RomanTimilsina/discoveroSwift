//
//  PersonalInfo.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class RegistrationView: UIView {
    
    var openPicker: (() -> Void)?
    
    var viewTap: ((UITapGestureRecognizer) -> Void)?
    let headerView = DIHeaderView(title: "Registration", isBack: false)
    let smallLabel = UILabel(text: "Few more things", font: OpenSans.regular, size: 14)
    let personalInfoTextField = DITextField(title: "What's your name?", placholder: "Name goes here", isPrimaryColor: false, typePad: .default, contentHeight: 68, placeholderHeight: 24)
    let pickerTextField = DITextField(title: "Select language you know", placholder: "Tap here to chose", isPrimaryColor: false, typePad: .default, contentHeight: 76, placeholderHeight: 24)
    let headerLabel = UILabel(text: "Choose your nationality", font: OpenSans.bold, size: 20)
    let termsAndPolicyLabel = UILabel(text: "By signing up you agree to discovero’s",color: Color.appWhite, font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .center)
    let text =  "Terms of Use and Privacy Policy"
//    let label: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: OpenSans.regular, size: 12)
//        return label
//    }()
    let termsAndPolicyLabel2 = UILabel(text: "", font: OpenSans.regular, size: 14)
    let signUpButton = DIButton(buttonTitle: "Sign Up")
    let pickerHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    let crossIcon = UIImageView(image: UIImage(named: "crossIcon"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let chooseNationalityLabel = UILabel(text: "Choose your nationality", font: OpenSans.semiBold, size: 16)
    let nextButton = UIButton(title: "Next", titleColor: Color.appWhite, font: OpenSans.bold, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogin()
        observeEvent()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
        pickerTextField.textField.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogin() {
        addSubview(headerView)
        headerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 45, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        
        addSubview(smallLabel)
        smallLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(personalInfoTextField)
        personalInfoTextField.anchor(top: smallLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: -100, right: 0))
        
        addSubview(pickerTextField)
        pickerTextField.anchor(top: personalInfoTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 12, bottom: 0, right: 12))
        pickerTextField.constraintHeight(constant: 100)
        
        addSubview(signUpButton)
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,  padding: .init(top: 0, left: 12, bottom: 10, right: 12))
        signUpButton.constraintHeight(constant: 44)
        
        let colorsAndSubstrings: [(UIColor?, String)] = [
            (Color.primary, "Terms of Use"),
            (Color.appWhite, "and"),
            (Color.primary, "Privacy Policy")
        ]
        
        applyColorsAndBold(toLabel: termsAndPolicyLabel2, text: text, colorsAndSubstrings: colorsAndSubstrings)
        
        addSubview(termsAndPolicyLabel2)
        termsAndPolicyLabel2.anchor(top: nil, leading: nil, bottom: signUpButton.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        termsAndPolicyLabel2.centerXInSuperview()
        
        addSubview(termsAndPolicyLabel)
        termsAndPolicyLabel.anchor(top: nil, leading: nil, bottom: termsAndPolicyLabel2.topAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        termsAndPolicyLabel.centerXInSuperview()
    }
    
    func observeEvent() {
        let pickerTextFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTextfield))
        pickerTextField.addGestureRecognizer(pickerTextFieldTapGesture)
        pickerTextField.isUserInteractionEnabled = true
        
    }
    
    
    func applyColorsAndBold(toLabel label: UILabel, text: String, colorsAndSubstrings: [(color: UIColor?, substring: String)]) {
        let excludedWords = "and"
        let attributedText = NSMutableAttributedString(string: text)
        
        for (color, substring) in colorsAndSubstrings {
            let range = (text as NSString).range(of: substring)
            attributedText.addAttribute(.foregroundColor, value: color ?? UIColor(), range: range)
            
            if !excludedWords.contains(substring) {
                let boldFont = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                attributedText.addAttribute(.font, value: boldFont, range: range)
            }
            }
        
        label.attributedText = attributedText
    }

}

//Mark: Every handling function
extension RegistrationView {
    @objc func tapTextfield() {
        openPicker?()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        viewTap?(gesture)
    }
}


