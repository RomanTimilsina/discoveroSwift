//
//  CustomNumberSelector.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class CustomNumberSelector: UIView {
    
    private let titleLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16 )
    private var number = UILabel()
    let viewsArray = [UIView]()
    private let minusButton = DIButton(buttonTitle: "-")
    private let plusButton = DIButton(buttonTitle: "+")

    
    var minValue: Int = 0
    var maxValue: Int = 100
    var stepSize: CGFloat = 1
    var currentValue: Int = 0 {
        didSet {
            if currentValue < minValue {
                currentValue = minValue
            } else if currentValue > maxValue {
                currentValue = maxValue
            }
        }
    }
    
    weak var delegate: CustomSelectorDelegate?
    
    init(title: String = "") {
        super.init(frame: .zero)
        titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(minusButton)
        minusButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: number.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(number)
        number.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: plusButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        number.text = "\(currentValue)"

        addSubview(plusButton)
        plusButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        // Set an initial scale for the buttons
        minusButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        plusButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    func observeEvent() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)

    }
    
    @objc private func animateButtonPress(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc private func minusButtonTapped() {
        currentValue -= Int(stepSize)
        updateLabelWithAnimation()
        animateButtonPress(minusButton)
        delegate?.customSelector(self, didChangeValue: currentValue)
    }
    
    @objc private func plusButtonTapped() {
        currentValue += Int(stepSize)
        updateLabelWithAnimation()
        animateButtonPress(plusButton)
        delegate?.customSelector(self, didChangeValue: currentValue)
    }
    
    private func updateLabelWithAnimation() {
        let labelX = CGFloat(currentValue - minValue) * stepSize
        UIView.animate(withDuration: 0.2) {
            self.number.transform = CGAffineTransform(translationX: labelX, y: 0)
        }
    }
}

protocol CustomSelectorDelegate: AnyObject {
    func customSelector(_ customSelector: CustomNumberSelector, didChangeValue value: Int)
}
