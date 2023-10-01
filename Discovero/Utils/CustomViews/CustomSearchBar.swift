//
//  CustomSearchBar.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class CustomSearchBar: UIView {
    
    var onSearchEdit: ((String) -> Void)?
    let searchBarContainer = UIView(color: Color.gray900)
    
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
        textField.backgroundColor = Color.gray700
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Color.gray600?.cgColor
        return textField
    }()
    
    let iconContainer = UIView()
    let filterImage = UIImageView(image: UIImage(named: "filterButton") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    
    init(placeholder: String = "Search for language", placeholderHeight: CGFloat = 14, isFilterEnable: Bool = false) {
        super.init(frame: .zero)
        setupConstraint()
        observeSearchEvent()
        textFieldAttribute(placeholderText: placeholder , placeholderHeight: placeholderHeight )
        filterImage.isHidden = !isFilterEnable
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        addSubview(searchBarContainer)
        searchBarContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        searchBarContainer.constraintHeight(constant: 64)
        
        searchField.leftViewMode = .always
        searchField.leftView = magnifyingGlassView
        
        iconContainer.addSubview(filterImage)
        filterImage.anchor(top: iconContainer.topAnchor, leading: iconContainer.leadingAnchor, bottom: iconContainer.bottomAnchor, trailing: iconContainer.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 7))
        
        searchField.rightViewMode = .always
        searchField.rightView = iconContainer
        
        searchBarContainer.addSubview(searchField)
        searchField.anchor(top: searchBarContainer.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12 ))
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
    
    private func observeSearchEvent() {
        searchField.addTarget(self, action: #selector(handleSearch), for: .editingChanged)
    }
    
    @objc func handleSearch() {
        onSearchEdit?(searchField.text ?? "")
    }
}
