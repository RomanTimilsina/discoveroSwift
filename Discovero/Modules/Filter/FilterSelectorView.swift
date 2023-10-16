////
////  FilterView.swift
////  Discovero
////
////  Created by Mac on 20/09/2023.
//
//
//import UIKit
//
//class FilterSelectorView: UIView {
//    
//    var openPicker: (() -> Void)?
//    var handleSearch: (() -> Void)?
//    
//    let locationLabel = DICustomProfileView(titleText: "location", text: "Select your location", show: true, sideTitleString: "")
//    let priceLabel = UILabel(text: "Price Range", font: OpenSans.semiBold, size: 16)
//    let priceRange = UILabel(text: "$879K to $1.6M", font: OpenSans.semiBold, size: 16)
//    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "Apartment", show: true, sideTitleString: "Tap here")
//    let nationalityLabel = DICustomProfileView(titleText: "Nationality", text: "Nepal", show: true, sideTitleString: "")
//    let bedroomSelector = CustomSelectorView("Bedroom")
//    let bathroomSelector = CustomSelectorView("Bathroom")
//    let parkingSelector = CustomSelectorView("Number of parkings")
//    
//    let outerLineView = UIView()
//    let knob1 = UIView(color: Color.appWhite, cornerRadius: 10)
//    let knob2 = UIView(color: Color.appWhite, cornerRadius: 10)
//    let middleView = UIView()
//    let resetButton = DIButton(buttonTitle: "Reset Filter")
//    let searchButton = DIButton(buttonTitle: "Search")
//    lazy var buttonStack = HorizontalStackView(arrangedSubViews: [resetButton, searchButton], spacing: 12, distribution: .fillEqually)
//    let headerView = DIHeaderView(title: "", hasBack: true, hasBGColor: true)
//    let button: UIButton = {
//        let button = UIButton()
//        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
//               button.setTitle("Show Menu", for: .normal)
//               button.backgroundColor = UIColor.systemBlue
//               button.setTitleColor(.white, for: .normal)
//        return button
//    }()
//    var property = ""
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//        resetButton.backgroundColor = Color.gray700
//        resetButton.setTitleColor(Color.appWhite, for: .normal)
//        backgroundColor = Color.appBlack
//        observeEvents()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setup() {
//        addSubview(headerView)
//        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
//        headerView.constraintHeight(constant: 40)
//        
//        addSubview(locationLabel)
//        locationLabel.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
//        
//        addSubview(bedroomSelector)
//        bedroomSelector.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
//        
//        addSubview(bathroomSelector)
//        bathroomSelector.anchor(top: bedroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
//        
//        addSubview(parkingSelector)
//        parkingSelector.anchor(top: bathroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
//        
//        addSubview(propertyTypeLabel)
//        propertyTypeLabel.anchor(top: parkingSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
//        propertyTypeLabel.constraintHeight(constant: 40)
//        
//        if propertyTypeLabel.subTitle.text != nil {
//            propertyTypeLabel.sideTitle.text = ""
//        } else {
//            propertyTypeLabel.sideTitle.text = "Tap here"
//        }
//        
//        
//        addSubview(nationalityLabel)
//        nationalityLabel.anchor(top: propertyTypeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
//        nationalityLabel.constraintHeight(constant: 44)
//        
//        //        let yPositionOfKnobs = 300
//        //        addSubview(outerLineView)
//        //        addSubview(knob1)
//        //        addSubview(knob2)
//        //        addSubview(middleView)
//        //
//        //        addSubview(priceLabel)
//        //        priceLabel.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
//        //
//        //        addSubview(priceRange)
//        //        priceRange.anchor(top: nil, leading: nil, bottom: knob1.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0))
//        //        priceRange.centerXInSuperview()
//        //
//        //        knob1.frame = CGRect(x: 100, y: yPositionOfKnobs, width: 20, height: 20)
//        //        knob2.frame = CGRect(x: 200, y: yPositionOfKnobs, width: 20, height: 20)
//        //        middleView.frame = CGRect(x: knob1.frame.origin.x, y: knob1.frame.midY , width: knob2.frame.midX - knob1.frame.midX, height: 5)
//        //
//        //        addSubview(outerLineView)
//        //        addSubview(knob1)
//        //        addSubview(knob2)
//        //        addSubview(middleView)
//        //        outerLineView.frame = CGRect(x: 20, y: knob1.frame.midY , width: UIScreen.main.bounds.size.width - 40, height: 5)
//        //        outerLineView.backgroundColor = Color.gray400
//        //
//        //        middleView.backgroundColor = .white
//        //        knob1.backgroundColor = .white
//        //
//        addSubview(buttonStack)
//        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 70, right: 12))
//    }
//    
//    func observeEvents() {
//        //        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
//        //        knob1.addGestureRecognizer(panGesture1)
//        //
//        //        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
//        //        knob2.addGestureRecognizer(panGesture2)
//        
//        propertyTypeLabel.propertyCoverButton.isEnabled = true
//        propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
//        propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()
//        
//        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
//
////        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
////        propertyTypeLabel.mainStack.addGestureRecognizer(tap)
//
//    }
//    
//    private func addInfoMenu() -> UIMenu {
//        let Both = UIAction(title: "Any", handler: { _ in
//            self.propertyTypeLabel.subTitle.text = "Any"
//            self.property = "Any"
//        })
//        let Apartment = UIAction(title: "Apartment", handler: { _ in
//            self.propertyTypeLabel.subTitle.text = "Apartment"
//            self.property = "Apartment"
//        })
//        let House = UIAction(title: "House", handler: { _ in
//            self.propertyTypeLabel.subTitle.text = "House"
//            self.property = "Apartment"
//        })
//        let infoMenu = UIMenu(title: "", children: [Both, Apartment, House])
//        return infoMenu
//    }
//    
//    @objc func languageTapped() {
//        openPicker?()
//    }
//    
//    @objc func searchButtonTapped() {
//        handleSearch?()
//    }
//    
//    //    @objc func handlePanKnob(_ gesture: UIPanGestureRecognizer) {
//    //        let translation = gesture.translation(in: superview?.superview)
//    //
//    //        switch gesture.state {
//    //        case .began, .changed:
//    //            gesture.view?.center.x += translation.x
//    //
//    //            let newKnob1X = knob1.frame.origin.x + translation.x
//    //            let newKnob2X = knob2.frame.origin.x + translation.x
//    //
//    //            gesture.setTranslation(.zero, in: superview)
//    //
//    //            if newKnob1X <= newKnob2X {
//    //                middleViewWidthCalc()
//    //            }
//    //
//    //            if newKnob1X < outerLineView.frame.origin.x {
//    //                knob1.frame.origin.x = outerLineView.frame.origin.x
//    //
//    //                middleViewWidthCalc()
//    //            }
//    //
//    //            if newKnob2X > outerLineView.frame.maxX - 15 {
//    //                knob2.frame.origin.x = outerLineView.frame.width
//    //
//    //                middleViewWidthCalc()
//    //            }
//    //
//    //            if newKnob1X > newKnob2X - 10 {
//    //                middleView.isHidden = true
//    //                if newKnob1X > knob1.frame.origin.x {
//    //
//    //                    knob1.frame.origin.x = knob2.frame.origin.x - 10
//    //                } else {
//    //                    knob2.frame.origin.x = knob1.frame.origin.x + 10
//    //                }
//    //            }
//    //
//    //            middleView.frame.origin.x = knob1.frame.maxX
//    //            middleView.frame.origin.y = knob1.frame.midY
//    //
//    //        default:
//    //            break
//    //        }
//    //
//    //        func middleViewWidthCalc() {
//    //            let middleViewNewWidth = knob2.frame.maxX - knob1.frame.maxX
//    //            middleView.frame.size.width = middleViewNewWidth
//    //            middleView.isHidden = false
//    //        }
//    //    }
//}


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
    let outerLineView = UIView()
    let knob1 = UIView(color: Color.appWhite, cornerRadius: 10)
    let knob2 = UIView(color: Color.appWhite, cornerRadius: 10)
    let middleView = UIView()
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
//        rangeSlider.valueLabelPosition = .top
        rangeSlider.valueLabelColor = .white
        rangeSlider.valueLabelFont = .boldSystemFont(ofSize: 16)
        rangeSlider.tintColor = .white
        rangeSlider.trackWidth = 5
        
        
        return rangeSlider
    }()
    var minCost: String = ""
    var maxCost: String = ""
    var property = ""

    
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

//        addSubview(slider)
//        slider.anchor(top: priceRange.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
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
        
//                let yPositionOfKnobs = 290
//                addSubview(outerLineView)
//                addSubview(knob1)
//                addSubview(knob2)
//                addSubview(middleView)
//
//                knob1.frame = CGRect(x: 50, y: yPositionOfKnobs, width: 20, height: 20)
//                knob2.frame = CGRect(x: 250, y: yPositionOfKnobs, width: 20, height: 20)
//                middleView.frame = CGRect(x: knob1.frame.origin.x, y: knob1.frame.midY , width: knob2.frame.midX - knob1.frame.midX, height: 5)
//
//                addSubview(outerLineView)
//                addSubview(knob1)
//                addSubview(knob2)
//                addSubview(middleView)
//                outerLineView.frame = CGRect(x: 20, y: knob2.frame.midY , width: UIScreen.main.bounds.size.width - 40, height: 5)
//                outerLineView.backgroundColor = Color.gray400
//
//                middleView.backgroundColor = .white
//                knob1.backgroundColor = .white
        
        addSubview(buttonStack)
        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 70, right: 12))
    }
    
    @objc func handleMultiSliderValueChanged() {
        
        let leftValue = rangeSlider.value[0]
        let rightValue = rangeSlider.value[1]
        let leftknob = round(leftValue * 100) / 100
        let rightKnob = round(rightValue * 100) / 100
        
        
        priceRange.text = "$\(leftknob) to $\(rightKnob)"
        minCost = "\(leftknob)"
        maxCost = "\(rightKnob)"

    }
    
    func observeEvents() {
        //        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        //        knob1.addGestureRecognizer(panGesture1)
        //
        //        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        //        knob2.addGestureRecognizer(panGesture2)
        
//        let languageGesture = UITapGestureRecognizer(target: self, action: #selector(languageTapped))
//        nationalityLabel.addGestureRecognizer(languageGesture)
//        nationalityLabel.isUserInteractionEnabled = true
//        nationalityLabel.backgroundColor = .blue
//                let propertyLabelGesture = UITapGestureRecognizer(target: self, action: #selector(showMenu))
//                propertyTypeLabel.addGestureRecognizer(propertyLabelGesture)
//                propertyTypeLabel.isUserInteractionEnabled = true
        
                propertyTypeLabel.propertyCoverButton.isEnabled = true
                propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
                propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
    }
    
        private func addInfoMenu() -> UIMenu {
            let Both = UIAction(title: "Any", handler: { _ in
                self.propertyTypeLabel.subTitle.text = "Any"
                self.property = "Any"
            })
            let Apartment = UIAction(title: "Apartment", handler: { _ in
                self.propertyTypeLabel.subTitle.text = "Apartment"
                self.property = "Apartment"
            })
            let House = UIAction(title: "House", handler: { _ in
                self.propertyTypeLabel.subTitle.text = "House"
                self.property = "Apartment"
            })
            let infoMenu = UIMenu(title: "", children: [Both, Apartment, House])
            return infoMenu
        }

    @objc func showMenu() {
//            // Create actions for the menu
//            let option1Action = UIAction(title: "Option 1") { _ in
//                print("Option 1 selected")
//            }
//
//            let option2Action = UIAction(title: "Option 2") { _ in
//                print("Option 2 selected")
//            }
//
//            let option3Action = UIAction(title: "Option 3") { _ in
//                print("Option 3 selected")
//            }
//
//            // Create the menu with the actions
//            let menu = UIMenu(title: "Select an Option", children: [option1Action, option2Action, option3Action])
//
//            // Show the menu anchored to the button
//            let menuConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//                return menu
//            }
//
//            UIMenuController.shared.showMenu(from: self.view, rect: button.frame, in: self.view)
//            UIMenuController.shared.update(with: menuConfiguration)
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
    
    //    @objc func handlePanKnob(_ gesture: UIPanGestureRecognizer) {
    //        let translation = gesture.translation(in: superview?.superview)
    //
    //        switch gesture.state {
    //        case .began, .changed:
    //            gesture.view?.center.x += translation.x
    //
    //            let newKnob1X = knob1.frame.origin.x + translation.x
    //            let newKnob2X = knob2.frame.origin.x + translation.x
    //
    //            gesture.setTranslation(.zero, in: superview)
    //
    //            if newKnob1X <= newKnob2X {
    //                middleViewWidthCalc()
    //            }
    //
    //            if newKnob1X < outerLineView.frame.origin.x {
    //                knob1.frame.origin.x = outerLineView.frame.origin.x
    //
    //                middleViewWidthCalc()
    //            }
    //
    //            if newKnob2X > outerLineView.frame.maxX - 15 {
    //                knob2.frame.origin.x = outerLineView.frame.width
    //
    //                middleViewWidthCalc()
    //            }
    //
    //            if newKnob1X > newKnob2X - 10 {
    //                middleView.isHidden = true
    //                if newKnob1X > knob1.frame.origin.x {
    //
    //                    knob1.frame.origin.x = knob2.frame.origin.x - 10
    //                } else {
    //                    knob2.frame.origin.x = knob1.frame.origin.x + 10
    //                }
    //            }
    //
    //            middleView.frame.origin.x = knob1.frame.maxX
    //            middleView.frame.origin.y = knob1.frame.midY
    //
    //        default:
    //            break
    //        }
    //
    //        func middleViewWidthCalc() {
    //            let middleViewNewWidth = knob2.frame.maxX - knob1.frame.maxX
    //            middleView.frame.size.width = middleViewNewWidth
    //            middleView.isHidden = false
    //        }
    //    }
}
