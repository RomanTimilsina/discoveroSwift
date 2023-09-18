//
//  PersonalInfo.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class RegistrationView: UIView {
    
    var openPicker: (() -> Void)?
    var handleSignUp: ((String?) -> Void)?
    
    var overlayViewTap: ((UITapGestureRecognizer) -> Void)?
    let headerView = DIHeaderView(title: "Registration", hasBack: false)
    let view = UIView()
    let smallLabel = UILabel(text: "Few more things", font: OpenSans.regular, size: 14)
    let personalInfoTextField = DITextField(title: "What's your name?", placholder: "Name goes here", isPrimaryColor: false, typePad: .default, contentHeight: 68, placeholderHeight: 24)
    let pickerTextField = DITextField(title: "Select language you know", placholder: "Tap here to chose", isPrimaryColor: false, typePad: .default, contentHeight: 76, placeholderHeight: 24)
    let picker = DICustomProfileView(titleText: "Select language you know", text: "")
    let headerLabel = UILabel(text: "Choose your nationality", font: OpenSans.bold, size: 20)
    let termsAndPolicyLabel = UILabel(text: "By signing up you agree to discovero’s",color: Color.appWhite, font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .center)
    let text =  "Terms of Use and Privacy Policy"
    let termsAndPolicyLabel2 = UILabel(text: "", font: OpenSans.regular, size: 14, alignment: .center)
    let signUpButton = DIButton(buttonTitle: "Sign Up")
    lazy var verticalStack = VerticalStackView(arrangedSubViews: [termsAndPolicyLabel, termsAndPolicyLabel2, signUpButton], spacing: 8)
    let pickerHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    let overlayView = UIView(color: UIColor.clear)
    let crossIcon = UIImageView(image: UIImage(named: "crossIcon"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let chooseNationalityLabel = UILabel(text: "Choose your nationality", font: OpenSans.semiBold, size: 16)
    let nextButton = UIButton(title: "Next", titleColor: Color.appWhite, font: OpenSans.bold, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        signUpButton.setInvalidState()
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
        addSubview(overlayView)
        overlayView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        let overlayViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        overlayView.addGestureRecognizer(overlayViewTap)
        
        addSubview(headerView)
        headerView.anchor(top:  safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ))
        view.backgroundColor = Color.gray900
        
        
        addSubview(smallLabel)
        smallLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 78, left: 12, bottom: 0, right: 0))
        
        addSubview(personalInfoTextField)
        personalInfoTextField.anchor(top: smallLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        addSubview(pickerTextField)
        pickerTextField.anchor(top: personalInfoTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 12, bottom: 0, right: 12))
        pickerTextField.constraintHeight(constant: 100)
        
        addSubview(verticalStack)
        verticalStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,  padding: .init(top: 0, left: 12, bottom: 40, right: 12))
        
        let colorsAndSubstrings: [(UIColor?, String)] = [
            (Color.primary, "Terms of Use"),
            (Color.appWhite, "and"),
            (Color.primary, "Privacy Policy")
        ]
        applyColorsAndBold(toLabel: termsAndPolicyLabel2, text: text, colorsAndSubstrings: colorsAndSubstrings)
    }
    
    func observeEvent() {
        let pickerTextFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTextfield))
        pickerTextField.addGestureRecognizer(pickerTextFieldTapGesture)
        pickerTextField.isUserInteractionEnabled = true
        
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
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
        overlayViewTap?(gesture)
    }
    
    @objc func signUp() {
        let enteredText = personalInfoTextField.textField.text
        handleSignUp?(enteredText)
    }
    
    @objc func dismissKeyboard() {
        personalInfoTextField.textField.resignFirstResponder()
    }
}
