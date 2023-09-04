//
//  OnBoardingPageView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class OnBoardingPageView: UIView {

    let onBoardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Color.appBlack
        view.isPagingEnabled = true
        return view
    }()
    
    let indicator : DIPageController = {
        let page = DIPageController()
        page.numberOfPages = 4
        page.currentPageImage = UIImage(named: "currentPageIcon")
        page.otherPagesImage = UIImage(named: "otherPageIcon")
        return page
    }()
    
    let accountQueryLabel = UILabel(text: "Already have an account?", font: OpenSans.regular, size: 18)
    
    let logInButton = UIButton(title: "Log In", titleColor: Color.primary, font: OpenSans.regular, fontSize: 18)
    
    let registerButton = DIButton(buttonTitle: "Register")
    
    lazy var logInStack = HorizontalStackView(arrangedSubViews: [accountQueryLabel, logInButton], spacing: 5, distribution: .equalCentering)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.appBlack
        setupUI()
    }
    
    func setupUI() {
        addSubview(logInStack)
        logInStack.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        logInStack.centerXInSuperview()
        
        addSubview(registerButton)
        registerButton.anchor(top: nil, leading: leadingAnchor, bottom: logInStack.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 19, right: 10))
        
        
        
        addSubview(indicator)
        indicator.anchor(top: onBoardingCollection.bottomAnchor, leading: nil, bottom: registerButton.topAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 20, right: 10))
        indicator.constraintHeight(constant: 1)
        indicator.centerXInSuperview()
        
        addSubview(onBoardingCollection)
        onBoardingCollection.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: indicator.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
