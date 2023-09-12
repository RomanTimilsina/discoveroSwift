//
//  DICreateAd.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class DICreateAdView: UIView {
    
    let searchBar = CustomSearchBar()
    
    let homeImg = UIImageView(image: UIImage(named: "homeImg"),contentMode: .scaleAspectFit, clipsToBounds: true)
    
    let createAdLabel = UILabel(text: "Create your first ad", font: OpenSans.semiBold, size: 16, alignment: .center)

    let AdDescriptionLabel = UILabel(text: "There seems to be no room available at the moment in your location. ", font: OpenSans.regular, size: 14,numberOfLines: 0, alignment: .center)
    
    let createAdButton = DIButton(buttonTitle: "Create your first ad",textSize: 14)
    
    let ad = CustomAdView("Jasper's market", "Check out our best quality", UIImage(named: "rightAdImage"), UIImage(named: "leftAdImage"))
    
    let line = UIView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        addSubview(searchBar)
        searchBar.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        addSubview(createAdLabel)
        createAdLabel.centerInSuperview()
        
        addSubview(homeImg)
        homeImg.anchor(top: nil, leading: nil, bottom: createAdLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        homeImg.centerXInSuperview()
        
        addSubview(AdDescriptionLabel)
        AdDescriptionLabel.anchor(top: createAdLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
        addSubview(createAdButton)
        createAdButton.anchor(top: AdDescriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 33, left: 12, bottom: 0, right: 12))
        
        addSubview(ad)
        ad.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 84, right: 0))
        ad.constraintHeight(constant: 70)
        
        addSubview(line)
        line.anchor(top: ad.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        line.constraintHeight(constant: 1)
        line.backgroundColor = Color.gray700
    }
}
