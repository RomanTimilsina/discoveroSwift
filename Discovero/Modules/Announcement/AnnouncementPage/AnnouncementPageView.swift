//
//  AnnouncementPageView.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementPageView: UIView {
    
    var viewButtonTap: (()->Void)?
    
    var textView = GradientRectangleView()
    let announcementlabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.regular, size: 18)

    
    let profilePic : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    let userId = UILabel(text: "", font: OpenSans.semiBold, size: 12)
    let viewCount = UILabel(text: "", font: OpenSans.semiBold, size: 12)
    
//    var views: UILabel = {
//        let label = UILabel()
//        label.text = "100"
//        label.textColor = .black
//        return label
//    }()
    
    let viewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mark as View", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
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
        
        addSubview(textView)
        addSubview(profilePic)
        addSubview(userId)
        addSubview(viewCount)
        addSubview(viewButton)
        addSubview(comments)

        textView.anchor(top: safeAreaLayoutGuide.bottomAnchor, leading:  leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom:  600, right: 0))
        textView.heightAnchor.constraint(equalToConstant: 200 ).isActive = true
        
        profilePic.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 500, left: 10, bottom: 200, right: 380))
        profilePic.constraintHeight(constant: 50)
        profilePic.constraintWidth(constant: 50)
        profilePic.layer.cornerRadius = 24
        profilePic.clipsToBounds = true

        userId.anchor(top: topAnchor, leading: profilePic.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 170, left: 60, bottom: 70, right: 0))
        
        viewCount.anchor(top: nil, leading: leadingAnchor, bottom: viewButton.topAnchor, trailing: nil, padding: .init(top: 10, left: 73, bottom: 260, right: 0))
    
        viewButton.anchor(top: safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 50, right: 10))
        viewButton.constraintHeight(constant: 50)
                
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


