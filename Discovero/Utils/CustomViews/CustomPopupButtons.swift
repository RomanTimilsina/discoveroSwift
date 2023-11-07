//
//  CustomPopupView.swift
//  Discovero
//
//  Created by Mac on 02/10/2023.
//

import UIKit

class CustomPopupButtons: UIView {
    
    let buttonLabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.semiBold, size: 14)
    let tick = UIImageView(image: UIImage(systemName: "checkmark") ,contentMode: .scaleAspectFit)
    var ticked: Bool = false
    weak var parentView: ConfigureNotificationView?
    var activated: Bool = false
    
    init(buttonsText: String = "" ,isActivated: Bool = false, isTicked: Bool = false) {
        super.init(frame: .zero)
        ticked = isTicked
        activated = isActivated
        layer.cornerRadius = 12
        buttonLabel.text = buttonsText
        
                backgroundColor = Color.appBlack
                layer.borderWidth = 2
                layer.borderColor = Color.primary?.cgColor
                tick.isHidden = false
            
        print(ticked)
        setupConstraint()
        
        updateButtonAppearance()

    }
    
    func setupConstraint() {
        addSubview(tick)
        tick.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 9, bottom: 0, right: 0  ))
        tick.constraintWidth(constant: 8)
        tick.tintColor = Color.appBlack
//        tick.centerInSuperview()
        
        addSubview(buttonLabel)
        buttonLabel.anchor(top: nil, leading: tick.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 5  ))
    }
    
    func toggle() {
            activated = !activated
        
//            ticked = !ticked
            updateButtonAppearance()
        }

        func updateButtonAppearance() {
            if activated {
                if ticked {
                    backgroundColor = Color.primary
                    layer.borderWidth = 2
                    layer.borderColor = Color.primary?.cgColor
                    buttonLabel.textColor = Color.appBlack
                } else {
                    backgroundColor = Color.appBlack
                    buttonLabel.textColor = Color.primary
                    layer.borderWidth = 2

                    layer.borderColor = Color.primary?.cgColor
                    tick.isHidden = false
                }
            } else {
                backgroundColor = Color.gray500
                layer.borderWidth = 2
                buttonLabel.textColor = Color.appBlack
                layer.borderColor = Color.gray500?.cgColor
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

