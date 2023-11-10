
//  LoacationFilterView.swift
//  Discovero
//
//  Created by Wishuv on 11/10/2023.
//



//  LoacationFilterView.swift
//  Discovero
//
//  Created by Wishuv on 11/10/2023.
//

import UIKit

class LocationFilterView: UIView {
    
    var onTableViewClick: ((Bool) -> Void)?
    var countriesTap: (() -> Void)?
    var stateTap: (() -> Void)?
    var stateList: [String] = []
    var handleSave: (([String]) -> Void)?
    
    let headerView = DIHeaderView(title: " Location Detail")
    
    let countryView = DICustomProfileView(hasButtonProperty: true ,titleText: "Country", text: "Choose country")
    let stateView = DICustomProfileView(hasButtonProperty: true ,titleText: "State", text: "Choose state")
    let suburbView = DITextField(title: "Suburb",  placholder: "Type here", typePad: .default, placeholderHeight: 15, textHeight: 15)
    let streetNameView = DITextField(title: "Street Name",  placholder: "Type here", typePad: .default,contentHeight: 15, placeholderHeight: 15, textHeight: 15)
    let streetNumView = DITextField(title: "Street No.",  placholder: "Type here", typePad: .default, placeholderHeight: 15, textHeight: 15)
    let buldingNumView = DITextField(title: "Building No.",  placholder: "Type here", typePad: .default, placeholderHeight: 15, textHeight: 15)

    let saveButton = DIButton(buttonTitle: "Save")
    let countriesTFCoverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let stateTFCoverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let alert = UIAlertController(title: "Alert Title", message: "Can't select more than 3 languages", preferredStyle: .alert)
        
    let tableView = UITableView()
    var hideTable = true
    let overlayView = UIView()

    let locationTuple = (country: String, state: String, suburb: String, street: String, streetNum: String, buldingNum: String ).self
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        debugPrint(stateList)
        setupFilter()
        observeViewEvents()
        tableView.isHidden = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFilter(){
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        headerView.cancelLabel.isHidden = true
        
        addSubview(countryView)
        countryView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        countryView.constraintHeight(constant: 44)
        
        addSubview(stateView)
        stateView.anchor(top: countryView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        stateView.constraintHeight(constant: 44)
                
        addSubview(suburbView)
        suburbView.anchor(top: stateView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        suburbView.constraintHeight(constant: 44)
        suburbView.textField.tintColor = Color.primary
        suburbView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        suburbView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        
        addSubview(streetNameView)
        streetNameView.anchor(top: suburbView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        streetNameView.constraintHeight(constant: 44)
        streetNameView.textField.tintColor = Color.primary
        streetNameView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        streetNameView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)

        addSubview(streetNumView)
        streetNumView.anchor(top: streetNameView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        streetNumView.constraintHeight(constant: 44)
        streetNumView.textField.tintColor = Color.primary
        streetNumView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        streetNumView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)

        addSubview(buldingNumView)
        buldingNumView.anchor(top: streetNumView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        buldingNumView.constraintHeight(constant: 44)
        buldingNumView.textField.tintColor = Color.primary
        buldingNumView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        buldingNumView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)

//        stateView.propertyCoverButton.isEnabled = false
//        stateView.propertyCoverButton.isHidden = true

        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
        
        addSubview(overlayView)
        overlayView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(tableView)
        tableView.anchor(top: stateView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 80))
        tableView.constraintHeight(constant: 120)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 5
    }
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // Handle OK button tap here
        print("OK button tapped")
    }
    
    func observeViewEvents() {
        countryView.button.addTarget(self, action: #selector(countriesClick), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        alert.addAction(okAction)
        
        stateView.button.isEnabled = true
        stateView.button.addTarget(self, action: #selector(handleTableDisplay), for: .touchUpInside)
        
        let overlayViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayView))
        overlayView.addGestureRecognizer(overlayViewGesture)
        overlayView.isUserInteractionEnabled = false
        
    }
    
    @objc func handleOverlayView() {
        tableView.isHidden = true
        hideTable = true
        overlayView.isUserInteractionEnabled = false
    }
    
    @objc func countriesClick() {
        countriesTap?()
    }
    
    @objc func saveTapped() {
        
        handleSave?([countryView.subTitle.text ?? "", stateView.subTitle.text ?? "", suburbView.textField.text ?? "", streetNameView.textField.text ?? "", streetNumView.textField.text ?? "", buldingNumView.textField.text ?? ""])
    }
    
    @objc func handleTableDisplay() {
        hideTable = !hideTable
        onTableViewClick?(hideTable)

    }
}

