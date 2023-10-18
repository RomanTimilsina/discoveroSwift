//
//  OnBoardingPageView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class OnBoardingPageView: UIView {
    
    var onRegisterClicked: (() -> Void)?
    var onLoginClicked: (() -> Void)?
    
    let onboardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Color.gray900
        view.isPagingEnabled = true
        return view
    }()
    
    let indicator: DIPageController = {
        let page = DIPageController()
        page.numberOfPages = 4
        return page
    }()
    
    let accountDescLabel = UILabel(text: "Already have an account?", font: OpenSans.regular, size: 18)
    let logInButton = UIButton(title: "Log In", titleColor: Color.primary, font: OpenSans.regular, fontSize: 18)
    let registerButton = DIButton(buttonTitle: "Register")
    lazy var logInStack = HorizontalStackView(arrangedSubViews: [accountDescLabel, logInButton], spacing: 5, distribution: .equalCentering)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupUI()
    }
    
    func setupUI() {
        addSubview(logInStack)
        logInStack.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        logInStack.centerXInSuperview()
        logInButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        addSubview(registerButton)
        registerButton.anchor(top: nil, leading: leadingAnchor, bottom: logInStack.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 19, right: 12))
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        addSubview(indicator)
        indicator.anchor(top: registerButton.topAnchor, leading: leadingAnchor, bottom: registerButton.topAnchor, trailing: trailingAnchor, padding: .init(top: -33, left: 12, bottom: 20, right: 12))
        indicator.centerXInSuperview()
        
        addSubview(onboardingCollection)
        onboardingCollection.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: indicator.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 60, right: 12))
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Action function
private extension OnBoardingPageView {
    
    @objc func handleRegister() {
        onRegisterClicked?()
    }
    
    @objc func handleLogin() {
        onLoginClicked?()
    }
}
