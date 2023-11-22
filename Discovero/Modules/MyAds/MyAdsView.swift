//
//  MyAdsView.swift
//  Discovero
//
//  Created by admin on 22/11/2023.
//

import UIKit

class MyAdsView: UIView {
    
    let headerView = DIHeaderView(title: "My Ads", hasBack: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack

        setupView()
    }
    
    func setupView() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
