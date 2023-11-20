//
//  EmailView.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class ProfileItemView: UIView {
    
    var onClickedText: ((String) -> Void)?
    var onClickedSave: ((String) -> Void)?
    
    let header = DIHeaderView(title: "Update Account Details", hasBack: false)
    let editTextField = DITextField(title: "What's your email",  placholder: "email@example.com", typePad: .default, placeholderHeight: 22, textHeight: 22)
    
    let saveButton = DIButton(buttonTitle: "Save", textSize: 14)
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        editTextField.titleLabel.text = title
        editTextField.textField.placeholder = placeholder
        backgroundColor = Color.appBlack
        setupView()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(header)
        header.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        header.constraintHeight(constant: 50)
        
        addSubview(editTextField)
        editTextField.anchor(top: header.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 14, bottom: 0, right: 14))
        editTextField.textField.addTarget(self, action: #selector(textEntered(_:)), for: .editingChanged)
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
    }
    
    func observeEvents() {
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    
    @objc func handleSave() {
        onClickedSave?(editTextField.textField.text ?? "")
    }
    
    @objc func textEntered(_ textField: UITextField) {
        if let text = textField.text {
            onClickedText?(text)
        }
    }
}
