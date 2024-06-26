//
//  PostPreviewCell.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

class PostView: UIView {
    
    let gapView = UIView()
    
    var usersData: UserData?
    //Ads header part
    let profileView = UIView(color: Color.appWhite)
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "", font: OpenSans.semiBold, size: 14)
    let namePrefixLabel = UILabel(text: "AC",color: Color.appBlack, font: OpenSans.regular, size: 14)
    let countryFlageImage = UIImageView(image: UIImage(named: ""), contentMode: .scaleAspectFit)
    let uploadedTime = UILabel(text: "0 seconds ago", font: OpenSans.regular, size: 12)
    let dot = UIImageView(image: UIImage(named: "dot"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let stateLabel = UILabel(text: "New South Wales", font: OpenSans.semiBold, size: 14)
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
    lazy var commentsStack = HorizontalStackView(arrangedSubViews: [commentsImageView, commentsLabel, UIView()], spacing: 10)
    let announcmentLikeButton = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    lazy var adFooterStack = HorizontalStackView(arrangedSubViews: [callStack, announcmentLikeButton, messageStack, commentsStack], distribution: .fillEqually)
    
    // Ads middle part
    let adLabel = UILabel(text: "", font: OpenSans.semiBold, size: 16, numberOfLines: 0, alignment: .left)
    let dollarImageView = UIImageView(image: UIImage(named: "dollar"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let priceAmountLabel = UILabel(text: "", color: Color.primary, font: OpenSans.semiBold, size: 14)
    let durationLabel = UILabel(text: "per week", font: OpenSans.regular, size: 14)
    lazy var priceStack = HorizontalStackView(arrangedSubViews: [dollarImageView, priceAmountLabel, durationLabel, UIView()], spacing: 6)
    
    let placeImage = UIImageView(image:UIImage(named: "place") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let location = UILabel(text: "", font: OpenSans.regular, size: 14)
    lazy var locationStack = HorizontalStackView(arrangedSubViews: [placeImage, location, UIView()], spacing: 6)
    
    var bedroomImage =  UIImageView(image:UIImage(named: "bedroomImage") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let bedroomNumberLabel = UILabel(text: "", font: OpenSans.regular, size: 14)
    var tubImage =  UIImageView(image:UIImage(named: "tub") ,contentMode: .scaleAspectFit, clipsToBounds: true)
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
    var textView = GradientRectangleView()
    lazy var cellStack = VerticalStackView(arrangedSubViews: [adHeaderStack, middleAdStack, textView, lineView, adFooterStack], spacing: 19)
    let view = UIView()
    let announcementlabel = UILabel(text: "", color: Color.appBlack, font: OpenSans.regular, size: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fetchUserData()
        backgroundColor = Color.gray900
        
        namePrefixLabel.text = "\(namePrefix(name: usersData?.name ?? ""))"
        profileImageView.isHidden = true
        nameLabel.text = usersData?.name
    }
    
    func setupView() {
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ))
        
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
        
        textView.constraintHeight(constant: 200)
        textView.addSubview(announcementlabel)
        announcementlabel.centerInSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Cell configuration
extension PostView {
    
    private func fetchUserData() {
        func getUsersDataFromDefaults() {
            FireStoreDatabaseHelper().getUserDataFromDefaults { [weak self] userData in
                guard let self, let userData else { return }

                usersData = userData
            }
        }
    }
    
    func configureData(roomData: PostModel? = nil, jobData: JobModel? = nil, buyAndSellData: BuySellModel? = nil) {
        if let roomData {
            namePrefixLabel.text = "\(namePrefix(name: usersData?.name ?? ""))"
            profileImageView.isHidden = true
            nameLabel.text = usersData?.name
            countryFlageImage.image = UIImage(named: roomData.country)
            stateLabel.text = roomData.state
            adLabel.text = roomData.description
            priceAmountLabel.text = "$\(String(format: "%.2f", roomData.price))"
            location.text = roomData.state + ", " + roomData.country
            propertyTypeLabel.text = roomData.propertyType
            bedroomNumberLabel.text = "\(roomData.noOfBedroom)"
            tubNumberLabel.text = "\(roomData.noOfBathroom)"
            garageNumberLabel.text = "\(roomData.noOfParkings)"
        }
        
        if let jobData {
            namePrefixLabel.text = "\(namePrefix(name: usersData?.name ?? ""))"
            profileImageView.isHidden = true
            nameLabel.text = usersData?.name
            countryFlageImage.image = UIImage(named: jobData.country)
            stateLabel.text = jobData.state
            adLabel.text = jobData.description
            priceAmountLabel.text = "$\(String(format: "%.2f", jobData.salary))"
            location.text = jobData.state + ", " + jobData.country
            propertyTypeLabel.text = jobData.jobType
            bedroomNumberLabel.text = "\(jobData.noOfPostion)"
            durationLabel.text = "\(jobData.salarySideTitle)"
            bedroomImage.image = UIImage(named: "jobsImage")
        }
        
        if let buyAndSellData {
            namePrefixLabel.text = "\(namePrefix(name: usersData?.name ?? ""))"
            profileImageView.isHidden = true
            nameLabel.text = usersData?.name
            countryFlageImage.image = UIImage(named: buyAndSellData.country)
            stateLabel.text = buyAndSellData.state
            adLabel.text = buyAndSellData.description
            priceAmountLabel.text = "$\(String(format: "%.2f", buyAndSellData.price))"
            location.text = buyAndSellData.state + ", " + buyAndSellData.country
            propertyTypeLabel.text = buyAndSellData.productTypeLabel
            bedroomNumberLabel.text = "\(buyAndSellData.noOfItems)"
            bedroomImage.image = UIImage(named: "salesImage")
        }
    }
}

// MARK: Formatting data
extension PostView {
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


