//
//  BottomSheetPickerView.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class BottomSheetPickerView : UIView {
    
    var onCloseClick:   (()-> Void)?
    var onOfferClick:   (()-> Void)?
    var onLookingClick: (() ->Void)?
    
    let pickerHeaderView = UIView()
    let backButton = UIImageView(image: UIImage(named: "back"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let title = UILabel(text: "What do you want to do?", font: OpenSans.semiBold, size: 16)
    var offerLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    var lookingLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    lazy var tableStack = VerticalStackView(arrangedSubViews: [offerLabel, lookingLabel], spacing: 10)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setup()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(pickerHeaderView)
        pickerHeaderView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        
        pickerHeaderView.addSubview(backButton)
        backButton.anchor(top: pickerHeaderView.topAnchor, leading: pickerHeaderView.leadingAnchor, bottom: pickerHeaderView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        backButton.constraintHeight(constant: 30)
        backButton.centerYInSuperview()

        pickerHeaderView.addSubview(title)
        title.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        title.centerInSuperview()
    
        addSubview(tableStack)
        tableStack.anchor(top: pickerHeaderView.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 10, right: 0))
        tableStack.backgroundColor = Color.gray900
    }
    
    private func observeEvents() {
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseTap))
        backButton.addGestureRecognizer(backButtonTapGesture)
        backButton.isUserInteractionEnabled = true
        
        let offerTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOfferTap))
        offerLabel.addGestureRecognizer(offerTapGesture)
        offerLabel.isUserInteractionEnabled = true
        
        let lookingTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLookingTap))
        lookingLabel.addGestureRecognizer(lookingTapGesture)
        lookingLabel.isUserInteractionEnabled = true
    }
    
    @objc func handleCloseTap() {
        onCloseClick?()
    }
    
    @objc func handleOfferTap() {
        onOfferClick?()
    }
    
    @objc func handleLookingTap() {
        onLookingClick?()
    }
    
    func setLabel(offerText: String, lookingText: String) {
        offerLabel.text = offerText
        lookingLabel.text = lookingText
    }
}
