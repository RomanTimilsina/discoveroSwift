//
//  CustomAdView.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class CustomAdView: UIView {
    
    var handleViewMore: (() -> Void)?
    
    let leftImage = UIImageView(image: UIImage(named: "leftAdImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let adTitlle = UILabel(text: "", font: OpenSans.semiBold, size: 16)
    let smallGrayView = UIView(color: Color.gray600, cornerRadius: 3)
    let adText = UILabel(text: "Ad", color: Color.appWhite, font: OpenSans.semiBold, size: 12)
    lazy var titleStack = HorizontalStackView(arrangedSubViews: [adTitlle, smallGrayView], spacing: 8)
    let adDescription = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let viewMoreButton = UILabel(text: "View More", color: Color.appBlue, font: OpenSans.semiBold, size: 14)
    let rightImage = UIImageView(image: UIImage(named: "rightAdImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    
    lazy var verticalStack = VerticalStackView(arrangedSubViews: [titleStack, adDescription, viewMoreButton],spacing: 3)
    
    lazy var horizontalStack = HorizontalStackView(arrangedSubViews: [leftImage, verticalStack, UIView(), rightImage], spacing: 12)
    
    init(_ title: String,_ description: String, _ leftImg: UIImage? = nil,_ rightImg: UIImage? = nil) {
        super.init(frame: .zero)
        
        adTitlle.text = title
        adDescription.text = description
        leftImage.image = leftImg
        rightImage.image = rightImg
        
        smallGrayView.addSubview(adText)
        backgroundColor = Color.gray800
        setupConstraint()
    }
    
    func setupConstraint() {
        smallGrayView.constraintHeight(constant: 16)
        //        smallView.constraintWidth(constant: 24)
        
        adText.centerInSuperview()
        
        addSubview(horizontalStack)
        horizontalStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        let viewMoreTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewMoreTap))
        viewMoreButton.addGestureRecognizer(viewMoreTapGesture)
        viewMoreButton.isUserInteractionEnabled = true
    }
    
    @objc func viewMoreTap() {
        handleViewMore?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
