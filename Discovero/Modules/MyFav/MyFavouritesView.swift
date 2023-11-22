//
//  MyFavouritesView.swift
//  Discovero
//
//  Created by admin on 22/11/2023.
//

import UIKit

class MyFavoritesView: UIView {
    
    let headerView = DIHeaderView(title: "My Favorites", hasBack: false)
    let titleLabel = UILabel(text: "No favorites added yet ", color: Color.appWhite, font: OpenSans.semiBold, size: 16, numberOfLines: 1, alignment: .center)
    let textLabel = UILabel(text: "To add your favorites ads please click on like icon on each post visible on your home screen", color: Color.appWhite , font: OpenSans.regular, size: 14, numberOfLines: 2, alignment: .center)
    lazy var emptyStack = VerticalStackView(arrangedSubViews: [titleLabel,textLabel], spacing: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack

        setupView()
    }
    
    func setupView() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        addSubview(emptyStack)
        emptyStack.centerInSuperview()
        
        textLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
