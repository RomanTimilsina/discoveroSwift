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
    lazy var onBoardingViewStack = VerticalStackView(arrangedSubViews: [onboardingPageImage, icon, findRoomLabel,  roomDescriptionLabel, UIView()], spacing: 24, distribution: .fillProportionally)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setupUI()
    }
        
    func setupUI() {
        onboardingPageImage.constraintHeight(constant: 242)
        icon.constraintHeight(constant: 40)
      
        addSubview(onBoardingViewStack)
        onBoardingViewStack.anchor(top: topAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 103, left: 10, bottom: 0, right: 10))
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
