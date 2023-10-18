//
//  FilterView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.

import UIKit
import MultiSlider

class FilterSelectorView: UIView{
    
    var openPicker: (() -> Void)?
    var handleReset: (() -> Void)?
    var handleSearch: ((String, String, String) -> Void)?
    
    let locationLabel = DICustomProfileView(titleText: "Location", text: "Select your location", show: true, sideTitleString: "")
    let priceLabel = UILabel(text: "Price", font: OpenSans.semiBold, size: 16)
    let priceRange = UILabel(text: "$0.0 to $5000.0",color: .white, font: OpenSans.semiBold, size: 16)
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "Apartment", show: true, sideTitleString: "Tap here")
    let nationalityLabel = DICustomProfileView(titleText: "Nationality", text: "Nepal", show: true, sideTitleString: "")
    let bedroomSelector = CustomSelectorView("Bedroom")
    let bathroomSelector = CustomSelectorView("Bathroom")
    let parkingSelector = CustomSelectorView("Number of parkings")
    lazy var selectors = [bedroomSelector, bathroomSelector, parkingSelector]
    let resetButton = DIButton(buttonTitle: "Reset Filter")
    let searchButton = DIButton(buttonTitle: "Search")
    lazy var buttonStack = HorizontalStackView(arrangedSubViews: [resetButton, searchButton], spacing: 12, distribution: .fillEqually)
    let headerView = DIHeaderView(title: "", hasBack: true, hasBGColor: true)
    
    let button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle("Show Menu", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let rangeSlider: MultiSlider = {
        let rangeSlider = MultiSlider()
        rangeSlider.minimumValue = 0
        rangeSlider.maximumValue = 5000
        rangeSlider.value = [ 0, 5000]
        rangeSlider.isVertical = false
        rangeSlider.outerTrackColor = .lightGray
        rangeSlider.valueLabelColor = .white
        rangeSlider.valueLabelFont = .boldSystemFont(ofSize: 16)
        rangeSlider.tintColor = .white
        rangeSlider.trackWidth = 5
        return rangeSlider
    }()
    var minCost: String = ""
    var maxCost: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        resetButton.backgroundColor = Color.gray700
        resetButton.setTitleColor(Color.appWhite, for: .normal)
        backgroundColor = Color.appBlack
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 40)
        
        addSubview(locationLabel)
        locationLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        
        addSubview(priceLabel)
        priceLabel.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(priceRange)
        priceRange.anchor(top: priceLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 12, right: 0))
        priceRange.centerXInSuperview()
        
        addSubview(rangeSlider)
        rangeSlider.anchor(top: priceRange.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        rangeSlider.addTarget(self, action: #selector(handleMultiSliderValueChanged), for: .valueChanged)
        
        addSubview(bedroomSelector)
        bedroomSelector.anchor(top: priceRange.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12))
        
        addSubview(bathroomSelector)
        bathroomSelector.anchor(top: bedroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(parkingSelector)
        parkingSelector.anchor(top: bathroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(propertyTypeLabel)
        propertyTypeLabel.anchor(top: parkingSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        
        if let sideTitle = propertyTypeLabel.subTitle.text {
            propertyTypeLabel.sideTitle.text = ""
        } else {
            propertyTypeLabel.sideTitle.text = "Tap here"
        }
        
        addSubview(nationalityLabel)
        nationalityLabel.anchor(top: propertyTypeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        nationalityLabel.constraintHeight(constant: 44)
        
        addSubview(buttonStack)
        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 70, right: 12))
    }
    
    @objc func handleMultiSliderValueChanged() {
        
        let leftValue  = rangeSlider.value[0]
        let rightValue = rangeSlider.value[1]
        let leftknob   = round(leftValue * 100) / 100
        let rightKnob  = round(rightValue * 100) / 100
        
        priceRange.text = "$\(leftknob) to $\(rightKnob)"
        minCost = "\(leftknob)"
        maxCost = "\(rightKnob)"
        
    }
    
    func observeEvents() {
        
        propertyTypeLabel.propertyCoverButton.isEnabled = true
        propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // Mark: Popup cell with property is tapped and objc functions
    private func addInfoMenu() -> UIMenu {
        let Both = UIAction(title: "Any", handler: { _ in
            self.propertyTypeLabel.subTitle.text = "Any"
        })
        let Apartment = UIAction(title: "Apartment", handler: { _ in
            self.propertyTypeLabel.subTitle.text = "Apartment"
        })
        let House = UIAction(title: "House", handler: { _ in
            self.propertyTypeLabel.subTitle.text = "House"
        })
        let infoMenu = UIMenu(title: "", children: [Both, Apartment, House])
        return infoMenu
    }
    
    @objc func languageTapped() {
        openPicker?()
    }
    
    @objc func searchButtonTapped() {
        handleSearch?(propertyTypeLabel.subTitle.text ?? "", minCost, maxCost)
    }
    
    @objc func resetButtonTapped() {
        handleReset?()
    }
}
