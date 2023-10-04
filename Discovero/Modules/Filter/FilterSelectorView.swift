//
//  FilterView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.


import UIKit

class FilterSelectorView: UIView {

    let locationLabel = DICustomProfileView(titleText: "location", text: "", show: true, sideTitleString: "Select your location")
    let propertyTypeLabel = DICustomProfileView(titleText: "Property Type", text: "", show: true, sideTitleString: "Apartment")
    let nationalityLabel = DICustomProfileView(titleText: "Nationality", text: "", show: true, sideTitleString: "Nepal")
    let bedroomSelector = CustomSelectorView()
    let outerLineView = UIView()
    let knob1 = UIView(color: Color.appWhite, cornerRadius: 10)
    let knob2 = UIView(color: Color.appWhite, cornerRadius: 10)
    let middleView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(locationLabel)
        locationLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(bedroomSelector)
        bedroomSelector.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 150, left: 20, bottom: 0, right: 20))
        
        addSubview(propertyTypeLabel)
        propertyTypeLabel.anchor(top: bedroomSelector.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        addSubview(nationalityLabel)
        nationalityLabel.anchor(top: propertyTypeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        knob1.frame = CGRect(x: 100, y: 180, width: 20, height: 20)
        knob2.frame = CGRect(x: 200, y: 180, width: 20, height: 20)
        middleView.frame = CGRect(x: knob1.frame.origin.x, y: knob1.frame.midY , width: knob2.frame.midX - knob1.frame.midX, height: 5)
        
        addSubview(outerLineView)
        addSubview(knob1)
        addSubview(knob2)
        addSubview(middleView)
        outerLineView.frame = CGRect(x: 20, y: knob1.frame.midY , width: 370, height: 5)
        outerLineView.backgroundColor = Color.gray400
        
        middleView.backgroundColor = .white
        knob1.backgroundColor = .white
        
        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        knob1.addGestureRecognizer(panGesture1)
        
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePanKnob(_:)))
        knob2.addGestureRecognizer(panGesture2)
    }
    
    @objc func handlePanKnob(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview?.superview)
        
        switch gesture.state {
        case .began, .changed:
            gesture.view?.center.x += translation.x
            
            let newKnob1X = knob1.frame.origin.x + translation.x
            let newKnob2X = knob2.frame.origin.x + translation.x
            
            gesture.setTranslation(.zero, in: superview)
            
            if newKnob1X <= newKnob2X {
                let middleViewNewWidth = knob2.frame.minX - knob1.frame.maxX
                middleView.frame.size.width = middleViewNewWidth
                middleView.isHidden = false
            }
            
            if newKnob1X < outerLineView.frame.origin.x {
                knob1.frame.origin.x = outerLineView.frame.origin.x
            }
            
            if newKnob2X > outerLineView.frame.maxX{
                knob2.frame.origin.x = outerLineView.frame.maxX - 7
            }
            
            if newKnob1X > newKnob2X - 10 {
                middleView.isHidden = true
                if newKnob1X > knob1.frame.origin.x {
                    
                    knob1.frame.origin.x = knob2.frame.origin.x - 10
                } else {
                    knob2.frame.origin.x = knob1.frame.origin.x + 10
                }
            }
            
            middleView.frame.origin.x = knob1.frame.maxX
            middleView.frame.origin.y = knob1.frame.midY

        default:
            break
        }
    }
}
