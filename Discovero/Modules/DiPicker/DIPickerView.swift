//
//  DIPickerVieew.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class DIPickerView: UIView {
    
    var onCloseClick: (() -> Void)?
    var onNextClick: (() -> Void)?
    var onSearchEdit: ((String) -> Void)?
    
    let table = UITableView()
    let pickerHeaderView = UIView()
    var selectedLanguage: String?
    let backButton = UIImageView(image: UIImage(named: "back"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let chooseNationalityLabel = UILabel(text: "Choose your nationality", font: OpenSans.semiBold, size: 16)
    let nextButton = UIButton(title: "Next", titleColor: Color.appWhite, font: OpenSans.bold, fontSize: 14)
    let lineView = UIView()
    let languageView = DICustomProfileView(titleText: "Languages you speak", text: "")

    lazy var searchBar = CustomSearchBar(placeholder: "" ,isFilterEnable: false)
    let alert = UIAlertController(title: "Alert Title", message: "Can't select more than 3 languages", preferredStyle: .alert)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupConstraint()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        addSubview(pickerHeaderView)
        pickerHeaderView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        
        pickerHeaderView.addSubview(backButton)
        backButton.anchor(top: pickerHeaderView.topAnchor, leading: pickerHeaderView.leadingAnchor, bottom: pickerHeaderView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        backButton.constraintHeight(constant: 30)
        backButton.centerYInSuperview()
        
        pickerHeaderView.addSubview(chooseNationalityLabel)
        chooseNationalityLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        chooseNationalityLabel.centerInSuperview()
        
        pickerHeaderView.addSubview(nextButton)
        nextButton.anchor(top: pickerHeaderView.topAnchor, leading: nil, bottom: pickerHeaderView.bottomAnchor, trailing: pickerHeaderView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        nextButton.centerYInSuperview()
        nextButton.isHidden = true
        
        pickerHeaderView.addSubview(lineView)
        lineView.anchor(top: chooseNationalityLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor ,padding: .init(top: 12, left: 0, bottom: -1, right: 0))
        lineView.constraintHeight(constant: 1)
        lineView.backgroundColor = Color.gray600
        
        addSubview(languageView)
        languageView.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 12, bottom: 0, right: 12))
        
        addSubview(searchBar)
        searchBar.anchor(top: languageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        searchBar.constraintHeight(constant: 40)
        
        addSubview(table)
        table.anchor(top: searchBar.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        table.backgroundColor = Color.gray900
    }
    
    private func observeEvents() {
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClose))
        backButton.addGestureRecognizer(backButtonTapGesture)
        backButton.isUserInteractionEnabled = true
        
        searchBar.onSearchEdit = { [weak self] searchText in
            self?.onSearchEdit?(searchText)
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            debugPrint("OK button tapped")
        }
        
        alert.addAction(okAction)
    }
    
    @objc func handleClose() {
        onCloseClick?()
    }
    
    @objc func handleNext() {
        onNextClick?()
    }
}
