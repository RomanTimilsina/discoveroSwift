//
//  DICustomProfileView.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class DICustomProfileView: UIView {
    
    var profileTap: ((String?) -> Void)?
    var onClick: (() -> Void)?
    
    let title = UILabel(text: "",color: Color.appWhite, font: OpenSans.semiBold, size: 14)
    let coverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let subTitle = UILabel(text: "",color: Color.appWhite, font: OpenSans.regular, size: 14)
    let nationImageView = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
    lazy var subStack = HorizontalStackView(arrangedSubViews: [subTitle, nationImageView,UIView()], spacing: 10)
    lazy var nameStack = VerticalStackView(arrangedSubViews: [title, subStack], spacing: 0)
    
    let rightArrowImage = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
    let sideTitle = UILabel(text: "Select your location",color: Color.appWhite, font: OpenSans.regular, size: 14)
    let lineView = UIView(color: Color.gray800)
    lazy var mainStack = HorizontalStackView(arrangedSubViews: [nameStack, UIView(), sideTitle, rightArrowImage], spacing: 8)
    let button = UIButton()
    
    init(hasButtonProperty: Bool = false,
        titleText: String,
         text: String,
         nation: UIImage? = nil,
         show:Bool? = false,
         isGrey: Bool? = false,
         sideTitleString: String = "",
         isInFilter: Bool = false
    ) {
        super.init(frame: .zero)
        title.text = titleText
        subTitle.textColor = Color.appWhite
        nationImageView.image = nation
        sideTitle.text = sideTitleString
        sideTitle.textColor = Color.gray400
        if isGrey == true {
            title.textColor = Color.gray400
            subTitle.textColor = Color.gray500
        }
        
        if isInFilter {
            subTitle.constraintHeight(constant: 30)
            subTitle.font = UIFont.font(with: 16, family: OpenSans.regular)
            title.font = UIFont.font(with: 16, family: OpenSans.semiBold)
        }
        
        if text.isEmpty  {
            title.font = UIFont.font(with: 16, family: OpenSans.semiBold)
        }
        
        if show == true {
            rightArrowImage.image = UIImage(named: "rightArrow")
        }
        
        setupConstraints()
        
        if hasButtonProperty {
            addSubview(button)
            button.fillSuperview()
        }
    }
    
    func setupConstraints () {
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(lineView)
        lineView.anchor(top: mainStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        lineView.constraintHeight(constant: 2)
        
        addSubview(coverButton)
        coverButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        coverButton.backgroundColor = .clear
        coverButton.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        mainStack.addGestureRecognizer(tapGesture)
        mainStack.isUserInteractionEnabled = true
    }
    
    @objc func onTap() {
        profileTap?(title.text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func openTap() {
        print("Open tap")
    }
}

