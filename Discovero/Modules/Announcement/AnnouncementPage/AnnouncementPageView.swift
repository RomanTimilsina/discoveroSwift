//
//  AnnouncementPageView.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementPageView: UIView {
    
    var viewButtonTap: (()->Void)?

    let headerView = DIHeaderView(title: "Announcemnet details")
    var textView = GradientRectangleView()
    let announcementlabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.regular, size: 18)
    let profileView = UIView(color: Color.appWhite)
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "Anks B", font: OpenSans.semiBold, size: 14)
    let namePrefixLabel = UILabel(text: "AC",color: Color.appBlack, font: OpenSans.regular, size: 14)

    let viewCount = UILabel(text: "100", font: OpenSans.semiBold, size: 12)
    
    lazy var nameStack = VerticalStackView(arrangedSubViews: [nameLabel, viewCount], spacing: 5)
    
    lazy var userStack = HorizontalStackView(arrangedSubViews: [profileImageView, nameStack] , spacing: 10)
    
    let viewButton = DIButton(buttonTitle: "Mark as view", height: 50)
    
    let likes : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let comments : UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        clickButton()
    }
    
    func setup(){
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading:  leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom:  0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        addSubview(textView)
        textView.anchor(top: headerView.bottomAnchor, leading:  leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 0, bottom:  0, right: 0))
        textView.constraintHeight(constant: 200)
        
        addSubview(userStack)
        userStack.anchor(top: textView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        profileView.constraintHeight(constant: 50)
        profileView.constraintWidth(constant: 50)
        profileView.layer.cornerRadius = 24
        profileView.clipsToBounds = true
        profileView.addSubview(namePrefixLabel)
        namePrefixLabel.centerInSuperview()

//        addSubview(nameLabel)
//        nameLabel.anchor(top: topAnchor, leading: profileView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: , left: 60, bottom: 70, right: 0))
//        nameLabel.textColor = Color.appWhite
        
        addSubview(viewCount)
        viewCount.anchor(top: nameLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 73, bottom: 0, right: 0))
        
        addSubview(viewButton)
        viewButton.anchor(top: safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
                
    }

    func clickButton() {
        viewButton.addTarget(self, action: #selector(clickOnView), for: .touchUpInside)
    }
    
    @objc func clickOnView() {
        viewButtonTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


