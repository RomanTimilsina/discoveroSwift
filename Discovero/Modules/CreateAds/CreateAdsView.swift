//
//  CreateAdsView.swift
//  Discovero
//
//  Created by admin on 30/10/2023.
//

import UIKit

class CreateAdsView : UIView {
    
    let headerView = DIHeaderView(title: "Create Offer a Room Ads", hasBack: true)
    let titleView = DITextField(title: "Add title for your ads",  placholder: "Type here", typePad: .default, placeholderHeight: 15, textHeight: 15)
    let descriptionsView = DITextField(title: "Add some descriptions",  placholder: "Type here", typePad: .default, placeholderHeight: 15, textHeight: 15)
    let locationLabel = DICustomProfileView(titleText: "Location", text: "Select your location")
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "", show: true, sideTitleString: "Tap here")

    let nextButton = DIButton(buttonTitle: "Next", height: 30)
    
    var countryName, stateName, suburbName, propertyType: String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        headerView.cancelLabel.isHidden = true
//        headerView.centerInSuperview()
        
        addSubview(titleView)
        titleView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        titleView.textField.tintColor = Color.primary
        titleView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        titleView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        titleView.lineView.backgroundColor = .clear
        
        addSubview(descriptionsView)
        descriptionsView.anchor(top: titleView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        descriptionsView.textField.tintColor = Color.primary
        descriptionsView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        descriptionsView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        descriptionsView.lineView.backgroundColor = .clear

        addSubview(locationLabel)
        locationLabel.anchor(top: descriptionsView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
        addSubview(propertyTypeLabel)
        propertyTypeLabel.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
        nextButton.layer.cornerRadius = 10
    }
    
    func observeEvents() {
        propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        propertyTypeLabel.propertyCoverButton.isEnabled = true
        propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()
    }
}

extension CreateAdsView {
    
    func configView(model: FilterModel) {
        countryName = model.countryName
        stateName = model.stateName
        locationLabel.subTitle.text = "\(model.countryName ?? ""), \(model.stateName ?? "")"
        if model.propertyType == nil {
            propertyTypeLabel.sideTitle.text = "Tap Here"
        }
        
//        if model.languageArray?.isEmpty == true {
//            languageLabel.subTitle.text =  "Tap to select"
//        }
    }
    private func addInfoMenu() -> UIMenu {
        let apartment = UIAction(title: "Apartment", handler: { _ in
            self.propertyTypeLabel.sideTitle.text = "Apartment"
        })
        
        let house = UIAction(title: "House", handler: { _ in
            self.propertyTypeLabel.sideTitle.text = "House"
        })
        
        let infoMenu = UIMenu(title: "", children: [apartment, house])
        return infoMenu
    }
}
