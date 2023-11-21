//  FilterView.swift
//  Discovero
//
//  Created by Mac on 17/09/2023.
//

import UIKit

class FilterView: UIView {
    var ontFilterClick: (() -> Void)?
    
    let view = UIView()
    let imageView = UIImageView(image: UIImage(named: "filterImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let filtersLabel = UILabel(text: "Filters", font: OpenSans.semiBold, size: 15)
    //    let filtersLabel = UIButton(title: "Filters", titleColor: Color.appWhite, font: OpenSans.semiBold, fontSize: 15)
    let circleView = UIView(color: Color.primary, cornerRadius: 10)
    let filterNumber = UILabel(text: "1", color: Color.appBlack, font: OpenSans.regular, size: 12)
    let numberOfOffers = UILabel(text: "\(0) Offers", font: OpenSans.semiBold, size: 12)
    
    lazy var filterStack = HorizontalStackView(arrangedSubViews: [imageView, filtersLabel, circleView], spacing: 6)
    let filterContainerView = UIView(color: Color.gray700, cornerRadius: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFilter()
        observeEvents()
        
//        CurrentFilter.filter.choice = "job"
//        
//        if CurrentFilter.filter.choice == "job" {
//            
//        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFilter() {
        addSubview(numberOfOffers)
        numberOfOffers.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil , trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0  ))
        numberOfOffers.constraintHeight(constant: 40)
        
        imageView.constraintWidth(constant: 18)
        
        addSubview(filterContainerView)
        filterContainerView.constraintHeight(constant: 30)
        filterContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil , trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width/2 - 47))
        filterContainerView.constraintHeight(constant: 40)
        
        filterContainerView.addSubview(filterStack)
        filterStack.anchor(top: filterContainerView.topAnchor, leading: filterContainerView.leadingAnchor, bottom: filterContainerView.bottomAnchor , trailing: filterContainerView.trailingAnchor, padding: .init(top: 5, left: 4, bottom: 5, right: 4  ))
        filterStack.constraintHeight(constant: 40)
        
        numberOfOffers.centerYAnchor.constraint(equalTo:filterContainerView.centerYAnchor).isActive = true
        
        circleView.backgroundColor = Color.primary
        circleView.constraintHeight(constant: 20)
        circleView.constraintWidth(constant: 20)
        
        circleView.addSubview(filterNumber)
        filterNumber.centerInSuperview()
    }
    
    private func observeEvents() {
        let filterTap = UITapGestureRecognizer(target: self, action: #selector(handleFilter))
        filterStack.addGestureRecognizer(filterTap)
        filterStack.isUserInteractionEnabled = true
    }
    
    @objc func handleFilter() {
        ontFilterClick?()
        print("filter")
    }
}
