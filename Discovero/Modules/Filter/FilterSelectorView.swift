//
//  FilterView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.


import UIKit

class FilterSelectorView: UIView {
    
    var openPicker: (() -> Void)?
    
    let locationLabel = DICustomProfileView(titleText: "location", text: "Select your location", show: true, sideTitleString: "")
    let priceLabel = UILabel(text: "Price Range", font: OpenSans.semiBold, size: 16)
    let priceRange = UILabel(text: "$879K to $1.6M", font: OpenSans.semiBold, size: 16)
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "Apartment", show: true, sideTitleString: "Tap here")
    let nationalityLabel = DICustomProfileView(titleText: "Nationality", text: "Nepal", show: true, sideTitleString: "")
    let bedroomSelector = CustomSelectorView("Bedroom")
    let bathroomSelector = CustomSelectorView("Bathroom")
    let parkingSelector = CustomSelectorView("Number of parkings")
    
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
        
        addSubview(bedroomSelector)
        bedroomSelector.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(bathroomSelector)
        bathroomSelector.anchor(top: bedroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(parkingSelector)
        parkingSelector.anchor(top: bathroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        
        addSubview(propertyTypeLabel)
        propertyTypeLabel.anchor(top: parkingSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        propertyTypeLabel.constraintHeight(constant: 40)
        
        if propertyTypeLabel.subTitle.text != nil {
            propertyTypeLabel.sideTitle.text = ""
        } else {
            propertyTypeLabel.sideTitle.text = "Tap here"
        }
        
        
        addSubview(nationalityLabel)
        nationalityLabel.anchor(top: propertyTypeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        nationalityLabel.constraintHeight(constant: 44)
        
        //        let yPositionOfKnobs = 300
        //        addSubview(outerLineView)
        //        addSubview(knob1)
        //        addSubview(knob2)
        //        addSubview(middleView)
        //
        //        addSubview(priceLabel)
        //        priceLabel.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
        //
        //        addSubview(priceRange)
        //        priceRange.anchor(top: nil, leading: nil, bottom: knob1.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0))
        //        priceRange.centerXInSuperview()
        //
        //        knob1.frame = CGRect(x: 100, y: yPositionOfKnobs, width: 20, height: 20)
        //        knob2.frame = CGRect(x: 200, y: yPositionOfKnobs, width: 20, height: 20)
        //        middleView.frame = CGRect(x: knob1.frame.origin.x, y: knob1.frame.midY , width: knob2.frame.midX - knob1.frame.midX, height: 5)
        //
        //        addSubview(outerLineView)
        //        addSubview(knob1)
        //        addSubview(knob2)
        //        addSubview(middleView)
        //        outerLineView.frame = CGRect(x: 20, y: knob1.frame.midY , width: UIScreen.main.bounds.size.width - 40, height: 5)
        //        outerLineView.backgroundColor = Color.gray400
        //
        //        middleView.backgroundColor = .white
        //        knob1.backgroundColor = .white
        //
        addSubview(buttonStack)
        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 70, right: 12))
    }
    
    func observeEvents() {
        //        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        //        knob1.addGestureRecognizer(panGesture1)
        //
        //        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        //        knob2.addGestureRecognizer(panGesture2)
        
        propertyTypeLabel.propertyCoverButton.isEnabled = true
        propertyTypeLabel.propertyCoverButton.showsMenuAsPrimaryAction = true
        propertyTypeLabel.propertyCoverButton.menu = addInfoMenu()

//        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
//        propertyTypeLabel.mainStack.addGestureRecognizer(tap)

    }
    
    private func addInfoMenu() -> UIMenu {
        let Both = UIAction(title: "Any", handler: { _ in
        })
        let Apartment = UIAction(title: "Apartment", handler: { _ in
        })
        let House = UIAction(title: "House", handler: { _ in
        })
        let infoMenu = UIMenu(title: "", children: [Both, Apartment, House])
        return infoMenu
    }
    
    @objc func languageTapped() {
        openPicker?()
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
