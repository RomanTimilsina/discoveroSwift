//
//  ISOtpField.swift
//  iSend
//
//  Created by Sujal Shrestha on 09/04/2023.
//

import UIKit

class DIOTPField: UITextField {
    
    var onOtpFilled: ((String, Bool) -> Void)?
    var defaultCharacter = "" 
    
    private var isConfigured = false
    
    private var digitLabels = [UILabel]()
    private var lineViews = [UIView]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with slotCount: Int = 6) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 17
       
        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont.font(with: 32, family: OpenSans.semiBold)
            label.isUserInteractionEnabled = true
            label.text = defaultCharacter
            label.textColor = Color.primary
            
            let lineView: UIView = {
               let view = UIView()
                view.backgroundColor = Color.gray500
                view.constraintHeight(constant: 3)
                return view
            }()
            let vStack = VerticalStackView(arrangedSubViews: [label, lineView])
            stackView.addArrangedSubview(vStack)
            digitLabels.append(label)
            lineViews.append(lineView)
        }
        return stackView
    }
    
    @objc
    func textDidChange() {
        
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            let currentLineView = lineViews[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
                currentLineView.backgroundColor = Color.appWhite
                currentLineView.constraintHeight(constant: 3)
            } else {
                currentLabel.text = defaultCharacter
                currentLineView.backgroundColor = Color.gray500
                currentLineView.constraintHeight(constant: 3)
            }
        }
        
        if text.count == digitLabels.count {
//            resignFirstResponder()
            onOtpFilled?(text, true)
        } else {
            onOtpFilled?(text, false)
        }
    }
    
}

extension DIOTPField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}
