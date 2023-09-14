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
    let backLabel = UILabel(text: "Back", color: Color.appWhite, font: OpenSans.regular, size: 12)
    let backImage = UIImageView(image: UIImage(named: "backButtonIcon"), contentMode: .scaleAspectFit)
    lazy var backButtonStack = HorizontalStackView(arrangedSubViews: [backImage, backLabel, UIView()], spacing: 6)
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Color.gray700
        return line
    }()
//
    init(title: String, hasBack: Bool = true) {
        super.init(frame: .zero)
        textLabel.text = title
        backButtonStack.isHidden = hasBack
        backgroundColor = Color.gray700
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(backButtonStack)
        backButtonStack.constraintHeight(constant: 20)

        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        
        backButtonStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 14, bottom: 0, right: 0))
        backButtonStack.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
        let signUpTextTapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        backButtonStack.addGestureRecognizer(signUpTextTapGesture)
        backButtonStack.isUserInteractionEnabled = true
//
        addSubview(line)
        line.anchor(top: backButtonStack.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding: .init(top: 10, left: 0, bottom: 0, right:  0))
        line.constraintHeight(constant:0.5)
    }
    
    @objc func close() {
        onClose?()
    }
    
}
