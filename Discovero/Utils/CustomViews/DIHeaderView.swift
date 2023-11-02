//
//  DINavControl.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class DIHeaderView: UIView {
    
    var onClose: (() -> Void)?
    
    let textLabel = UILabel(text: "",color: Color.appWhite, font: OpenSans.semiBold, size: 16, alignment: .center)
    let backLabel = UILabel(text: "Back", color: Color.appWhite, font: OpenSans.regular, size: 12)
    let backImage = UIImageView(image: UIImage(named: "backButtonIcon"), contentMode: .scaleAspectFit)
    let cancelLabel = UILabel(text: "Cancel", font: OpenSans.regular, size: 14)
    lazy var backButtonStack = HorizontalStackView(arrangedSubViews: [backImage, backLabel], spacing: 6)
    lazy var mainStack = HorizontalStackView(arrangedSubViews: [backButtonStack, UIView(), textLabel, UIView(), cancelLabel], spacing: 6)
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Color.gray700
        return line
    }()
    
    init(title: String, hasBack: Bool = true, hasBGColor: Bool = true) {
        super.init(frame: .zero)
        textLabel.text = title
        
        backButtonStack.isHidden = !hasBack
        backgroundColor = hasBGColor ? Color.gray900 : Color.appBlack
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(mainStack)
        mainStack.constraintHeight(constant: 20)
        
        textLabel.centerXInSuperview()
        
        mainStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 0, right: 14))
        mainStack.centerYInSuperview()
        
        let backButtonStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClose))
        backButtonStack.addGestureRecognizer(backButtonStackTapGesture)
        backButtonStack.isUserInteractionEnabled = true
        
        let cancelLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClose))
        cancelLabel.addGestureRecognizer(cancelLabelTapGesture)
        cancelLabel.isUserInteractionEnabled = true
        
        line.constraintHeight(constant: 1)
        
        addSubview(line)
        line.anchor(top: bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding: .init(top: -1, left: 0, bottom: 0, right:  0))
    }
    
    @objc func handleClose() {
        onClose?()
    }
}
