//
//  MyProfile.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileView: UIView {
    
    let header = DIHeaderView(title: "Account Details")
    var profileArray = [DICustomProfileView]()
    
    let noAvatarImage = UIImageView(image: UIImage(named: "noAvatarImage"),contentMode: .scaleAspectFit, clipsToBounds: true)
    
    let nameView = DICustomProfileView(titleText: "Full Name", text: "Ankit Chaudhary", show: true)
    
    let emailView = DICustomProfileView(titleText: "Email Address", text: "Tap here to add email", show: true, isGrey: true)
    
    let phoneView = DICustomProfileView(titleText: "Phone Number", text: "+677-9851442275")
    
    let addressView = DICustomProfileView(titleText: "Address", text: "Frederick St,Broome", show: true)
    
    let nationalityView = DICustomProfileView(titleText: "Nationality", text: "Nepali", nation: UIImage(named: "nepal"), show: true)
    
    let genderView = DICustomProfileView(titleText: "Gender", text: "Male", show: true)
    
    let adsView = DICustomProfileView(titleText: "My Ads", text: "", show: true)
    let favouritesView = DICustomProfileView(titleText: "My Favourites", text: "", show: true)
    let termsView = DICustomProfileView(titleText: "Terms and condition", text: "", show: true)
    let policyView = DICustomProfileView(titleText: "Privacy Policy", text: "", show: true)
    let DeleteView = DICustomProfileView(titleText: "Delete Account", text: "")
    let line = UIView(color: Color.gray700)
    let logoutLabel = UILabel(text: "Logout", color: Color.primary, font: OpenSans.regular, size: 14)
    
    lazy var formStack = VerticalStackView(arrangedSubViews: [nameView,emailView,phoneView,addressView,nationalityView,genderView,line,adsView,favouritesView,termsView,policyView,DeleteView, logoutLabel], spacing: 18, distribution: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupConstraint()
        profileArrayFunction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint () {
        
        addSubview(header)
        header.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(noAvatarImage)
        noAvatarImage.anchor(top: header.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        noAvatarImage.centerXInSuperview()
        noAvatarImage.constraintWidth(constant: 80)
        
        addSubview(formStack)
        formStack.anchor(top: noAvatarImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 12, bottom: 100, right: 12))
        
        line.constraintHeight(constant: 1)
    }
    
    func profileArrayFunction() {
        profileArray.append(nameView)
        profileArray.append(emailView)
        profileArray.append(phoneView)
        profileArray.append(addressView)
        profileArray.append(nationalityView)
        profileArray.append(genderView)
        profileArray.append(adsView)
        profileArray.append(favouritesView)
        profileArray.append(termsView)
        profileArray.append(policyView)
        profileArray.append(DeleteView)
    }
}
