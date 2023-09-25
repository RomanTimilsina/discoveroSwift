//
//  DICreateAd.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomView: UIView {
    
    let searchBar = CustomSearchBar()
    let searchBarBackgroundView = UIView()
    let homeImg = UIImageView(image: UIImage(named: "homeImg"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let createAdLabel = UILabel(text: "Create your first ad", font: OpenSans.semiBold, size: 16, alignment: .center)
    let adDescriptionLabel = UILabel(text: "There seems to be no room available at the moment in your location. ", font: OpenSans.regular, size: 14,numberOfLines: 0, alignment: .center)
    let createAdButton = DIButton(buttonTitle: "Create your first ad",textSize: 14)
    let adView = CustomAdView("Jasper's market", "Check out our best quality", UIImage(named: "rightAdImage"), UIImage(named: "leftAdImage"))
    let line = UIView()
    
    lazy var emptyStackView = VerticalStackView(arrangedSubViews: [homeImg, createAdLabel,adDescriptionLabel, createAdButton], spacing: 30)
    
    let headerTab = DIHeaderTab()
    let filterSection = FilterView()
    
    let adsTable = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        observeEvents()
        backgroundColor = Color.appBlack
        hideTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        addSubview(searchBar)
        searchBar.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        addSubview(searchBarBackgroundView)
        searchBarBackgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: searchBar.topAnchor, trailing: trailingAnchor)
        searchBarBackgroundView.backgroundColor = Color.gray900
        
        addSubview(emptyStackView)
        emptyStackView.centerInSuperview()
        emptyStackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
        addSubview(headerTab)
        headerTab.anchor(top: searchBar.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        headerTab.constraintHeight(constant: 48)
        
        addSubview(filterSection)
        filterSection.anchor(top: headerTab.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        filterSection.constraintHeight(constant: 40)
        
        addSubview(adsTable)
        adsTable.anchor(top: filterSection.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 70, right: 0))
        adsTable.backgroundColor = Color.appBlack
        
        addSubview(adView)
        adView.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0))
        adView.constraintHeight(constant: 70)
        
        addSubview(line)
        line.anchor(top: adView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        line.constraintHeight(constant: 1)
        line.backgroundColor = Color.gray700
    }
    
    private func observeEvents() {
        createAdButton.addTarget(self, action: #selector(createAd), for: .touchUpInside)
    }
    
    func hideTable() {
        adsTable.isHidden = true
        headerTab.isHidden = true
        filterSection.isHidden = true
        emptyStackView.isHidden = false
    }
    
    func showTable() {
        adsTable.isHidden = false
        headerTab.isHidden = false
        filterSection.isHidden = false
        emptyStackView.isHidden = true
    }
    
    @objc func createAd() {
        print("Check")
        showTable()
    }
}
