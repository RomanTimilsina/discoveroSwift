//
//  DIPickerVieew.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class DIPickerView: UIView {
    
    var onClose: (() -> Void)?
    
    let table: UITableView = {
        let table = UITableView()
        table.backgroundColor = Color.gray900
        return table
    }()
    let pickerHeaderView = UIView()
    let crossIcon = UIImageView(image: UIImage(named: "crossIcon"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let chooseNationalityLabel = UILabel(text: "Choose your nationality", font: OpenSans.semiBold, size: 16)
    let nextButton = UIButton(title: "Next", titleColor: Color.appWhite, font: OpenSans.bold, fontSize: 14)
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.gray600
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        addSubview(pickerHeaderView)
        pickerHeaderView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        
        let signUpTextTapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        crossIcon.addGestureRecognizer(signUpTextTapGesture)
        crossIcon.isUserInteractionEnabled = true
        
        pickerHeaderView.addSubview(crossIcon)
        crossIcon.anchor(top: pickerHeaderView.topAnchor, leading: pickerHeaderView.leadingAnchor, bottom: pickerHeaderView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        crossIcon.centerYInSuperview()
        
        pickerHeaderView.addSubview(chooseNationalityLabel)
        chooseNationalityLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        chooseNationalityLabel.centerInSuperview()
        
        pickerHeaderView.addSubview(nextButton)
        nextButton.anchor(top: pickerHeaderView.topAnchor, leading: nil, bottom: pickerHeaderView.bottomAnchor, trailing: pickerHeaderView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        nextButton.centerYInSuperview()
        
        pickerHeaderView.addSubview(lineView)
        lineView.anchor(top: chooseNationalityLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor ,padding: .init(top: 12, left: 0, bottom: -1, right: 0))
        lineView.constraintHeight(constant: 1)
        
        addSubview(table)
        table.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    @objc func close() {
        onClose?()
    }
}
