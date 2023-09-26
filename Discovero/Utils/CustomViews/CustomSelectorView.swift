//
//  CustomSelectorView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit

class CustomSelectorView: UIView {

    let outerView = UIView()
    var viewsArray = [UIView]()
    let slidableItemView = SlidableItemView(frame: CGRect(x: 100, y: 200, width: 14, height: 14))
    lazy var stack = HorizontalStackView(arrangedSubViews: viewsArray, spacing: 0, distribution: .fillEqually)
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        
        for number in 0...5 {
            let view = UIView()
            var label: UILabel
            let line = UIView()
            
            label = UILabel(text: "\(number)+", color: Color.gray400, font: OpenSans.regular, size: 14)
            view.backgroundColor = Color.gray800
            
            if number == 0 {
                label = UILabel(text: "Any", color: Color.appWhite, font: OpenSans.regular, size: 14)
                view.backgroundColor = Color.gray400
            }
            
            view.addSubview(label)
            view.addSubview(line)
            line.constraintHeight(constant: 14)
            line.constraintWidth(constant: 1)
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            line.centerYInSuperview()
            line.backgroundColor = Color.gray700
            label.centerInSuperview()
            view.constraintHeight(constant: 30)
            view.constraintWidth(constant: 50)
            viewsArray.append(view)

            if number == 0 {
                line.removeFromSuperview()
            }
        }

        addSubview(outerView)
        outerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        outerView.addSubview(stack)
        stack.anchor(top: outerView.topAnchor, leading: outerView.leadingAnchor, bottom: outerView.bottomAnchor, trailing: outerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        outerView.clipsToBounds = true
        
        outerView.layer.cornerRadius = 3

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
