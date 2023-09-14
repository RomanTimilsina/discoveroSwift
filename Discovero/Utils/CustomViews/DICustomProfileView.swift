//
//  DICustomProfileView.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class DICustomProfileView: UIView {
    
    var profileTap: ((String?) -> Void)?
    
    let title = UILabel(text: "",color: Color.appWhite, font: OpenSans.semiBold, size: 14)
    let subTitle = UILabel(text: "",color: Color.appWhite, font: OpenSans.regular, size: 14)
    
    let nationImageView = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
    lazy var subStack = HorizontalStackView(arrangedSubViews: [subTitle, nationImageView,UIView()], spacing: 10)
    lazy var nameStack = VerticalStackView(arrangedSubViews: [title, subStack], spacing: 0)
    
    let rightArrowImage = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
    
    lazy var mainStack = HorizontalStackView(arrangedSubViews: [nameStack, UIView(), rightArrowImage], spacing: 0)
    
    init(titleText: String, text: String, nation: UIImage? = nil, show:Bool? = false, isGrey: Bool? = false) {
        super.init(frame: .zero)
        title.text = titleText
        subTitle.text = text
        subTitle.textColor = Color.appWhite
        nationImageView.image = nation
            if isGrey == true {
                title.textColor = Color.gray400
                subTitle.textColor = Color.gray500
            }
        if text.isEmpty  {
            title.font = UIFont.font(with: 16, family: OpenSans.semiBold)
            subTitle.isHidden = true
        }
        
        if show == true {
            rightArrowImage.image = UIImage(named: "rightArrow")
        }
        setupConstraints()
    }
    
    func setupConstraints () {
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
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
}
