//
//  EmailView.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class ProfileItemView: UIView {
    
    var handleText: ((String) -> Void)?
    let header = DIHeaderView(title: "Update Account Details", hasBack: false)
    let view = UIView()
    let Field = DITextField(title: "What's your email",  placholder: "email@example.com", typePad: .default, placeholderHeight: 22, textHeight: 22)
    
    let saveButton = DIButton(buttonTitle: "Save", textSize: 14)
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        Field.titleLabel.text = title
        Field.textField.placeholder = placeholder
        
        backgroundColor = Color.appBlack
        setuConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuConstraints () {
        addSubview(header)
        header.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: header.topAnchor, trailing: trailingAnchor)
        view.backgroundColor = Color.gray900
        
        addSubview(Field)
        Field.anchor(top: header.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 14, bottom: 0, right: 14))
        Field.textField.addTarget(self, action: #selector(textEntered(_:)), for: .editingChanged)
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
    }
    
    @objc func textEntered(_ textField: UITextField) {
        if let text = textField.text {
            handleText?(text)
        }
    }
}
