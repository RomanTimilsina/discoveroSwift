//
//  RoomTableViewCell.swift
//  Discovero
//
//  Created by Mac on 18/09/2023.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    let gapView = UIView()
    //Ads header part
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "ankit chaudhary", font: OpenSans.semiBold, size: 14)
    let countryFlageImage = UIImageView(image: UIImage(named: "nepal"), contentMode: .scaleAspectFit)
    let timeSinceUploadLabel = UILabel(text: "41 minutes ago", font: OpenSans.regular, size: 12)
    let dot = UIImageView(image: UIImage(named: "dot"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nswLabel = UILabel(text: "NSW", font: OpenSans.semiBold, size: 14)
    let heartImage = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nooOfLikes = UILabel(text: "100", font: OpenSans.semiBold, size: 12)
    lazy var titleStack = HorizontalStackView(arrangedSubViews: [nameLabel, countryFlageImage], spacing: 5)
    lazy var subTitleStack = HorizontalStackView(arrangedSubViews: [timeSinceUploadLabel,dot, nswLabel], spacing: 5)
    lazy var UserStack = VerticalStackView(arrangedSubViews: [titleStack, subTitleStack], distribution: .fillProportionally)
    lazy var likesStack = VerticalStackView(arrangedSubViews: [heartImage, nooOfLikes])
    lazy var adHeaderStack = HorizontalStackView(arrangedSubViews: [profileImageView, UserStack, UIView(),likesStack], spacing: 10)
    //Ads comment part
    let callImageView = UIImageView(image: UIImage(named: "call"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let callLabel = UILabel(text: "Call", font: OpenSans.semiBold, size: 14)
    lazy var callStack = HorizontalStackView(arrangedSubViews: [callImageView, callLabel, UIView()], spacing: 10)
    let messageImageView = UIImageView(image: UIImage(named: "chat"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let messageLabel = UILabel(text: "Message", font: OpenSans.semiBold, size: 14)
    lazy var messageStack = HorizontalStackView(arrangedSubViews: [messageImageView, messageLabel], spacing: 10, distribution: .fillProportionally)
    let commentsImageView = UIImageView(image: UIImage(named: "comments"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let commentsLabel = UILabel(text: "Comments", font: OpenSans.semiBold, size: 14)
    let commentCount = UILabel(text: "6", color: Color.appBlack, font: OpenSans.semiBold, size: 12)
    let circleView = UIView(color: Color.primary, cornerRadius: 7)
    lazy var commentsStack = HorizontalStackView(arrangedSubViews: [commentsImageView, commentsLabel, UIView()], spacing: 10)
    lazy var adFooterStack = HorizontalStackView(arrangedSubViews: [callStack, messageStack, commentsStack], distribution: .fillEqually)
    // Ads middle part
    let adLabel = UILabel(text: "2 Big Room with attached bath room and parking in Sydney", font: OpenSans.semiBold, size: 16, numberOfLines: 0, alignment: .left)
    let dollarImageView = UIImageView(image: UIImage(named: "dollar"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let priceAmountLabel = UILabel(text: "$879.00", color: Color.primary, font: OpenSans.semiBold, size: 14)
    let durationLabel = UILabel(text: "per week", font: OpenSans.semiBold, size: 14)
    lazy var priceStack = HorizontalStackView(arrangedSubViews: [dollarImageView, priceAmountLabel, durationLabel, UIView()], spacing: 6)
    let placeImage = UIImageView(image:UIImage(named: "place") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let location = UILabel(text: "Fredrick St.Broome", font: OpenSans.regular, size: 14)
    lazy var locationStack = HorizontalStackView(arrangedSubViews: [placeImage, location, UIView()], spacing: 6)
    let bedroomImage =  UIImageView(image:UIImage(named: "bedrooom") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let bedroomNumberLabel = UILabel(text: "3", font: OpenSans.regular, size: 14)
    let tubImage =  UIImageView(image:UIImage(named: "tub") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let tubNumberLabel = UILabel(text: "2", font: OpenSans.regular, size: 14)
    let garageImage =  UIImageView(image:UIImage(named: "garage") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let garageNumberLabel = UILabel(text: "2", font: OpenSans.regular, size: 14)
    let line =  UIImageView(image:UIImage(named: "line") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let typeLabel = UILabel(text: "Apartment", font: OpenSans.regular, size: 14)
    let eyeImage = UIImageView(image:UIImage(named: "eye"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let viewCount = UILabel(text: "200", font: OpenSans.regular, size: 14)
    lazy var totalViewStack = VerticalStackView(arrangedSubViews: [eyeImage, viewCount])
    lazy var apartmentDescriptionStack = HorizontalStackView(arrangedSubViews: [bedroomImage, bedroomNumberLabel, tubImage, tubNumberLabel, garageImage, garageNumberLabel, line, typeLabel, UIView()], spacing: 8)
    lazy var middleAdStack = VerticalStackView(arrangedSubViews: [adLabel, priceStack, locationStack, apartmentDescriptionStack], spacing: 8)
    lazy var cellStack = VerticalStackView(arrangedSubViews: [adHeaderStack, middleAdStack, adFooterStack], spacing: 12)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = Color.gray900
    }
    
    func setup() {
        addSubview(gapView)
        gapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        gapView.constraintHeight(constant: 20)
        gapView.backgroundColor = Color.appBlack
        
        addSubview(cellStack)
        cellStack.constraintWidth(constant: 100)
        cellStack.anchor(top: gapView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        
        addSubview(totalViewStack)
        totalViewStack.anchor(top: nil, leading: nil, bottom: adFooterStack.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 5))
        
        addSubview(circleView)
        circleView.anchor(top: nil, leading: commentsLabel.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        circleView.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor).isActive = true
        circleView.constraintWidth(constant: 14)
        circleView.constraintHeight(constant: 14)
        circleView.addSubview(commentCount)
        commentCount.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
