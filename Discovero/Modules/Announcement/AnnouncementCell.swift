//
//  AnnouncementCell.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementCell : UICollectionViewCell{
    
    static let cellId = "AnnouncementCell"
    
    var handleTapPost: (()-> Void)?
    var handleLikeTap: (()-> Void)?
    var handleCommentTap: (()-> Void)?
    
    
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let namePrefixLabel = UILabel(text: "AC",color: Color.appBlack, font: OpenSans.regular, size: 14)
    let uploadedTime = UILabel(text: "", font: OpenSans.regular, size: 12)
    let dotIMageView = UIImageView(image: UIImage(named: "dotimg"), contentMode: .scaleAspectFit, clipsToBounds: true)
    lazy var dotStack = VerticalStackView(arrangedSubViews: [UIView(), dotIMageView, UIView()], spacing: 0, distribution: .equalCentering)
    let stateLabel = UILabel(text: "New South Wales", font: OpenSans.semiBold, size: 14)
    let eyeImage = UIImageView(image:UIImage(named: "eye"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let viewCount = UILabel(text: "", font: OpenSans.regular, size: 14)

    
    var textView = GradientRectangleView()
    let announcementlabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.regular, size: 18)
    let likeButton = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let likeLabel = UILabel(text: "", font: OpenSans.semiBold, size: 12)
    let messageImageView = UIImageView(image: UIImage(named: "chat"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let messageLabel = UILabel(text: "Message", font: OpenSans.semiBold, size: 14)
    let commentsImageView = UIImageView(image: UIImage(named: "comments"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let commentsLabel = UILabel(text: "Comments", font: OpenSans.semiBold, size: 14)

    
    let circleView = UIView(color: Color.primary, cornerRadius: 7)
    let commentCount = UILabel(text: "",color: Color.appBlack, font: OpenSans.semiBold, size: 12)
    
    let text: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text")
        return image
    }()
    
    let hearts: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")
        return image
    }()
    
    lazy var userStack = HorizontalStackView(arrangedSubViews: [nameLabel, UIView(), eyeImage], spacing: 2)
    lazy var timeStack = HorizontalStackView(arrangedSubViews: [uploadedTime, dotStack, stateLabel, UIView(), viewCount], spacing: 4)
    lazy var userInfoStack = VerticalStackView(arrangedSubViews: [userStack, timeStack], spacing: 3)
    lazy var picStack = HorizontalStackView(arrangedSubViews: [profileImageView, userInfoStack], spacing: 5)
    lazy var likeStack = HorizontalStackView(arrangedSubViews: [likeButton, likeLabel], spacing: 10, distribution: .fillProportionally)
    lazy var messageStack = HorizontalStackView(arrangedSubViews: [ messageImageView , messageLabel], spacing: 10, distribution: .fillProportionally)
    lazy var commentStack = HorizontalStackView(arrangedSubViews: [ commentsImageView , commentsLabel, circleView], spacing: 10, distribution: .fillProportionally)
    lazy var reactStack = HorizontalStackView(arrangedSubViews: [likeStack, messageStack, commentStack], spacing: 10, distribution: .equalCentering )
    lazy var allStack = VerticalStackView(arrangedSubViews: [picStack, textView, reactStack], spacing: 10)
//    let currentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        clickOnButtons()
    }
    
    func setupView(){
        addSubview(allStack)
        allStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor , padding:  .init(top: 10, left: -10, bottom: 0, right: -10))
        
//        currentView.addSubview(circleView)
//        circleView.anchor(top: nil, leading: commentsLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 5))
//        circleView.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor).isActive = true
        circleView.constraintWidth(constant: 14)
        circleView.constraintHeight(constant: 14)
        circleView.addSubview(commentCount)
        commentCount.centerInSuperview()
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
        namePrefixLabel.text = "\(namePrefix(name: data.userInfo.name))"
        profileImageView.isHidden = true
        nameLabel.text = data.userInfo.name
        stateLabel.text = data.location.state
        uploadedTime.text = "Posted \(formatDate(from: (data.timestamp)))"
        viewCount.text = "\(data.viewCount < 10 ? " " : "")\(data.viewCount)"
//        likeLabel.text = data.likes
        commentCount.text = "\(data.comments.count)"
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
