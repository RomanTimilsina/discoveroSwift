//
//  CreateJobsAdsView.swift
//  Discovero
//
//  Created by admin on 01/11/2023.
//

import UIKit

class CreateJobsAdsView : UIView {
    
    var onNextClick : (()-> Void)?
    
    let headerView = DIHeaderView(title: "", hasBack: true)
    let coverButton = UIButton(title: "", titleColor: .clear, font: OpenSans.regular, fontSize: 1)
    let titleView = DITextField(title: "Add title for your ads",  placholder: "Type here", typePad: .default, contentHeight: 50, placeholderHeight: 15, textHeight: 15, hasLine: false)
    let descriptionsView = DITextField(title: "Add some descriptions",  placholder: "Type here", typePad: .default,
        contentHeight: 50, placeholderHeight: 15, textHeight: 15, hasLine: false)
    let rightArrowImage = UIImageView(image: UIImage(named: "rightArrow"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let dollarLabel = UILabel(text: "$", font: OpenSans.semiBold, size: 16)
    let salaryLabel = UILabel(text: "Salary", font: OpenSans.semiBold, size: 16)
    var salaryTextField : UITextField = {
        let textfield = UITextField()
        textfield.textColor = Color.appWhite
        textfield.keyboardType = .numberPad
        textfield.placeholder = "Type Here"
        textfield.backgroundColor = .clear
        return textfield
    }()
    lazy var salaryStack = HorizontalStackView( arrangedSubViews: [dollarLabel, salaryTextField, UIView()], spacing: 8 )
    lazy var sideStack = HorizontalStackView(arrangedSubViews: [UIView(), sideTitle, rightArrowImage],spacing: 8)
    let sideTitle = UILabel(text: "",color: Color.appWhite, font: OpenSans.semiBold, size: 14)
    let lineView = UIView()
    let locationLabel = DICustomProfileView(titleText: "Location", text: "Select your location", isInFilter: true)
    let selector  = CustomNumberSelector("No of Position ", 1)
    let JobTypeLabel = DICustomProfileView(titleText: "Job Type", text: "", show: true, sideTitleString: "Tap to Choose")
    let productTypeLabel = DICustomProfileView(titleText: "Category of Product", text: "", show: true, sideTitleString: "Tap to Choose")
    let nextButton = DIButton(buttonTitle: "Next", height: 30)
    var countryName, stateName, suburbName, propertyType: String?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        setup()
        observeEvents()
        
        textFieldAttribute(placeholderText: " \(salaryTextField.placeholder ?? "")", placeholderHeight: 15)
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
        
        addSubview(salaryLabel)
        salaryLabel.anchor(top: descriptionsView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
    
        addSubview(salaryStack)
        salaryStack.anchor(top: salaryLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 6, left: 12, bottom: 0, right: 100))
        
        addSubview(coverButton)
        coverButton.anchor(top: salaryLabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        coverButton.addSubview(sideStack)
        sideStack.anchor(top: coverButton.topAnchor, leading: coverButton.leadingAnchor, bottom: coverButton.bottomAnchor, trailing: coverButton.trailingAnchor, padding: .init(top: 6, left: 0, bottom: 0, right: 12))
        
        addSubview(lineView)
        lineView.anchor(top: salaryStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top:  5, left: 12, bottom: 0, right: 12))
        lineView.constraintHeight(constant: 2)
        lineView.backgroundColor = Color.gray800
        
        addSubview(locationLabel)
        locationLabel.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        addSubview(selector)
        selector.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        selector.constraintHeight(constant: 50)
        
        addSubview(JobTypeLabel)
        JobTypeLabel.anchor(top: selector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        addSubview(productTypeLabel)
        productTypeLabel.anchor(top: selector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
        nextButton.layer.cornerRadius = 5
        
        coverButton.constraintWidth(constant: 100)
        coverButton.backgroundColor = .clear
        coverButton.setTitleColor(Color.appWhite, for: .normal)
        coverButton.isEnabled = false
    }
    
    func observeEvents() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
        
        JobTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        JobTypeLabel.propertyCoverButton.isEnabled = true
        JobTypeLabel.propertyCoverButton.menu = addInfoForJobPost()
        productTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        productTypeLabel.propertyCoverButton.isEnabled = true
        productTypeLabel.propertyCoverButton.menu = addInfoForSellAndBuy()
        coverButton.showsMenuAsPrimaryAction = true
        coverButton.isEnabled = true
        coverButton.menu = addInfoForSalary()
        
    }
    
    @objc func handleNextButtonTap() {
        onNextClick?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateJobsAdsView {
    
    func setLabel(label: String, headerText: String, selectorLabel: String = "No of Positions") {
        salaryLabel.text = label
        headerView.textLabel.text = headerText
        selector.titleLabel.text = selectorLabel
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
        if model.propertyType == nil {
            JobTypeLabel.sideTitle.text = "Tap Here"
        }
    }
    
    private func addInfoForJobPost() -> UIMenu {
        let other = UIAction(title: "Other", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Other"
        })
        
        let cleaning = UIAction(title: "Cleaning", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Cleaning"
        })
        
        let design = UIAction(title: "Design", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Design"
        })
        
        let development = UIAction(title: "Development", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Development"
        })
        
        let infoMenu = UIMenu(title: "", children: [other, cleaning, design , development])
        return infoMenu
    }
    
    private func addInfoForSalary() -> UIMenu {
        let annually = UIAction(title: "Annually", handler: { _ in
            self.sideTitle.text = "Annually"
        })
        
        let monthly = UIAction(title: "Monthly", handler: { _ in
            self.sideTitle.text = "Monthly"
        })
        
        let perHr = UIAction(title: "Per hr" , handler: { _ in
            self.sideTitle.text = " Per hr"
        })
        
        let infoMenu = UIMenu(title: "", children: [annually, monthly, perHr])
        return infoMenu
    }
    
    private func addInfoForSellAndBuy() -> UIMenu {
        let other = UIAction(title: "Other", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Other"
        })
        
        let goods = UIAction(title: "Goods", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Goods"
        })
        
        let furniture = UIAction(title: "Furniture", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Furniture"
        })
        
        let vechicles = UIAction(title: "Vechicles", handler: { _ in
            self.JobTypeLabel.sideTitle.text = "Vechicles"
        })
        
        let infoMenu = UIMenu(title: "", children: [other, goods, furniture , vechicles])
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
        salaryTextField.attributedPlaceholder = attributedPlaceholder
    }
}
