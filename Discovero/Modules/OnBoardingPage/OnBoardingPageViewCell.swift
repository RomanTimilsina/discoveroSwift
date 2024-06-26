//
//  registerPage.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class OnBoardingPageViewCell: UICollectionViewCell {
    
    let scrollView = UIScrollView()
    let currentContentView = UIView()
    static var identifier = "OnBoardingPageIdentifier"
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
    let titleLabel = UILabel(text: "", font: OpenSans.regular, size: 24, alignment: .center)
    let titleDescLabel = UILabel(text:"", font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .center)
    lazy var onBoardingViewStack = VerticalStackView(arrangedSubViews: [onboardingPageImage, icon, titleLabel,  titleDescLabel, UIView()], spacing: 24, distribution: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupUI()
    }
    
    func setupUI() {
        onboardingPageImage.constraintHeight(constant: 242)
        icon.constraintHeight(constant: 40)
        titleLabel.constraintHeight(constant: 30)
        
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 103, left: 0, bottom: 40, right: 0))
        
        scrollView.addSubview(currentContentView)
        currentContentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: trailingAnchor,  padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        currentContentView.addSubview(onBoardingViewStack)
        onBoardingViewStack.anchor(top: currentContentView.topAnchor , leading: currentContentView.leadingAnchor, bottom: currentContentView.bottomAnchor, trailing:trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        currentContentView.constraintWidth(constant: UIScreen.main.bounds.width * 0.95)
    }
    
    func configureCellData(data: onBoardingCollectionModel){
        onboardingPageImage.image = data.image
        icon.image = data.icons
        titleLabel.text = data.title
        titleDescLabel.text = data.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
