//
//  CreateAnnouncmentView.swift
//  Discovero
//
//  Created by admin on 02/11/2023.
//

import UIKit

class CreateAnnouncmentView: UIView {
    
  var onClickedNext: (() -> Void)?
    
  let header = DIHeaderView(title: "Create Announcement Ads", hasBack: true, hasBGColor: true)
  let view = UIView()
  let announcement  = DITextField(title: "Add your announcement ", placholder: "Type Here", typePad: .default, placeholderHeight: 22, textHeight: 22)
  let nextButton = DIButton(buttonTitle: "Next")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        observeEvents()
        announcement.textField.tintColor = Color.primary
        backgroundColor = .black
    }
  
  func setupView() {
    addSubview(header)
    header.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
      header.constraintHeight(constant: 50)

    addSubview(announcement)
      announcement.anchor(top: header.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 14, bottom: 0, right: 14))
      
    addSubview(nextButton)
      nextButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
  }
    
    func observeEvents() {
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    
    
  @objc func handleNext() {
      onClickedNext?()
  }
    
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}











