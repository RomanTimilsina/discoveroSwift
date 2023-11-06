//
//  DiPickerAddView.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class DiPickerAddView: UIView {
    
//    var onCloseClick:        (() -> Void)?
    var onRoomCLick:         (() -> Void)?
    var onJobClick:          (() -> Void)?
    var onBuyAndSellClick:   (() -> Void)?
    var onAnnouncementClick: (() -> Void)?
    
    let pickerHeaderView = UIView()
//    let backButton = UIImageView(image: UIImage(named: "back"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let title = UILabel(text: "Create New Post", font: OpenSans.semiBold, size: 16)
    let lineView = UIView()
    let roomImage = UIImageView(image: UIImage(named: "roomImage"), contentMode: .scaleAspectFit, clipsToBounds: false)
    let roomLabel = UILabel(text: "Room", font: OpenSans.semiBold, size: 14)
    lazy var roomStack = HorizontalStackView(arrangedSubViews: [roomCircle , roomLabel, UIView()], spacing: 10)
    
    let jobImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds:  false )
    let jobLabel = UILabel(text: "Jobs", font: OpenSans.semiBold, size: 14)
    lazy var jobStack = HorizontalStackView(arrangedSubViews: [jobsCircle , jobLabel, UIView()], spacing: 10)
    
    let buyAndSellImage = UIImageView(image: UIImage(named: "salesImage"), contentMode: .scaleAspectFit, clipsToBounds:  false )
    let buyAndSellLabel = UILabel(text: "Buy/Sell", font: OpenSans.semiBold, size: 14)
    lazy var buyAnsSellStack = HorizontalStackView(arrangedSubViews: [ tradeCircle , buyAndSellLabel, UIView()], spacing: 10)
    
    let announcementImage = UIImageView(image: UIImage(named: "announcementsImage"), contentMode: .scaleAspectFit, clipsToBounds:  false )
    let announcementLabel = UILabel(text: "Announcement", font: OpenSans.semiBold, size: 14)
    lazy var announcementStack = HorizontalStackView(arrangedSubViews: [announcementCircle , announcementLabel, UIView()], spacing: 10)
    
    lazy var tableStack = VerticalStackView(arrangedSubViews: [roomStack, jobStack, buyAnsSellStack, announcementStack, UIView()], spacing: 10)
    
    let roomCircle = UIView(color: Color.gray500, cornerRadius: 12.5)
    let jobsCircle = UIView(color: Color.gray500, cornerRadius: 12.5)
    let tradeCircle = UIView(color: Color.gray500, cornerRadius: 12.5)
    let announcementCircle = UIView(color: Color.gray500, cornerRadius: 12.5)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.gray800
        setUpConstraints()
        observeEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        addSubview(pickerHeaderView)
        pickerHeaderView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 14))
        pickerHeaderView.constraintHeight(constant: 30)
        
        pickerHeaderView.addSubview(title)
        title.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        title.centerInSuperview()
        
        addSubview(tableStack)
        tableStack.anchor(top: pickerHeaderView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        tableStack.backgroundColor = Color.gray800
        
//        roomImage.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        jobImage.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
//        buyAndSellImage.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
//        announcementImage.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        
        let circleArray = [roomCircle, jobsCircle, tradeCircle, announcementCircle]
        let imageArray = [roomImage, jobImage, buyAndSellImage, announcementImage]
        
        for (view, image) in zip(circleArray, imageArray) {
            if let changedImage = changeImageColor(image.image!, color: Color.appWhite) {
                let imageView = UIImageView()
                imageView.image = changedImage
                view.constraintHeight(constant: 25)
                view.constraintWidth(constant: 25)
                view.addSubview(imageView)
                imageView.centerInSuperview()
            }

        }
    }
}

// MARK: View Events
extension DiPickerAddView {
    private func observeEvents() {
//        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseTap))
//        backButton.addGestureRecognizer(backButtonTapGesture)
//        backButton.isUserInteractionEnabled = true
        
        let roomStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRoomTap))
        roomStack.addGestureRecognizer(roomStackTapGesture)
        roomStack.isUserInteractionEnabled = true
        
        let jobStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleJobTap))
        jobStack.addGestureRecognizer(jobStackTapGesture)
        jobStack.isUserInteractionEnabled = true
        
        let buyAndSellStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBuyAndSellTap))
        buyAnsSellStack.addGestureRecognizer(buyAndSellStackTapGesture)
        buyAnsSellStack.isUserInteractionEnabled = true
        
        let announcmentStackTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAnnouncementTap))
        announcementStack.addGestureRecognizer(announcmentStackTapGesture)
        announcementStack.isUserInteractionEnabled = true
    }
    
//    @objc func handleCloseTap() {
//        onCloseClick?()
//    }
    
    @objc func handleRoomTap() {
        onRoomCLick?()
    }
    
    @objc func handleJobTap() {
        onJobClick?()
    }
    
    @objc func handleBuyAndSellTap() {
        onBuyAndSellClick?()
    }
    
    @objc func handleAnnouncementTap() {
        onAnnouncementClick?()
    }
}

extension DiPickerAddView {
    func changeImageColor(_ image: UIImage, color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        color.setFill()
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        context.fill(imageRect)
        image.draw(in: imageRect, blendMode: .destinationIn, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
