//
//  LoginView.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit

class LoginView: UIView {
    
    let loginNav = DINavControl(title: "Login", isBack: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogin() {
        addSubview(loginNav)
        loginNav.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }

}
