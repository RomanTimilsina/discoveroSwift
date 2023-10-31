//
//  CustomNumberSelector.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class CustomNumberSelector: UIView {
    
     let titleLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16 )
     let minusView = UIView(color: Color.appWhite)
     let numberLabel = UILabel(text: "0 ", font: OpenSans.semiBold, size: 15)
     let plusView = UIView(color: Color.appWhite)
     var count: Int = 0
     lazy var clickerStack = HorizontalStackView(arrangedSubViews: [titleLabel, UIView() ,minusView, numberLabel, plusView], spacing: 20)
     let minusBlackCircle = UIView(color: Color.appBlack)
     let minusLabel = UILabel(text: "-", font: OpenSans.regular, size: 15)
     let plusBlackCircle = UIView(color: Color.appBlack)
     let plusLabel = UILabel(text: "+", font: OpenSans.regular, size: 15)
    var min = 0
     var topConstraint: NSLayoutConstraint!
    private var isAnimating = false
    
    init(_ text: String ,_ minimum: Int) {
        super.init(frame: .zero)
        titleLabel.text = text
        numberLabel.text = "\(minimum)"
        min = minimum
        count = minimum
       setupViewConstraints()
       observeEvents()
     }
     func setupViewConstraints() {
       addSubview(clickerStack)
       clickerStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

       minusView.constraintWidth(constant: 50)
       minusView.constraintHeight(constant: 50)
       minusView.layer.cornerRadius = 25
         
       minusView.addSubview(minusBlackCircle)
       minusBlackCircle.centerInSuperview(size: CGSize(width: 48, height: 48))
         minusBlackCircle.layer.cornerRadius = 24
         
       minusBlackCircle.addSubview(minusLabel)
       minusLabel.centerInSuperview()
         
       plusView.constraintWidth(constant: 50)
       plusView.constraintHeight(constant: 50)
       plusView.layer.cornerRadius = 25
        
       plusView.addSubview(plusBlackCircle)
         plusBlackCircle.centerInSuperview(size: CGSize(width: 48, height: 48))
         plusBlackCircle.layer.cornerRadius = 24
         
       plusBlackCircle.addSubview(plusLabel)
       plusLabel.centerInSuperview()
     }
     func observeEvents() {
       minusBlackCircle.isUserInteractionEnabled = false
       minusLabel.isUserInteractionEnabled = false
       let subtractGesture = UITapGestureRecognizer(target: self, action: #selector(handleMinus))
       minusBlackCircle.addGestureRecognizer(subtractGesture)
       minusBlackCircle.isUserInteractionEnabled = true
       plusBlackCircle.isUserInteractionEnabled = false
       plusLabel.isUserInteractionEnabled = false
       let addGesture = UITapGestureRecognizer(target: self, action: #selector(handlePlus))
       plusBlackCircle.addGestureRecognizer(addGesture)
       plusBlackCircle.isUserInteractionEnabled = true
     }

     @objc func handleMinus() {
         if count > min {
             if isAnimating {
                 return
             }
             isAnimating = true
             let updatedCount = count - 1
             animateLabelRollUp(fromCount: count, toCount: updatedCount)
             count = updatedCount
         } else {
             count = min
         }
     }
     @objc func handlePlus() {
         if isAnimating {
                   return
               }
               isAnimating = true
               let updatedCount = count + 1
               animateLabelRollUp(fromCount: count, toCount: updatedCount)
               count = updatedCount
     }
    private func animateLabelRollUp(fromCount: Int, toCount: Int) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .push
        animation.subtype = fromCount < toCount ? .fromTop : .fromBottom
        animation.duration = 0.2

        numberLabel.layer.add(animation, forKey: nil)
        numberLabel.text = "\(toCount)"
        
        // You may need to update your constraints here if necessary

        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            self.isAnimating = false
        }
    }
   
 
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
   }
