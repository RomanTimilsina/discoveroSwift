//
//  CustomSearchBar.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class CustomSearchBar: UIView {
    
    let searchBarContainer = UIView(color: Color.gray800)
    
    let magnifyingGlassView: UIImageView = {
        let view = UIImageView()
        view.constraintWidth(constant: 37)
        view.image = UIImage(named: "magnifyingGlass")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = 22
        textField.textColor = Color.appWhite
        textField.backgroundColor = Color.gray800
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Color.gray600?.cgColor
        return textField
    }()
    
    let searchBarRightIconContainer = UIView()
    
    let  searchBarRightIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "fllterButton")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    init(placeholder: String = "Search for room", placeholderHeight: CGFloat = 14) {
        super.init(frame: .zero)
        setupConstraint()
        textFieldAttribute(placeholderText: placeholder , placeholderHeight: placeholderHeight )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        addSubview(searchBarContainer)
        searchBarContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        searchBarContainer.constraintHeight(constant: 111)
        
        searchField.leftViewMode = .always
        searchField.leftView = magnifyingGlassView
        
        searchBarRightIconContainer.addSubview(searchBarRightIcon)
        searchBarRightIcon.anchor(top: searchBarRightIconContainer.topAnchor, leading: searchBarRightIconContainer.leadingAnchor, bottom: searchBarRightIconContainer.bottomAnchor, trailing: searchBarRightIconContainer.trailingAnchor, padding: .init(top: 7, left: 7, bottom: 7, right: 7))
        searchBarRightIcon.constraintWidth(constant: 30)
        searchBarRightIconContainer.constraintWidth(constant: 44)
        searchBarRightIconContainer.constraintHeight(constant: 44)
        
        searchField.rightViewMode = .always
        searchField.rightView = searchBarRightIconContainer
        
        searchBarContainer.addSubview(searchField)
        searchField.anchor(top: searchBarContainer.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 55, left: 12, bottom: 0, right: 12 ))
        searchField.constraintHeight(constant: 44)
    }
    
    //MARK: Placeholder attribute set
    func textFieldAttribute(placeholderText: String, placeholderHeight: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.appWhite,
            .font: UIFont.font(with: placeholderHeight, family: OpenSans.regular)
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        searchField.attributedPlaceholder = attributedPlaceholder
    }
}
