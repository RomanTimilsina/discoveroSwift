//
//  DiscoveroView.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import UIKit

class DITextField: UIView {
    
    let titleLabel : UILabel = {
        let title = UILabel()
        return title
    }()

    let textField : UITextField = {
       let TF = UITextField()
        TF.font = UIFont(name: "OpenSans-Regular", size: 16)
        return TF
    }()

//    let register : UIButton = {
//       let button = UIButton()
//        button.setTitle("Register", for: .normal)
//        button.setTitleColor(UIColor(named: "buttonText"), for: .normal)
//        button.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 16)
//        button.layer.cornerRadius = 5
//        button.backgroundColor = UIColor(named: "buttonColor")
//        return button
//    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setConstraint()
//    }
    
    init(title: String, placholder: String, isPrimaryColor: Bool) {
        super.init(frame: .zero)
        titleLabel.text = title
        textField.placeholder = placholder
        textField.textColor = isPrimaryColor ? Color.primary : Color.gray500
        
        setConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {
       
        addSubview(titleLabel)
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 10, right: 10))

        addSubview(textField)
        textField.anchor(top: titleLabel.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))

//        addSubview(register)
//        register.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 600, left: 5, bottom: 0, right: 5))
////        register.constraintWidth(constant: 390)
//        register.constraintHeight(constant: 44)
    }
}
