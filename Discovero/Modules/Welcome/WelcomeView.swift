//
//  welcomeView.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class WelcomeView: UIView {
    
    let welcomeLabel = UILabel(text: "", font: OpenSans.semiBold, size: 24)
    let profileReadyLabel = UILabel(text: "Your profile is almost ready", font: OpenSans.regular, size: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        addSubview(welcomeLabel)
        welcomeLabel.centerInSuperview()
        
        addSubview(profileReadyLabel)
        profileReadyLabel.anchor(top: welcomeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 7, left: 0, bottom: 0, right: 0))
        profileReadyLabel.centerXInSuperview()
    }
}
