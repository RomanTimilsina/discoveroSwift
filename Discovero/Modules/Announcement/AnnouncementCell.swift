//
//  AnnouncementCell.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementCell : UICollectionViewCell{
    
    static let identifier = "AnnouncementCell"
    
    var handleTapPost: (()-> Void)?
    var handleLikeTap: (()-> Void)?
    var handleCommentTap: (()-> Void)?
    
    let profileView = UIView(color: Color.appWhite)
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let namePrefixLabel = UILabel(text: "AC",color: Color.appBlack, font: OpenSans.regular, size: 14)
    let uploadedTime = UILabel(text: "", font: OpenSans.regular, size: 12)
    let dotIMageView = UIImageView(image: UIImage(named: "dot"), contentMode: .scaleAspectFit, clipsToBounds: true)
    lazy var dotStack = VerticalStackView(arrangedSubViews: [UIView(), dotIMageView, UIView()], spacing: 0, distribution: .equalCentering)
    let stateLabel = UILabel(text: "New South Wales", font: OpenSans.semiBold, size: 14)
    let eyeImage = UIImageView(image:UIImage(named: "eye"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let viewCount = UILabel(text: "", font: OpenSans.regular, size: 14)
    let gapView = UIView()
    var textView = GradientRectangleView()
    let announcementlabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.regular, size: 18)
    let likeButton = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let likeLabel = UILabel(text: "", font: OpenSans.semiBold, size: 12)
    let messageImageView = UIImageView(image: UIImage(named: "chat"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let messageLabel = UILabel(text: "Message", font: OpenSans.semiBold, size: 14)
    let commentsImageView = UIImageView(image: UIImage(named: "comments"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let commentsLabel = UILabel(text: "Comments", font: OpenSans.semiBold, size: 14)
    let circleImageView = UIImageView(image: UIImage(named: "yellowCircleImg"), contentMode: .scaleAspectFit, clipsToBounds: true )
    let commentCount = UILabel(text: "",color: Color.appBlack, font: OpenSans.semiBold, size: 12)

    lazy var timeStack = HorizontalStackView(arrangedSubViews: [uploadedTime, dotStack, stateLabel], spacing: 5)
    lazy var userStack = VerticalStackView(arrangedSubViews: [nameLabel, timeStack], distribution: .fillProportionally)
    lazy var totalViewStack = VerticalStackView(arrangedSubViews: [eyeImage, viewCount])
    lazy var userInfoStack = HorizontalStackView(arrangedSubViews: [profileView,profileImageView, userStack, UIView(),totalViewStack], spacing: 3)
    lazy var likeStack = HorizontalStackView(arrangedSubViews: [likeButton, likeLabel], spacing: 10, distribution: .equalCentering)
    lazy var messageStack = HorizontalStackView(arrangedSubViews: [ messageImageView , messageLabel], spacing: 10, distribution: .fillProportionally)
    lazy var commentStack = HorizontalStackView(arrangedSubViews: [ commentsImageView , commentsLabel, circleImageView], spacing: 10, distribution: .fillProportionally)
    lazy var reactStack = HorizontalStackView(arrangedSubViews: [likeStack, messageStack, commentStack], spacing: 10, distribution: .equalCentering )
    lazy var allStack = VerticalStackView(arrangedSubViews: [userInfoStack, textView, reactStack], spacing: 10)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        clickOnButtons()
        backgroundColor = Color.gray900
    }
    
    func setupView(){
        
        addSubview(gapView)
        gapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        gapView.constraintHeight(constant: 10)
        gapView.backgroundColor = Color.appBlack
        
        addSubview(allStack)
        allStack.constraintWidth(constant: 100)
        allStack.anchor(top: gapView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding:  .init(top: 10, left: 12, bottom: 10, right: 12))
        
        reactStack.constraintHeight(constant: 20)
        userInfoStack.constraintHeight(constant: 30)
        
        profileView.constraintWidth(constant: 30)
        profileView.constraintHeight(constant: 30)
        profileView.layer.cornerRadius = 15
        profileView.addSubview(namePrefixLabel)
        namePrefixLabel.centerInSuperview()
        
        circleImageView.addSubview(commentCount)
        circleImageView.constraintWidth(constant: 14)
        circleImageView.constraintHeight(constant: 14)
        
        commentCount.centerInSuperview()
        
//        textView.constraintHeight(constant: 200)
        textView.addSubview(announcementlabel)
        announcementlabel.centerInSuperview()
    }
     
    func clickOnButtons() {
        let viewtapGesture = UITapGestureRecognizer(target: self, action: #selector(clickOnPost))
        textView.addGestureRecognizer(viewtapGesture)
        textView.isUserInteractionEnabled = true
        
        let liketapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedOnLike))
        likeButton.addGestureRecognizer(liketapGesture)
        likeButton.isUserInteractionEnabled = true
        
        let actionGesture = UITapGestureRecognizer(target: self, action: #selector(clickedOnComment))
        commentsImageView.addGestureRecognizer(actionGesture)
        commentsImageView.isUserInteractionEnabled = true
    }

    @objc func clickedOnLike() {
        handleLikeTap?()
    }
    
    @objc func clickedOnComment() {
        handleCommentTap?()
    }
    
    @objc func clickOnPost() {
        handleTapPost?()
    }
    
    func configureData(data : AnnouncementModel){
        debugPrint(data)
        namePrefixLabel.text = "\(namePrefix(name: data.userInfo.name))"
        profileImageView.isHidden = true
        announcementlabel.text = data.description
        nameLabel.text = data.userInfo.name
        stateLabel.text = data.location.state
        uploadedTime.text = "Posted \(formatDate(from: (data.timestamp)))"
        viewCount.text = "\(data.viewCount < 10 ? " " : "")\(data.viewCount)"
//        likeLabel.text = data.likes
        commentCount.text = "\(data.commentCount)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Formatting data
extension AnnouncementCell {
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
            dateFormatter.dateFormat = "HH:mm:ss" 
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
