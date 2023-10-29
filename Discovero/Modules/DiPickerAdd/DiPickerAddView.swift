//
//  DiPickerAddView.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class DiPickerAddView: UIView {
    
    var onCloseClick:  (() -> Void)?
    var onClickedRoom: (() -> Void)?
    
    let pickerHeaderView = UIView()
    let backButton = UIImageView(image: UIImage(named: "back"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let title = UILabel(text: "Create New Post", font: OpenSans.semiBold, size: 16)
    let lineView = UIView()
    let roomImage = UIImageView(image: UIImage(named: "roomImage"), contentMode: .scaleAspectFit, clipsToBounds: true )
    
    let roomLabel = UILabel(text: "Room", font: OpenSans.semiBold, size: 14)
    lazy var roomStack = HorizontalStackView(arrangedSubViews: [roomImage , roomLabel, UIView()], spacing: 10)
    let jobImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds:  true )
    let jobLabel = UILabel(text: "Jobs", font: OpenSans.semiBold, size: 14)
    lazy var jobStack = HorizontalStackView(arrangedSubViews: [jobImage , jobLabel, UIView()], spacing: 10)
    let buyAndSellImage = UIImageView(image: UIImage(named: "salesImage"), contentMode: .scaleAspectFit, clipsToBounds:  true )
    let buyAndSellLabel = UILabel(text: "Buy/Sell", font: OpenSans.semiBold, size: 14)
    lazy var buyAnsSellStack = HorizontalStackView(arrangedSubViews: [ buyAndSellImage , buyAndSellLabel, UIView()], spacing: 10)
    let announcementImage = UIImageView(image: UIImage(named: "announcementsImage"), contentMode: .scaleAspectFit, clipsToBounds:  true )
    let announcementLabel = UILabel(text: "Announcement", font: OpenSans.semiBold, size: 14)
    lazy var announcementStack = HorizontalStackView(arrangedSubViews: [announcementImage , announcementLabel, UIView()], spacing: 10)
    lazy var tableStack = VerticalStackView(arrangedSubViews: [roomStack, jobStack, buyAnsSellStack, announcementStack, UIView()], spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray900
        setup()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(pickerHeaderView)
        pickerHeaderView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        pickerHeaderView.constraintHeight(constant: 30)
        
        pickerHeaderView.addSubview(title)
        title.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        title.centerInSuperview()
    
        addSubview(tableStack)
        tableStack.anchor(top: pickerHeaderView.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 10, right: 0))
        tableStack.backgroundColor = Color.gray900
    }
    
    private func observeEvents() {
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClose))
        backButton.addGestureRecognizer(backButtonTapGesture)
        backButton.isUserInteractionEnabled = true
        
        let roomStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRoomTap))
        roomStack.addGestureRecognizer(roomStackTapGesture)
        roomStack.isUserInteractionEnabled = true
    }
    
    @objc func handleClose() {
        onCloseClick?()
    }
    
    @objc func handleRoomTap() {
        onClickedRoom?()
    }
}
