//
//  CustomAdView.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class CustomAdView: UIView {

    let leftImage = UIImageView(image: UIImage(named: "leftAdImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let adTitlle = UILabel(text: "", font: OpenSans.semiBold, size: 16)
    let smallView = UIView(color: Color.gray600, cornerRadius: 3)
    let adText = UILabel(text: "Ad", color: Color.appWhite, font: OpenSans.semiBold, size: 12)
    lazy var titleStack = HorizontalStackView(arrangedSubViews: [adTitlle,smallView], spacing: 8)
    let adDescriptin = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let button = UILabel(text: "View More", color: Color.appBlue, font: OpenSans.semiBold, size: 14)
    let rightImage = UIImageView(image: UIImage(named: "rightAdImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    
    lazy var verticalStack = VerticalStackView(arrangedSubViews: [titleStack, adDescriptin,button],spacing: 3)
    
    lazy var horizontalStack = HorizontalStackView(arrangedSubViews: [leftImage,verticalStack, UIView(), rightImage], spacing: 12)
    
    init(_ title: String,_ description: String, _ leftImg: UIImage? = nil,_ rightImg: UIImage? = nil) {
        super.init(frame: .zero)
        
        adTitlle.text = title
        adDescriptin.text = description
        leftImage.image = leftImg
        rightImage.image = rightImg

        smallView.addSubview(adText)
        backgroundColor = Color.gray800
        setupConstraint()
    }
    
    func setupConstraint() {
        smallView.constraintHeight(constant: 16)
//        smallView.constraintWidth(constant: 24)
        
        adText.centerInSuperview()
        
        addSubview(horizontalStack)
        horizontalStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 12, bottom: 0, right: 12))
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
