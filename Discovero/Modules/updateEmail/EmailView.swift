//
//  EmailView.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class EmailView: UIView {
    
    let header = DIHeaderView(title: "Update Account Details", hasBack: false)
    
    let Field = DITextField(title: "What's your email",  placholder: "email@example.com", typePad: .default, placeholderHeight: 22, textHeight: 22)

    init(title: String, placeholder: String) {
         super.init(frame: .zero)
        Field.titleLabel.text = title
        Field.textField.placeholder = placeholder
        setuConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuConstraints () {
        addSubview(header)
        header.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
//
        addSubview(Field)
        Field.anchor(top: header.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 14, bottom: 0, right: 14))
    }
}
