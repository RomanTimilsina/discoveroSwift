//
//  DINavControl.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class DIHeaderView: UIView {
    
    let view = UIView()
    let anotherView = UIView()
    
    var onClose: (() -> Void)?
    
    let textLabel = UILabel(text: "",color: Color.appWhite, font: OpenSans.semiBold, size: 16, alignment: .center)
    let backLabel = UILabel(text: "Back", color: Color.appWhite, font: OpenSans.regular, size: 12)
    let backImage = UIImageView(image: UIImage(named: "backButtonIcon"), contentMode: .scaleAspectFit)
    lazy var backButtonStack = HorizontalStackView(arrangedSubViews: [backImage, backLabel, UIView()], spacing: 6)
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Color.gray700
        return line
    }()
    //
    init(title: String, hasBack: Bool = true, hasBGColor: Bool = true) {
        super.init(frame: .zero)
        textLabel.text = title
        
        backButtonStack.isHidden = hasBack
        backgroundColor = hasBGColor ? Color.gray900 : Color.appBlack
        view.backgroundColor = hasBGColor ? Color.gray900 : Color.appBlack
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(backButtonStack)
        backButtonStack.constraintHeight(constant: 20)
       
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        textLabel.centerInSuperview()
        
        backButtonStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 0, right: 0))
        backButtonStack.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        backButtonStack.addGestureRecognizer(backButtonTapGesture)
        backButtonStack.isUserInteractionEnabled = true
        
        line.constraintHeight(constant: 1)
        
        addSubview(line)
        line.anchor(top: bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding: .init(top: -1, left: 0, bottom: 0, right:  0))
    }
    
    @objc func close() {
        onClose?()
    }
    
}
