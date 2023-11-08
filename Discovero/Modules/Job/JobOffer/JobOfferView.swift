//
//  JobOfferView.swift
//  Discovero
//
//  Created by admin on 03/11/2023.
//

import UIKit

class JobOfferView: UIView {
    
    var onJobRefresh: (() -> Void)?
    var onCLickedAdd: (() -> Void)?
    
    let refreshControl = UIRefreshControl()
    let homeImg = UIImageView(image: UIImage(named: "homeImg"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let createAdLabel = UILabel(text: "Create your first ad", font: OpenSans.semiBold, size: 16, alignment: .center)
    let adDescriptionLabel = UILabel(text: "There seems to be no room available at the moment in your location. ", font: OpenSans.regular, size: 14,numberOfLines: 0, alignment: .center)
    let createAdButton = DIButton(buttonTitle: "Create your first ad",textSize: 14)
    let adView = CustomAdView("Jasper's market", "Check out our best quality", UIImage(named: "rightAdImage"), UIImage(named: "leftAdImage"))
    let line = UIView()
    let addButtonView = UIImageView(image: UIImage(named: "plus") ,contentMode: .scaleAspectFit)
    lazy var emptyStackView = VerticalStackView(arrangedSubViews: [homeImg, createAdLabel,adDescriptionLabel, createAdButton], spacing: 30)
    let filterSection = FilterView()
    let adsTable = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        observeEvents()
        emptyStackView.isHidden = true
        backgroundColor = Color.appBlack
    }
    
    func setupConstraint() {
        addSubview(filterSection)
        filterSection.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        filterSection.constraintHeight(constant: 40)
        filterSection.constraintWidth(constant: 95)
        
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
        
        addSubview(addButtonView)
        addButtonView.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 80, right: 18))
        addButtonView.constraintHeight(constant: 50)
        addButtonView.constraintWidth(constant: 50)
    }
    
    private func observeEvents() {
        createAdButton.addTarget(self, action: #selector(handleCreateAd), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(handleRefreshData), for: .valueChanged)
        adsTable.addSubview(refreshControl)
        
        let addButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAdd))
        addButtonView.addGestureRecognizer(addButtonTapGesture)
        addButtonView.isUserInteractionEnabled = true
    }
    
    func hideTable() {
        adsTable.isHidden = true
        filterSection.isHidden = true
        emptyStackView.isHidden = false
    }
    
    func showTable() {
        adsTable.isHidden = false
        filterSection.isHidden = false
        emptyStackView.isHidden = true
    }
    
    @objc func handleAdd(){
        onCLickedAdd?()
    }
    
    @objc func handleRefreshData() {
        onJobRefresh?()
    }
    
    @objc func handleCreateAd() {
        print("Check")
        showTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
