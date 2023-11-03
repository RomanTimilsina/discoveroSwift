//
//  PostPreviewView.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

class PostPreviewView : UIView{
    
    
    var onChangeGradient: (() -> Void)?
    let postView = PostView()
    let headerView = DIHeaderView(title: "Post Preview", hasBack: true, hasBGColor: true )
    let anonymousLabel  = UILabel(text: "Post as anonymous", font: OpenSans.semiBold, size: 14)
    let nextButton = DIButton(buttonTitle: "Next")
    let toggleSwitch = UISwitch()
    lazy var anonymousStack = HorizontalStackView(arrangedSubViews: [anonymousLabel, UIView(), toggleSwitch])
    var userName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        
        userName = postView.nameLabel.text ?? ""
        
        toggleSwitch.isOn = false
        toggleSwitch.thumbTintColor = Color.primary
        toggleSwitch.onTintColor = Color.primary?.withAlphaComponent(0.5)
        
        setup()
        observeEvents()
    }
    
    func setup() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        addSubview(postView)
        postView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding:  .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(anonymousStack)
        anonymousStack.anchor(top: postView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding:  .init(top: 30, left: 12, bottom: 0, right: 12))
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 12, bottom: 30, right: 12))
    }
    
    func observeEvents() {
        toggleSwitch.addTarget(self, action: #selector(toggleFunction), for: .valueChanged)
    }
    
    @objc func toggleFunction() {
        if toggleSwitch.isOn {
            postView.nameLabel.text = "Anonymous"
        } else {
            postView.nameLabel.text = userName
        }
         
        let gradient = GradientRectangleView()
        postView.textView.addSubview(gradient)
        gradient.fillSuperview()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
