//
//  CustomSelectorView.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit

class CustomSelectorView: UIView {
    
    var handleTap: ((String) -> Void)?
    let titleLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16)
    let outerView = UIView()
    var viewsArray = [UIView]()
    lazy var stack = HorizontalStackView(arrangedSubViews: viewsArray, spacing: 0, distribution: .fillEqually)
    var selected = true
    
    init(_ title: String = ""){
        super.init(frame: .zero)
        setupView()
        titleLabel.text = title
    }
    
    func setupView() {
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
            line.backgroundColor = Color.gray400
            label.centerInSuperview()
            view.constraintHeight(constant: 30)
            view.constraintWidth(constant: 50)
            
            let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(viewTap)
            view.isUserInteractionEnabled = true
            
            viewsArray.append(view)
            
            if number == 5 {
                line.removeFromSuperview()
            }
        }
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(outerView)
        outerView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        
        outerView.addSubview(stack)
        stack.anchor(top: outerView.topAnchor, leading: outerView.leadingAnchor, bottom: outerView.bottomAnchor, trailing: outerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        outerView.clipsToBounds = true
        
        outerView.layer.cornerRadius = 3
    }
    
    @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
        guard let selectedView = gesture.view
        else { return }
        
        for (_, view) in viewsArray.enumerated() {
            if let label = view.subviews.first as? UILabel {
                if view == selectedView {
                    label.textColor = Color.appWhite
                    view.backgroundColor = Color.gray400
                    handleTap?(label.text?.replacingOccurrences(of: "+", with: "") ?? "")
                } else {
                    label.textColor = Color.gray400
                    view.backgroundColor = Color.gray800
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
