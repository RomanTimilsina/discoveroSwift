
//  LoacationFilterView.swift
//  Discovero
//
//  Created by Wishuv on 11/10/2023.
//


import UIKit

class LocationFilterView: UIView {
    
    var onCountriesTap: (() -> Void)?
    var onStateTap: (() -> Void)?
    var onSaveClick: ((LocationFilterModel) -> Void)?
    
    let headerView = DIHeaderView(title: " Location Detail")
    let countryLabel = UILabel(text: "Country ", color: Color.appWhite, font:  OpenSans.semiBold, size: 15)
    var countriesTextField: UITextField = {
        let textfield = UITextField(color: Color.appBlack)
        textfield.text = ""
        textfield.isUserInteractionEnabled = false
        textfield.textColor = Color.appWhite
        return textfield
    }()
    let stateLabel = UILabel(text: "State", color: Color.appWhite, font: OpenSans.semiBold, size: 15)
    let statesTextField: UITextField = {
        let textfield = UITextField(color: Color.appBlack)
        textfield.text = ""
        textfield.isUserInteractionEnabled = false
        textfield.textColor = Color.appWhite
        return textfield
    }()
    let suburbLabel = UILabel(text: "Suburb ", font: OpenSans.semiBold, size: 15)
    let suburbTextField: UITextField = {
        let textfield = UITextField(color: Color.appBlack)
        textfield.text = ""
        textfield.placeholder = "Tap Here"
        textfield.isUserInteractionEnabled = false
        textfield.textColor = Color.appWhite
        return textfield
    }()
    let saveButton = DIButton(buttonTitle: "Save")
    let lineview  = UIView(color: Color.placeholderGray)
    let lineview2 = UIView(color: Color.placeholderGray)
    let lineview3 = UIView(color: Color.placeholderGray)
    let countriesTFCoverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let stateTFCoverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let alert = UIAlertController(title: "Alert Title", message: "Can't select more than 3 languages", preferredStyle: .alert)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setupView()
        textFieldAttribute(placeholderText: "Tap Here", placeholderHeight: 15)
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        headerView.cancelLabel.isHidden = true
        
        addSubview(countryLabel)
        countryLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil , padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        addSubview(countriesTextField)
        countriesTextField.anchor(top: countryLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        //Need to work on it
        addSubview(countriesTFCoverButton)
        countriesTFCoverButton.anchor(top: countriesTextField.topAnchor, leading: countriesTextField.leadingAnchor, bottom: countriesTextField.bottomAnchor, trailing: countriesTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(lineview)
        lineview.anchor(top: countriesTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top:  0, left: 10, bottom: 0, right: 10))
        lineview.constraintHeight(constant: 1)
        
        addSubview(stateLabel)
        stateLabel.anchor(top: lineview.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        addSubview(statesTextField)
        statesTextField.anchor(top: stateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        addSubview(stateTFCoverButton)
        stateTFCoverButton.anchor(top: statesTextField.topAnchor, leading: statesTextField.leadingAnchor, bottom: statesTextField.bottomAnchor, trailing: statesTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(lineview2)
        lineview2.anchor(top: statesTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top:  0, left: 10, bottom: 0, right: 10))
        lineview2.constraintHeight(constant: 1)
        
        addSubview(suburbLabel)
        suburbLabel.anchor(top: lineview2.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20 , left: 10, bottom: 0, right: 10))
        
        addSubview(suburbTextField)
        suburbTextField.anchor(top: suburbLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        suburbTextField.isUserInteractionEnabled = true
        suburbTextField.tintColor = Color.primary
        
        addSubview(lineview3)
        lineview3.anchor(top: suburbTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top:  0, left: 10, bottom: 0, right: 10))
        lineview3.constraintHeight(constant: 1)
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
    }
    
    func observeEvents() {
        countriesTFCoverButton.addTarget(self, action: #selector(handleCountriesClick), for: .touchUpInside)
        
        stateTFCoverButton.addTarget(self, action: #selector(handleStateClick), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // Handle OK button tap here
            print("OK button tapped")
        }
        
        alert.addAction(okAction)
        
        stateTFCoverButton.isEnabled = true
        stateTFCoverButton.showsMenuAsPrimaryAction = true
        
    }
    
    @objc func handleCountriesClick() {
        onCountriesTap?()
    }
    
    @objc func handleStateClick() {
        onStateTap?()
    }
    
    @objc func handleSave() {
        onSaveClick?(LocationFilterModel(countryName: countriesTextField.text, stateName: statesTextField.text))
    }
}

//MARK: Placeholder attribute set
private extension LocationFilterView {
    
    func textFieldAttribute(placeholderText: String, placeholderHeight: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.placeholderGray ?? .gray,
            .font: UIFont.font(with: placeholderHeight, family: OpenSans.semiBold)
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        suburbTextField.attributedPlaceholder = attributedPlaceholder
    }
}
