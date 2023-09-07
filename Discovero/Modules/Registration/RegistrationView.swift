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
    
    let termsAndPolicyLabel1 = UILabel(text: "By signing up you agree to discovero’s",color: Color.appWhite, font: OpenSans.regular, size: 14)
    
    let termsAndPPolicyLabel2 = UILabel(text: "Terms of Use", color: Color.primary, font: OpenSans.regular, size: 14)
    
    let and = UILabel(text: "and", color: Color.appWhite, font: OpenSans.regular, size: 14)
    
    let termsAndPPolicyLabel3 = UILabel(text: "Privacy Policy", color: Color.primary, font: OpenSans.regular, size: 14)
    
    lazy var StackForTermsPolicy = HorizontalStackView(arrangedSubViews: [UIView(),termsAndPPolicyLabel2, and,termsAndPPolicyLabel3, UIView()], spacing: 5, distribution: .fill)
    
    let signUpButton = DIButton(buttonTitle: "Sign Up")
    
    let pickerHeaderView: UIView = {
        let view = UIView()
        
        return view
    }()
    let crossIcon = UIImageView(image: UIImage(named: "crossIcon"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let chooseNationalityLabel = UILabel(text: "Choose your nationality", font: OpenSans.semiBold, size: 16)
    let nextButton = UIButton(title: "Next", titleColor: Color.appWhite, font: OpenSans.bold, fontSize: 14)
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
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
        
//        pickerHeaderView.addSubview(crossIcon)
//        crossIcon.anchor(top: pickerHeaderView.topAnchor, leading: pickerHeaderView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 31, left: 12, bottom: 0, right: 0))
//        crossIcon.image?.withRenderingMode(.alwaysTemplate)
//        crossIcon.constraintHeight(constant: 10)
//        crossIcon.constraintWidth(constant: 10)
////        
//        pickerHeaderView.addSubview(chooseNationalityLabel)
//        chooseNationalityLabel.anchor(top: pickerHeaderView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 31, left: 0, bottom: 0, right: 0))
//        chooseNationalityLabel.centerInSuperview()
//        
//        pickerHeaderView.addSubview(nextButton)
//        nextButton.anchor(top: pickerHeaderView.topAnchor, leading: nil, bottom: nil, trailing: pickerHeaderView.trailingAnchor, padding: .init(top: 31, left: 0, bottom: 0, right: 14))
//        pickerHeaderView.constraintHeight(constant: 100)
        
        addSubview(signUpButton)
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,  padding: .init(top: 0, left: 12, bottom: 10, right: 12))
        signUpButton.constraintHeight(constant: 44)
        
        addSubview(StackForTermsPolicy)
        StackForTermsPolicy.anchor(top: nil, leading: nil, bottom: signUpButton.topAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        StackForTermsPolicy.centerXInSuperview()
        
        addSubview(termsAndPolicyLabel1)
        termsAndPolicyLabel1.anchor(top: nil, leading: nil, bottom: StackForTermsPolicy.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 3, right: 0))
        termsAndPolicyLabel1.centerXInSuperview()
    }
    
    func observeEvent() {
        let pickerTextFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTextfield))
        pickerTextField.addGestureRecognizer(pickerTextFieldTapGesture)
        pickerTextField.isUserInteractionEnabled = true
        
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
    
    
