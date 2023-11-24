//
//  AnnouncementView.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementView : UIView{
    
    let headerView = DIHeaderView(title: "Announcements", hasBack: false, hasBGColor: false)
    
    let pageView : UICollectionView = {
        let cell = UICollectionViewFlowLayout()
        cell.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: cell)
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
//        addSubview(headerView)
//        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding:  .init(top: 0, left: 0, bottom: 0, right: 0))
//        headerView.constraintHeight(constant: 50)
        
        addSubview(pageView)
        pageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
