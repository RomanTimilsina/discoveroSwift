////
////  CustomSearchBar.swift
////  Discovero
////
////  Created by Mac on 07/09/2023.
////
//
//import UIKit
//
//class CustomSearchBar: UIView {
//
//    let searchBarContainer = UIView(color: Color.gray600)
//
//    let magnifyingGlassView: UIImageView = {
//        let view = UIImageView()
//        view.constraintWidth(constant: 37)
//        view.image = UIImage(named: "magnifyingGlass")
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//
//    let searchField: UITextField = {
//       let textField = UITextField()
//        textField.placeholder = "Search"
//        textField.clearButtonMode = .whileEditing
//        textField.layer.cornerRadius = 22
//        textField.backgroundColor = Color.gray600
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = Color.appWhite.cgColor
//        return textField
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupConstraint()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupConstraint() {
//
//        addSubview(searchBarContainer)
//        searchBarContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: -20, bottom: 0, right: -10))
//        searchBarContainer.constraintHeight(constant: 52)
//
//        searchBarContainer.addSubview(searchField)
//
//        searchField.leftViewMode = .always
//        searchField.leftView = magnifyingGlassView
//
//        searchField.anchor(top: searchBarContainer.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12 ))
//        searchField.constraintHeight(constant: 44)
//    }
//}
