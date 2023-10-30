//
//  CustomNumberSelector.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class CustomNumberSelector: UIView {
    
    let titleLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16 )
    var number = UILabel(text: "", color: Color.appWhite, font: OpenSans.semiBold, size: 14)
    let minusButton = DIButton(buttonTitle: "-")
    let plusButton = UIImageView(image: UIImage(named: "plus") ,contentMode: .scaleAspectFit)
    let selectorView = UIView()
    
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
        observeEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(selectorView)
        selectorView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        selectorView.constraintHeight(constant: 30)

        selectorView.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        titleLabel.centerYInSuperview()
                
        selectorView.addSubview(minusButton)
        minusButton.anchor(top: topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 200, bottom: 0, right: 0))
        minusButton.constraintHeight(constant: 10)
        minusButton.constraintHeight(constant: 20)
        minusButton.centerYInSuperview()
        minusButton.layer.cornerRadius = 20

        
        selectorView.addSubview(number)
        number.anchor(top: topAnchor, leading: minusButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        number.centerYInSuperview()
        number.text = "\(currentValue)"

        selectorView.addSubview(plusButton)
        plusButton.anchor(top: topAnchor, leading: number.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        plusButton.constraintHeight(constant: 40)
        plusButton.constraintWidth(constant: 40)
        plusButton.centerYInSuperview()
//        plusButton.layer.cornerRadius = 10

    }
    
  func observeEvent() {
      let minusButtonTapgesture = UITapGestureRecognizer(target: self, action: #selector(handleMinusButtonTap))
      minusButton.addGestureRecognizer(minusButtonTapgesture)
      minusButton.isUserInteractionEnabled = true
      
      let plusButtonTapgesture = UITapGestureRecognizer(target: self, action: #selector(handlePlusButtonTap))
      plusButton.addGestureRecognizer(plusButtonTapgesture)
      plusButton.isUserInteractionEnabled = true
    }
    
    @objc func handleMinusButtonTap() {
        currentValue -= currentValue
        updateLabelWithAnimation()
        animateButtonPress(minusButton)
        delegate?.customSelector(self, didChangeValue: currentValue)
    }
    
    @objc func handlePlusButtonTap() {
        currentValue += currentValue
        updateLabelWithAnimation()
//        animateButtonPress(plusButton)
        delegate?.customSelector(self, didChangeValue: currentValue)
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
