//
//  RoomTableViewCell.swift
//  Discovero
//
//  Created by Mac on 18/09/2023.
//

import UIKit

class RoomOfferTableViewCell: UITableViewCell {
    
    var handleLike: (() -> Void)?
    var handleCall: (() -> Void)?
    var handleMessage: (() -> Void)?
    var handleComments: (() -> Void)?
    
    let gapView = UIView()
    let identifier = "RoomTableCell"
    
    //Ads header part
    let profileView = UIView(color: Color.appWhite)
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let namePrefixLabel = UILabel(text: "AC",color: Color.appBlack, font: OpenSans.regular, size: 14)
    let countryFlageImage = UIImageView(image: UIImage(named: ""), contentMode: .scaleAspectFit)
    let uploadedTime = UILabel(text: "", font: OpenSans.regular, size: 12)
    let dot = UIImageView(image: UIImage(named: "dot"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let stateLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let likeButton = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let noOfLikes = UILabel(text: "", font: OpenSans.semiBold, size: 12)
    lazy var titleStack = HorizontalStackView(arrangedSubViews: [nameLabel, countryFlageImage], spacing: 5)
    lazy var subTitleStack = HorizontalStackView(arrangedSubViews: [uploadedTime,dot, stateLabel], spacing: 5)
    lazy var userStack = VerticalStackView(arrangedSubViews: [titleStack, subTitleStack], distribution: .fillProportionally)
    lazy var likesStack = VerticalStackView(arrangedSubViews: [likeButton, noOfLikes])
    lazy var adHeaderStack = HorizontalStackView(arrangedSubViews: [profileView,profileImageView, userStack, UIView(),likesStack], spacing: 10)
    
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
    let adLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16, numberOfLines: 0, alignment: .left)
    let dollarImageView = UIImageView(image: UIImage(named: "dollar"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let priceAmountLabel = UILabel(text: "", color: Color.primary, font: OpenSans.semiBold, size: 14)
    let durationLabel = UILabel(text: "per week", font: OpenSans.regular, size: 14)
    lazy var priceStack = HorizontalStackView(arrangedSubViews: [dollarImageView, priceAmountLabel, durationLabel, UIView()], spacing: 6)
    
    let placeImage = UIImageView(image:UIImage(named: "place") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let location = UILabel(text: "", font: OpenSans.regular, size: 14)
    lazy var locationStack = HorizontalStackView(arrangedSubViews: [placeImage, location, UIView()], spacing: 6)
    
    let bedroomImage =  UIImageView(image:UIImage(named: "bedroomImage") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let bedroomNumberLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    let tubImage =  UIImageView(image:UIImage(named: "tub") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let tubNumberLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    let garageImage =  UIImageView(image:UIImage(named: "garage") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let garageNumberLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    let line =  UIImageView(image:UIImage(named: "line") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let propertyTypeLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    let eyeImage = UIImageView(image:UIImage(named: "eye"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let viewCount = UILabel(text: "", font: OpenSans.regular, size: 14)
    lazy var totalViewStack = VerticalStackView(arrangedSubViews: [eyeImage, viewCount])
    lazy var apartmentDescriptionStack = HorizontalStackView(arrangedSubViews: [bedroomImage, bedroomNumberLabel, tubImage, tubNumberLabel, garageImage, garageNumberLabel, line, propertyTypeLabel, UIView()], spacing: 8)
    let lineView = UIView(color: Color.gray600)
    lazy var middleAdStack = VerticalStackView(arrangedSubViews: [adLabel, priceStack, locationStack, apartmentDescriptionStack], spacing: 8)
    lazy var cellStack = VerticalStackView(arrangedSubViews: [adHeaderStack, middleAdStack, lineView, adFooterStack], spacing: 19)
    let currentView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        observeEvents()
        backgroundColor = Color.gray900
    }
    
    func setupView() {
        contentView.addSubview(currentView)
        currentView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ))
        
        addSubview(gapView)
        gapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        gapView.constraintHeight(constant: 20)
        gapView.backgroundColor = Color.appBlack
        
        lineView.constraintHeight(constant: 0.7)
        lineView.setContentHuggingPriority(.required, for: .vertical)
        lineView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        addSubview(cellStack)
        cellStack.constraintWidth(constant: 100)
        cellStack.anchor(top: gapView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 10, right: 12))
        
        profileView.constraintWidth(constant: 30)
        profileView.constraintHeight(constant: 30)
        profileView.layer.cornerRadius = 15
        profileView.addSubview(namePrefixLabel)
        namePrefixLabel.centerInSuperview()
        
        addSubview(totalViewStack)
        totalViewStack.anchor(top: nil, leading: nil, bottom: lineView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 12))
        viewCount.centerXInSuperview()
        
        currentView.addSubview(circleView)
        circleView.anchor(top: nil, leading: commentsLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        circleView.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor).isActive = true
        circleView.constraintWidth(constant: 14)
        circleView.constraintHeight(constant: 14)
        circleView.addSubview(commentCount)
        commentCount.centerInSuperview()
    }
    
    private func observeEvents() {
        let likeButtonTap = UITapGestureRecognizer(target: self, action: #selector(likeTap))
        likesStack.addGestureRecognizer(likeButtonTap)
        likesStack.isUserInteractionEnabled = true
        
        let callButtonTap = UITapGestureRecognizer(target: self, action: #selector(callTap))
        callStack.addGestureRecognizer(callButtonTap)
        callStack.isUserInteractionEnabled = true
        
        let messageButtonTap = UITapGestureRecognizer(target: self, action: #selector(messageTap))
        messageStack.addGestureRecognizer(messageButtonTap)
        messageStack.isUserInteractionEnabled = true
        
        let commentButtonTap = UITapGestureRecognizer(target: self, action: #selector(commentsTap))
        commentsStack.addGestureRecognizer(commentButtonTap)
        commentsStack.isUserInteractionEnabled = true
    }
    
    @objc func likeTap() {
        print("like")
        handleLike?()
    }
    
    @objc func callTap() {
        print("call")
        handleCall?()
    }
    
    @objc func messageTap() {
        print("message")
        handleMessage?()
    }
    
    @objc func commentsTap() {
        print("comments")
        handleComments?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Cell configuration
extension RoomOfferTableViewCell {
    func configureData(data: RoomOffer) {
        
        namePrefixLabel.text = "\(namePrefix(name: data.userInfo.name))"
        profileImageView.isHidden = true
        nameLabel.text = data.userInfo.name
        countryFlageImage.image = UIImage(named: data.location.country)
        stateLabel.text = data.location.state
        uploadedTime.text = "Posted \(formatDate(from: (data.timestamp)))"
        // Configure likes count
        //        noOfLikes.text = "\(data.likesCount)"
        adLabel.text = data.description
        priceAmountLabel.text = "$\(String(format: "%.2f", data.price))"
        location.text = data.location.state + ", " + data.location.country
        propertyTypeLabel.text = data.propertyType
        bedroomNumberLabel.text = "\(data.noOfBedroom)"
        tubNumberLabel.text = "\(data.noOfBathroom)"
        garageNumberLabel.text = "\(data.noOfParkings)"
        viewCount.text = "\(data.viewCount < 10 ? " " : "")\(data.viewCount)"
        commentCount.text = "\(data.comments.count)"
    }

}

// MARK: Formatting data
extension RoomOfferTableViewCell {
    func formatDate(from timestamp: Double) -> String {
        let currentDate = Date()
        let date = Date(timeIntervalSince1970: timestamp / 1000) // Convert milliseconds to seconds
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .weekOfYear, .day], from: date, to: currentDate)
        
        if let years = components.year, years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if let weeks = components.weekOfYear, weeks > 0 {
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if let days = components.day, days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss" // Customize the time format as needed
            return dateFormatter.string(from: date)
        }
    }
    
    func namePrefix(name: String) -> String {
        let words = name.split(separator: " ")
        var initials = ""
        for word in words {
            initials += word.prefix(1)
        }
        return initials
    }
}
