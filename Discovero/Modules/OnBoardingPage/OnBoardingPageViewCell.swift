//
//  registerPage.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class OnBoardingPageViewCell: UICollectionViewCell {
    
    let onboardingPageImage : UIImageView = {
        let onboardingPageImage = UIImageView()
        onboardingPageImage.contentMode = .scaleAspectFit
        return onboardingPageImage
    }()
    
    let icon : UIImageView = {
       let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    let findRoomLabel = UILabel(text: "", font: OpenSans.regular, size: 24, alignment: .center)
    
    let roomDescriptionLabel = UILabel(text:"", font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .center)
    
//    let accountQueryLabel = UILabel(text: "Already have an account?", font: OpenSans.regular, size: 18)
//
//    let logInButton = UIButton(title: "Log In", titleColor: Color.primary, font: OpenSans.regular, fontSize: 18)
//
//    let registerButton = DIButton(buttonTitle: "Register")
//
//    lazy var logInStack = HorizontalStackView(arrangedSubViews: [accountQueryLabel, logInButton], spacing: 5, distribution: .equalCentering)
//
    lazy var onBoardingViewStack = VerticalStackView(arrangedSubViews: [onboardingPageImage, icon, findRoomLabel,  roomDescriptionLabel], spacing: 24)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setupUI()
    }
        
    func setupUI() {
        onBoardingViewStack.setCustomSpacing(59, after: onboardingPageImage)
        addSubview(onBoardingViewStack)
        onBoardingViewStack.anchor(top: safeAreaLayoutGuide.topAnchor , leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 103, left: 10, bottom: 10, right: 10))
        
//        addSubview(registerButton)
//        registerButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 126, right: 10))
//
//        addSubview(logInStack)
//        logInStack.anchor(top: registerButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 19, left: 10, bottom: 0, right: 10))
//        logInStack.centerXInSuperview()
    }
    
    func configureCellData(data: onBoardingCollectionModel){
        onboardingPageImage.image = data.image
        icon.image = data.icons
        findRoomLabel.text = data.title
        roomDescriptionLabel.text = data.description

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
