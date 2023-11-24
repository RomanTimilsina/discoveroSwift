//
//  MarketView.swift
//  Discovero
//
//  Created by Mac on 24/11/2023.
//

import UIKit

class MarketView: UIView {

        let headerTab = DIHeaderTab()
        let bodyView = MarketBodyView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupView(){
            addSubview(headerTab)
            headerTab.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
            headerTab.constraintHeight(constant: 48)
            
            addSubview(bodyView)
            bodyView.anchor(top: headerTab.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
            bodyView.layer.cornerRadius = 30
            bodyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        }
    }

    class MarketBodyView: UIView {
        
        let buyView = UIView()
        let sellView = UIView()
        let emptyImage = UIImageView(image: UIImage(named: ""),contentMode: .scaleAspectFit, clipsToBounds: true)
        let createAdLabel = UILabel(text: "Create your first ad", font: OpenSans.semiBold, size: 16, alignment: .center)
        let adDescriptionLabel = UILabel(text: "There seems to be no job available at the moment in your location. ", font: OpenSans.regular, size: 14,numberOfLines: 0, alignment: .center)
        let createAdButton = DIButton(buttonTitle: "Create your first ad",textSize: 14)
        
        lazy var emptyStackView = VerticalStackView(arrangedSubViews: [emptyImage, createAdLabel,adDescriptionLabel, createAdButton], spacing: 30)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        func setupView() {
            addSubview(emptyStackView)
            emptyStackView.centerInSuperview()
            emptyStackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))

            addSubview(sellView)
            sellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 20, right: 0))
            
            addSubview(buyView)
            buyView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 20, right: 0))
    //        roomOfferView.isHidden = true
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
