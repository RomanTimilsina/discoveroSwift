//  FilterView.swift
//  Discovero
//
//  Created by Mac on 17/09/2023.
//

import UIKit

class FilterView: UIView {
    let view = UIView()
    let imageView = UIImageView(image: UIImage(named: "filterImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let filtersLabel = UILabel(text: "Filters", font: OpenSans.semiBold, size: 15)
    let circleView = UIView(color: Color.primary, cornerRadius: 8)
    let filterNumber = UILabel(text: "6", color: Color.appBlack, font: OpenSans.regular, size: 12)
    let numberOfOffers = UILabel(text: "\(29) Offers", font: OpenSans.semiBold, size: 12)

    lazy var filterStack = HorizontalStackView(arrangedSubViews: [imageView, filtersLabel, circleView])
//    let filterContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFilter()
        backgroundColor = Color.gray700
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFilter() {
        
        addSubview(numberOfOffers)
        numberOfOffers.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil , trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0  ))
        numberOfOffers.constraintHeight(constant: 40)
        
        addSubview(filterStack)
        filterStack.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil , trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0  ))
        
//        filterStack.centerXInSuperview()
        numberOfOffers.centerYAnchor.constraint(equalTo: filterStack.centerYAnchor).isActive = true
        filterStack.centerXInSuperview()
        
        circleView.backgroundColor = Color.primary
        circleView.constraintHeight(constant: 16)
        circleView.constraintWidth(constant: 16)
        
        
    }
}
