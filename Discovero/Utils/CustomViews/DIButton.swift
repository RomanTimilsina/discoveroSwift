//
//  DIButton.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class DIButton : UIButton {
    
    init(buttonTitle: String, height: CGFloat = 44, textSize: CGFloat = 16, blackButton: Bool = false) {
        super.init(frame: .zero)
        setupUI(buttonTitle: buttonTitle, textSize: textSize)
        constraintHeight(constant: height)
        if blackButton {
            setBlackButton()
        }
    }
    
    func setupUI(buttonTitle: String, textSize: CGFloat) {
        setTitle(buttonTitle, for: .normal)
        setTitleColor(Color.appBlack, for: .normal)
        titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: textSize)
        layer.cornerRadius = 5
        backgroundColor = Color.primary
    }
    
    func setBlackButton() {
        backgroundColor = Color.appBlack
        setTitleColor(Color.appWhite, for: .normal)
        layer.borderColor = Color.appWhite.cgColor
        layer.borderWidth = 1
    }
    
    func setInvalidState() {
        backgroundColor = Color.primary?.withAlphaComponent(0.4)
        isEnabled = false
    }
    
    func setValidState() {
        backgroundColor = Color.primary
        isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
