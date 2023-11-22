//
//  MyProfile.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileView: UIView {
    
    
    var onClickedLogOut:   (() -> Void)?
    var onClickedDelete:   (() -> Void)?
    
    let header = DIHeaderView(title: "Account Details")
    let scrollView = UIScrollView()
    var profileArray = [DICustomProfileView]()
    let noAvatarImage = UIImageView(image: UIImage(named: "noAvatarImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let nameView = DICustomProfileView(titleText: "Full Name", text: "Ankit Chaudhary", show: true)
    let emailView = DICustomProfileView(titleText: "Email Address", text: "Tap here to add email", show: true)
    let phoneView = DICustomProfileView(titleText: "Phone Number", text: "+677-9851442275")
    let addressView = DICustomProfileView(titleText: "Address", text: "Frederick St,Broome", show: true)
    let languagesView = DICustomProfileView(titleText: "Languages", text: "Nepali",  show: true)
    var languageArray: [String]?
    let genderView = DICustomProfileView(titleText: "Gender", text: "Male", show: true)
    let adsView = DICustomProfileView(titleText: "My Ads", text: "", show: true)
    let favouritesView = DICustomProfileView(titleText: "My Favourites", text: "", show: true)
    let notificationView = DICustomProfileView(titleText: "Notification Configuration", text: "", show: true)
    let termsView = DICustomProfileView(titleText: "Terms and condition", text: "", show: true)
    let policyView = DICustomProfileView(titleText: "Privacy Policy", text: "", show: true)
    let deleteLabel =   UILabel(text: "Delete Account", color: .red , font: OpenSans.regular, size: 14)
    let line = UIView(color: Color.gray700)
    let logoutLabel = UILabel(text: "Logout", color: Color.primary, font: OpenSans.regular, size: 14)
    
    lazy var formStack = VerticalStackView(arrangedSubViews: [nameView,emailView,phoneView,addressView,languagesView,genderView,line,adsView,favouritesView,notificationView,termsView,policyView,deleteLabel, logoutLabel], spacing: 24, distribution: .fill)
    var countryName, stateName, suburbName, streetName, streetNo, buildingNo: String?
    
    let notification = ConfigureNotificationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupView()
        observeEvents()
        profileArrayAppendFunction()
        removeLinesFromView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(header)
        header.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        header.constraintHeight(constant: 50)
        
        addSubview(scrollView)
        scrollView.anchor(top: header.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 0))
        
        scrollView.addSubview(noAvatarImage)
        noAvatarImage.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 22, left: 0, bottom: 0, right: 0))
        noAvatarImage.centerXInSuperview()
        noAvatarImage.constraintHeight(constant: 80)
        
        scrollView.addSubview(formStack)
        formStack.anchor(top: noAvatarImage.bottomAnchor, leading: leadingAnchor, bottom: scrollView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 10, right: 24))
        
        line.constraintHeight(constant: 1)
        
        addSubview(notification)
        notification.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        notification.isHidden = true
    }
    
    func removeLinesFromView() {
        for (index, view) in profileArray.enumerated() {
            view.lineView.removeFromSuperview()
        }
    }
    
    func observeEvents() {
        let logOutTapGestrue = UITapGestureRecognizer(target: self , action: #selector(handleLogOutTap))
        logoutLabel.addGestureRecognizer(logOutTapGestrue)
        logoutLabel.isUserInteractionEnabled = true
        
        let deleteTapGestrue = UITapGestureRecognizer(target: self , action: #selector(handleDeleteTap))
        deleteLabel.addGestureRecognizer(deleteTapGestrue)
        deleteLabel.isUserInteractionEnabled = true
    }
    
    @objc func handleLogOutTap() {
        onClickedLogOut?()
    }
    
    @objc func handleDeleteTap() {
        onClickedDelete?()
    }
}

// MARK: Append Data
private extension MyProfileView{
    
    func profileArrayAppendFunction() {
        profileArray.append(nameView)
        profileArray.append(emailView)
        profileArray.append(phoneView)
        profileArray.append(addressView)
        profileArray.append(languagesView)
        profileArray.append(genderView)
        profileArray.append(adsView)
        profileArray.append(notificationView)
        profileArray.append(favouritesView)
        profileArray.append(termsView)
        profileArray.append(policyView)
    }
}


