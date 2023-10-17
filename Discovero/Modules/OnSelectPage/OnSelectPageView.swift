//
//  OnSelectPageView.swift
//  Discovero
//
//  Created by Mac on 19/09/2023.
//

import UIKit

class OnSelectPageView: UIView {
    
    var handleToggleButtonTap: ((Bool, CGFloat) -> Void)?
    
    let profileImageView = UIImageView(image: UIImage(named: "AC"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameLabel = UILabel(text: "ankit chaudhary", font: OpenSans.semiBold, size: 14)
    let countryFlageImage = UIImageView(image: UIImage(named: "nepal"), contentMode: .scaleAspectFit)
    let timeSinceUploadLabel = UILabel(text: "41 minutes ago", font: OpenSans.regular, size: 12)
    let dot = UIImageView(image: UIImage(named: "dot"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let nswLabel = UILabel(text: "NSW", font: OpenSans.semiBold, size: 14)
    let heartImage = UIImageView(image: UIImage(named: "heart"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let noOfLikes = UILabel(text: "100", font: OpenSans.semiBold, size: 12)
    lazy var titleStack = HorizontalStackView(arrangedSubViews: [nameLabel, countryFlageImage], spacing: 5)
    lazy var subTitleStack = HorizontalStackView(arrangedSubViews: [timeSinceUploadLabel,dot, nswLabel], spacing: 5)
    lazy var UserStack = VerticalStackView(arrangedSubViews: [titleStack, subTitleStack], distribution: .fillProportionally)
    lazy var likesStack = VerticalStackView(arrangedSubViews: [heartImage, noOfLikes])
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
    lazy var adDescritionText = "Room available at Hurstbille approximately 3-4 mins walk to the hurstville station, in built wardrobe separate bathroom, other bills. Please contact 0411778293, 0423728188(call or text) for details, we heartly welcome only to non smokers and drinkerswardrobe separate bathroom, other bills. Please contact 0411778293, 0423728188(call or text) for details, we heartly welcome only to non smokers and drinkerswardrobe separate bathroom, other bills. Please contact 0411778293, 0423728188(call or text) for details, we heartly welcome onwardrobe separate bathroom, other bills."
    lazy var adDesciptionLabel = UILabel(text: adDescritionText, font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .left)
    
    let dollarImageView = UIImageView(image: UIImage(named: "dollar"), contentMode: .scaleAspectFit, clipsToBounds: true)
    let priceAmountLabel = UILabel(text: "$879.00", color: Color.primary, font: OpenSans.semiBold, size: 14)
    let durationLabel = UILabel(text: "per week", font: OpenSans.semiBold, size: 14)
    lazy var priceStack = HorizontalStackView(arrangedSubViews: [dollarImageView, priceAmountLabel, durationLabel, UIView()], spacing: 6)
    let placeImage = UIImageView(image:UIImage(named: "place") ,contentMode: .scaleAspectFit, clipsToBounds: true)
    let location = UILabel(text: "Fredrick St.Broome", font: OpenSans.regular, size: 14)
    lazy var locationStack = HorizontalStackView(arrangedSubViews: [placeImage, location, UIView()], spacing: 6)
    lazy var priceAndLocation = VerticalStackView(arrangedSubViews: [priceStack, locationStack])
    lazy var detailsStack = HorizontalStackView(arrangedSubViews: [priceAndLocation, UIView(), totalViewStack], spacing: 6)
    let bedroomImage =  UIImageView(image:UIImage(named: "bedroomImage") ,contentMode: .scaleAspectFit, clipsToBounds: true)
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
    let showToggleButton = DIButton(buttonTitle: "Show Less", blackButton: true)
    lazy var middleAdStack = VerticalStackView(arrangedSubViews: [detailsStack, apartmentDescriptionStack, adLabel, adDesciptionLabel, showToggleButton], spacing: 8, distribution: .fill)
    //Comments list
    let gapView = UIView(color: .clear)
    let commentsTitle =  UILabel(text: "Comments", font: OpenSans.semiBold, size: 14)
    let comment = CustomComments()
    let comment2 = CustomComments(isReply: true)
    lazy var commentArray = [comment, comment2]
    lazy var comentsList = VerticalStackView(arrangedSubViews: commentArray, spacing: 12)
    lazy var cellStack = VerticalStackView(arrangedSubViews: [adHeaderStack, middleAdStack, commentsTitle, comentsList, gapView, adFooterStack], spacing: 12, distribution: .fillProportionally)
    let scrollView = UIScrollView()
    lazy var adsHeight = adDesciptionLabel.bounds.size.height
    let headerView = DIHeaderView(title: "Comments", hasBack: true, hasBGColor: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = Color.appBlack
    }
    
    func setup() {
        addSubview(headerView)
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 5, bottom: 0, right: 0))
        headerView.constraintHeight(constant: 50)
        
        gapView.constraintHeight(constant: 20)
        
        addSubview(scrollView)
        scrollView.anchor(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 5, bottom: 0, right: 0))
        
        scrollView.addSubview(cellStack)
        cellStack.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: -370))
        
        
        
        showToggleButton.addTarget(self, action: #selector(showToggle), for: .touchUpInside)
    }
    
    @objc func showToggle() {
        let showLess = showToggleButton.titleLabel?.text == "Show Less"
        handleToggleButtonTap?(showLess, adsHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
