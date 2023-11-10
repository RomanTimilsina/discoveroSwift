//
//  SelectGenderView.swift
//  Discovero
//
//  Created by admin on 08/11/2023.
//

import UIKit

class SelectGenderView: UIView {
    
    var onClickedSave: ((String) -> Void)?
    
    let headerView = DIHeaderView(title: "Choose Gender", hasBack: true, hasBGColor: true)
    let title = UILabel(text: "Whats your gender? ", font: OpenSans.semiBold, size: 16)
  
    var maleButton : UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setImage(UIImage(named: "offButton"), for: .normal)
        button.isSelected = false
        let spacing: CGFloat = 10 // Adjust the spacing as needed
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        return button
    }()
    
    var femaleButton : UIButton = {
        let button = UIButton()
        button.setTitle("Female", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setImage(UIImage(named: "offButton"), for: .normal) //
        button.isSelected = false
        let spacing: CGFloat = 10 // Adjust the spacing as needed
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        return button
    }()

    var otherButton : UIButton = {
        let button = UIButton()
        button.setTitle("Other", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setImage(UIImage(named: "offButton"), for: .normal)
        button.isSelected = false
        let spacing: CGFloat = 10 // Adjust the spacing as needed
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        return button
    }()
    
    lazy var genderStack = HorizontalStackView(arrangedSubViews: [maleButton, femaleButton, otherButton, UIView()], spacing: 10, distribution: .fillEqually)
    
    let saveButton = DIButton(buttonTitle: "Save")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.appBlack
        
        saveButton.setInvalidState()
        setupConstraints()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        addSubview(title)
        title.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        
        addSubview(genderStack)
        genderStack.anchor(top: title.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
         
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 30, right: 12))
        
    }
    
    func observeEvents(){
        maleButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        otherButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(handleSaveTap), for: .touchUpInside)
    }
    
    @objc func optionButtonTapped(sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = false
        otherButton.isSelected = false
        saveButton.setValidState()

        if sender.isSelected {
            saveButton.setValidState()
        }
        sender.isSelected = true
        debugPrint(sender)
        updateButtonAppearance(maleButton)
        updateButtonAppearance(femaleButton)
        updateButtonAppearance(otherButton)
    }
    
    @objc func handleSaveTap() {
        if maleButton.isSelected == true {
            onClickedSave?(Gender.Male.title)
        } else if  femaleButton.isSelected == true {
            onClickedSave?(Gender.Female.title)
        } else if otherButton.isSelected == true {
            onClickedSave?(Gender.Other.title)
        } else {
            onClickedSave?(Gender.Error.title)
        }
    }
    
    func updateButtonAppearance(_ button: UIButton) {
        if button.isSelected {
            button.setImage(UIImage(named: "onButton"), for: .normal) // Use a selected state image
        } else {
            button.setImage(UIImage(named: "offButton"), for: .normal) // Use an unselected state image
        }
    }
}

enum Gender {
    case Male
    case Female
    case Other
    case Error
    
    var title: String {
        switch self {
        case .Male: return "Male"
        case .Female: return "Female"
        case .Other: return "Other"
        case .Error: return "You haven't selected your gender"
        }
    }
}
