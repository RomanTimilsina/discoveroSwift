//
//  PostPreviewView.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

class PostPreviewView : UIView{
    
    let postView = PostView()
    let headerView = DIHeaderView(title: "Post Preview", hasBack: true, hasBGColor: true )
    let anonymousLabel  = UILabel(text: "Post as anonymous", font: OpenSans.semiBold, size: 14)
    let nextButton = DIButton(buttonTitle: "Next")
    let toggleSwitch = UISwitch()
    lazy var anonymousStack = HorizontalStackView(arrangedSubViews: [anonymousLabel, UIView(), toggleSwitch])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        toggleSwitch.isOn = false
        toggleSwitch.thumbTintColor = Color.primary
        toggleSwitch.onTintColor = Color.primary?.withAlphaComponent(0.5)
        
        setup()
    }
    
    func setup() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        addSubview(postView)
        postView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding:  .init(top: 10, left: 8, bottom: 0, right: 8))
        
        addSubview(anonymousStack)
        anonymousStack.anchor(top: postView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding:  .init(top: 30, left: 8, bottom: 0, right: 8))
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 12, bottom: 30, right: 12))
    }
    
    func observeEvents() {
        toggleSwitch.addTarget(self, action: #selector(toggleFunction), for: .valueChanged)
    }
    
    @objc func toggleFunction() {
        if toggleSwitch.isOn {

        } else {
         
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
