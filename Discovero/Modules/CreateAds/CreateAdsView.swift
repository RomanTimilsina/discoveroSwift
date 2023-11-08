//
//  CreateAdsView.swift
//  Discovero
//
//  Created by admin on 30/10/2023.
//

import UIKit

class CreateAdsView : UIView {
    
    var onNextClick : ((PostModel)-> Void)?
    
    let headerView = DIHeaderView(title: "", hasBack: true)
    let coverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let titleView = DITextField(title: "Add title for your ads",  placholder: "Type here", typePad: .default, contentHeight: 50, placeholderHeight: 15, textHeight: 15, hasLine: false)
    let descriptionsView = DITextField(title: "Add some descriptions",  placholder: "Type here", typePad: .default,
                                       contentHeight: 50, placeholderHeight: 15, textHeight: 15, hasLine: false)
    let priceLabel = UILabel(text: "Price Per Week", font: OpenSans.semiBold, size: 16)
    let dollarLabel = UILabel(text: "$", font: OpenSans.semiBold, size: 16)
    var priceTextField : UITextField = {
        let textfield = UITextField()
        textfield.textColor = Color.appWhite
        textfield.keyboardType = .numberPad
        textfield.placeholder = "Type Here"
        textfield.backgroundColor = .black
        textfield.tintColor = Color.primary
        return textfield
    }()
    lazy var priceStack = HorizontalStackView( arrangedSubViews: [dollarLabel, priceTextField ], spacing: 8 )
    let salaryLabel = UILabel(text: "Salary", font: OpenSans.semiBold, size: 16)
    var salaryTextField : UITextField = {
        let textfield = UITextField()
        textfield.textColor = Color.appWhite
        textfield.keyboardType = .numberPad
        textfield.placeholder = "Type Here"
        textfield.backgroundColor = .black
        textfield.tintColor = Color.primary
        return textfield
    }()
    let lineView = UIView()
    let locationLabel = DICustomProfileView(titleText: "Location", text: "location", isInFilter: true)
    let noOfBedrooms  = CustomNumberSelector("No of Bedrooms",  1)
    let noOfBathrooms = CustomNumberSelector("No of Bathrooms", 1)
    let noOfParkings  = CustomNumberSelector("Parking Available For",  0)
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "", show: true, sideTitleString: "Tap to Choose")
    let nextButton = DIButton(buttonTitle: "Next")
    var countryName, stateName, suburbName, propertyType: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setup()
        observeEvents()
        
        textFieldAttribute(placeholderText: " \(priceTextField.placeholder ?? "")", placeholderHeight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        headerView.cancelLabel.isHidden = true
        
        addSubview(titleView)
        titleView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        titleView.textField.tintColor = Color.primary
        titleView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        titleView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        titleView.lineView.removeFromSuperview()
        
        addSubview(descriptionsView)
        descriptionsView.anchor(top: titleView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        descriptionsView.textField.tintColor = Color.primary
        descriptionsView.titleLabel.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        descriptionsView.textField.font = UIFont.font(with: 15, family: OpenSans.semiBold)
        
        addSubview(priceLabel)
        priceLabel.anchor(top: descriptionsView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        addSubview(priceStack)
        priceStack.anchor(top: priceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 6, left: 12, bottom: 0, right: 12))
        
        addSubview(lineView)
        lineView.anchor(top: priceStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 12, bottom: 0, right: 12))
        lineView.constraintHeight(constant: 2)
        lineView.backgroundColor = Color.gray800
        
        addSubview(locationLabel)
        locationLabel.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        addSubview(noOfBedrooms)
        noOfBedrooms.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        noOfBedrooms.constraintHeight(constant: 50)
        
        addSubview(noOfBathrooms)
        noOfBathrooms.anchor(top: noOfBedrooms.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        noOfBathrooms.constraintHeight(constant: 50)
        
        addSubview(noOfParkings)
        noOfParkings.anchor(top: noOfBathrooms.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        noOfParkings.constraintHeight(constant: 50)
        
        addSubview(propertyTypeLabel)
        propertyTypeLabel.anchor(top: noOfParkings.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
        nextButton.layer.cornerRadius = 5
        nextButton.constraintHeight(constant: 50)
    }
    
    func observeEvents() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
        
        propertyTypeLabel.coverButton.showsMenuAsPrimaryAction = true
        propertyTypeLabel.coverButton.isEnabled = true
        propertyTypeLabel.coverButton.menu = addInfoMenu()
    }
    
    @objc func handleNextButtonTap() {
        let postModel = PostModel(name: "",
                                  country: countryName ?? "",
                                  state: stateName ?? "",
                                  suburb: suburbName ?? "",
                                  caption: titleView.textField.text ?? "",
                                  description: descriptionsView.textField.text ?? "",
                                  propertyType: propertyTypeLabel.sideTitle.text ?? "",
                                  price: Double(priceTextField.text ?? "0.0") ?? 0.0,
                                  noOfBedroom: noOfBedrooms.count,
                                  noOfBathroom: noOfBathrooms.count,
                                  noOfParkings: noOfParkings.count,
                                  isAnonymous: false
        )
        onNextClick?(postModel)
    }
}

extension CreateAdsView {
    func setLabel(label: String, headerText : String) {
        priceLabel.text = label
        headerView.textLabel.text = headerText
    }
    
    func removeConstraint(from view: UIView, with attribute: NSLayoutConstraint.Attribute, in constraints: inout [NSLayoutConstraint]) {
        for (index, constraint) in constraints.enumerated() {
            if constraint.firstItem === view && constraint.firstAttribute == attribute {
                constraints.remove(at: index)
                constraint.isActive = false
                return
            }
        }
    }
    
    func configView(model: FilterModel) {
        countryName = model.countryName
        stateName = model.stateName
        locationLabel.subTitle.text = "\(model.countryName ?? ""), \(model.stateName ?? "")"
        locationLabel.subTitle.textColor = Color.appWhite
        if model.propertyType == nil {
            propertyTypeLabel.sideTitle.text = "Tap Here"
        }
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
    
    func textFieldAttribute(placeholderText: String, placeholderHeight: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.placeholderGray ?? .gray,
            .font: UIFont.font(with: placeholderHeight, family: OpenSans.semiBold)
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes
        )
        priceTextField.attributedPlaceholder = attributedPlaceholder
    }
}
