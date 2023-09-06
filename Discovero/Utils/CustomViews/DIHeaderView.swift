//
//  DINavControl.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class DIHeaderView: UIView {
    
    var onClose: (() -> Void)?
    
    let textLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16, alignment: .center)
    
    let backLabel = UIButton(title: "Back", titleColor: Color.appWhite, font: OpenSans.regular, fontSize: 12)
    let backImage = UIImageView(image: UIImage(named: "backButtonIcon"), contentMode: .scaleAspectFit)
    lazy var backButtonStack = HorizontalStackView(arrangedSubViews: [backImage, backLabel, UIView()], spacing: 6)
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Color.gray700
        return line
    }()
                                
    init(title: String, isBack: Bool) {
        super.init(frame: .zero)
        textLabel.text = title
        textLabel.isHidden = isBack
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(backButtonStack)
        backButtonStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        let signUpTextTapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        backButtonStack.addGestureRecognizer(signUpTextTapGesture)
        backButtonStack.isUserInteractionEnabled = true
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        addSubview(line)
        line.anchor(top: textLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top: 10, left: 0, bottom: 0, right:  0))
        line.constraintHeight(constant: 2)

    }
    
    @objc func close() {
        onClose?()
    }
    
}
