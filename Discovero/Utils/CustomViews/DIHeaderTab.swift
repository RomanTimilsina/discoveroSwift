//
//  DICustomHeaderTab.swift
//  Discovero
//
//  Created by Mac on 17/09/2023.
//

import UIKit

class DIHeaderTab: UIView {
    
    var onOfferClicked: (() -> Void)?
    var onWantedClicked: (() -> Void)?

    let offerView = UIView()
    let wantedView = UIView()
    let offerLabel = UILabel(text: "Offer",
                             color: Color.appWhite,
                             font: OpenSans.regular,
                             size: 15, numberOfLines: 0,
                             alignment: .center)
    let wantedLabel = UILabel(text: "Wanted",
                              color: Color.appWhite,
                              font: OpenSans.regular,
                              size: 15,
                              numberOfLines: 0,
                              alignment: .center)
    lazy var offerVStack = VerticalStackView(arrangedSubViews: [offerLabel, offerView])
    lazy var wantedVStack = VerticalStackView(arrangedSubViews: [wantedLabel, wantedView])
    lazy var viewStack = HorizontalStackView(arrangedSubViews: [offerVStack, wantedVStack], distribution: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTab()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTab() {
        offerView.constraintHeight(constant: 2)
        offerView.backgroundColor = Color.primary
        offerVStack.constraintHeight(constant: 24)
        
        wantedView.constraintHeight(constant: 2)
        wantedView.backgroundColor = Color.gray900
        wantedVStack.constraintHeight(constant: 24)
        
        addSubview(viewStack)
        viewStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        viewStack.backgroundColor = Color.gray900
        viewStack.constraintHeight(constant: 36)
        viewStack.constraintHeight(constant: 40)
    }
    
    private func observeEvents() {
        let offerTabTap = UITapGestureRecognizer(target: self, action: #selector(handleOfferViewTap))
        offerVStack.addGestureRecognizer(offerTabTap)
        offerVStack.isUserInteractionEnabled = true
        
        let wantedTabTap = UITapGestureRecognizer(target: self, action: #selector(handleWantedViewTap))
        wantedVStack.addGestureRecognizer(wantedTabTap)
        wantedVStack.isUserInteractionEnabled = true
    }
    
    @objc func handleOfferViewTap() {
        offerView.backgroundColor = Color.primary
        wantedView.backgroundColor = Color.gray900
        onOfferClicked?()
    }
    
    @objc func handleWantedViewTap() {
        wantedView.backgroundColor = Color.primary
        offerView.backgroundColor = Color.gray900
        onWantedClicked?()
    }
}

