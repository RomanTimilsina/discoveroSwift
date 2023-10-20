//
//  FilterView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.

import UIKit
import MultiSlider

class FilterSelectorView: UIView{
    
    var openPicker: (() -> Void)?
    var onResetClick: (() -> Void)?
    var onSearchClick: ((FilterModel?) -> Void)?
    
    let locationLabel = DICustomProfileView(titleText: "Location", text: "Select your location", show: true, sideTitleString: "")
    let priceLabel = UILabel(text: "Price", font: OpenSans.semiBold, size: 16)
    let priceRange = UILabel(text: "$0.0 to $5000.0",color: .white, font: OpenSans.semiBold, size: 16)
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "", show: true, sideTitleString: "Tap here")
    let languageLabel = DICustomProfileView(titleText: "Language", text: "Tap to select", show: true, sideTitleString: "")
    let bedroomSelector = CustomSelectorView("Bedroom")
    let bathroomSelector = CustomSelectorView("Bathroom")
    let parkingSelector = CustomSelectorView("Number of parkings")
    lazy var selectors = [bedroomSelector, bathroomSelector, parkingSelector]
    let resetButton = DIButton(buttonTitle: "Reset Filter")
    let searchButton = DIButton(buttonTitle: "Search")
    lazy var buttonStack = HorizontalStackView(arrangedSubViews: [resetButton, searchButton], spacing: 12, distribution: .fillEqually)
    let headerView = DIHeaderView(title: "", hasBack: true, hasBGColor: true)
    
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
    
    var countryName, stateName, suburbName, propertyType: String?
    var noOfBedrooms, noOfBathrooms, noOfParkings: Int?
    var minCost, maxCost: Double?
    var languageArray: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        resetButton.backgroundColor = Color.gray700
        resetButton.setTitleColor(Color.appWhite, for: .normal)
        backgroundColor = Color.appBlack
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
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
        
        addSubview(languageLabel)
        languageLabel.anchor(top: propertyTypeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        languageLabel.constraintHeight(constant: 44)
        
        addSubview(buttonStack)
        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 70, right: 12))
    }
    
    @objc func handleMultiSliderValueChanged() {
        let leftValue  = rangeSlider.value[0]
        let rightValue = rangeSlider.value[1]
        let leftknob   = round(leftValue * 100) / 100
        let rightKnob  = round(rightValue * 100) / 100
        
        priceRange.text = "$\(leftknob) to $\(rightKnob)"
        minCost = leftknob
        maxCost = rightKnob
    }
    
    func observeEvents() {
        
        propertyTypeLabel.propertyCoverButton.isEnabled = true
        propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()
        
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        bedroomSelector.onTap = { [weak self] noOfBedroom in
            guard let self = self else { return }
            noOfBedrooms = noOfBedroom == 0 ? nil : noOfBedroom
        }
       
        bathroomSelector.onTap = { [weak self] noOfBathroom in
            guard let self = self else { return }
            noOfBathrooms = noOfBathroom == 0 ? nil : noOfBathroom
        }
        
        parkingSelector.onTap = { [weak self] noOfParking in
            guard let self = self else { return }
            noOfParkings = noOfParking == 0 ? nil : noOfParking
        }
    }
    
    @objc func languageTapped() {
        openPicker?()
    }
    
    @objc func handleSearch() {
        if propertyTypeLabel.sideTitle.text == "Any" || propertyTypeLabel.sideTitle.text == "Tap Here" {
            propertyType = nil
        } else {
            propertyType = propertyTypeLabel.sideTitle.text ?? nil
        }

        onSearchClick?(FilterModel(countryName: countryName ?? "",
                                   stateName: stateName ?? "",
                                   propertyType: propertyType,
                                   noOfBedrooms: noOfBedrooms,
                                   noOfBathrooms: noOfBathrooms,
                                   noOfParkings: noOfParkings,
                                   minCost: minCost, maxCost: maxCost,
                                   languageArray: languageArray))
    }
    
    @objc func resetButtonTapped() {
        onResetClick?()
    }
}

// Mark: Popup cell when propertyTypeLabel is tapped
private extension FilterSelectorView {
    
    private func addInfoMenu() -> UIMenu {
        let both = UIAction(title: "Any", handler: { _ in
            self.propertyTypeLabel.sideTitle.text = "Any"
        })
        
        let apartment = UIAction(title: "Apartment", handler: { _ in
            self.propertyTypeLabel.sideTitle.text = "Apartment"
        })
        
        let house = UIAction(title: "House", handler: { _ in
            self.propertyTypeLabel.sideTitle.text = "House"
        })
        
        let infoMenu = UIMenu(title: "", children: [both, apartment, house])
        return infoMenu
    }
}

extension FilterSelectorView {
    
    func configView(model: FilterModel) {
        countryName = model.countryName
        stateName = model.stateName
        locationLabel.subTitle.text = "\(model.countryName ?? ""), \(model.stateName ?? "")"
        if model.propertyType == nil {
            propertyTypeLabel.sideTitle.text = "Tap Here"
        }
        
        if model.languageArray?.isEmpty == true {
            languageLabel.subTitle.text =  "Tap to select"
        }
    }
    
    func resetView(usersData: UserData?) {
        rangeSlider.value = [0, 5000]
        priceRange.text = "$0 to $5000"
        propertyTypeLabel.sideTitle.text = "Tap Here"
        languageLabel.subTitle.text =  "Tap to select"
        locationLabel.subTitle.text = "\(usersData?.country ?? ""), \(usersData?.locationDetail.state ?? "")"
        
        for selector in selectors {
            for view in selector.viewsArray {
               if let label = view.subviews.first as? UILabel {
                    if view == selector.viewsArray[0] {
                        label.textColor = Color.appWhite
                        view.backgroundColor = Color.gray400
                    } else {
                        label.textColor = Color.gray400
                        view.backgroundColor = Color.gray800
                    }
                }
            }
        }        
    }
}
