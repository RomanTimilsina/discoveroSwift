//
//  DINavControl.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class DINavControl: UIView {
    
    let textLabel = UILabel(text: "", font: OpenSans.regular, size: 22)
    
    let backButton = UIButton(title: "<- Back", titleColor: Color.appWhite, font: OpenSans.regular, fontSize: 16)
    
    
    
    init(title: String, isBack: Bool) {
        super.init(frame: .zero)
        textLabel.text = title
        backButton.isHidden = isBack
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        addSubview(textLabel)
        textLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        textLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}
