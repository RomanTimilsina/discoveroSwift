//
//  MyProfileModel.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

struct ProfileModel {
    let title: String
    let value: String
}

struct ProfileManager {
    private var data = [ProfileModel]()
    
    init() {
        data.append(ProfileModel(title: "Full Name", value: "Name"))
        data.append(ProfileModel(title: "Email Address", value: "Email"))
        data.append(ProfileModel(title: "Phone Number", value: "(9898989898)"))
        data.append(ProfileModel(title: "Address", value: "ktm"))
        data.append(ProfileModel(title: "Nationality", value: "Nepali"))
        data.append(ProfileModel(title: "Gender", value: "Male"))
        data.append(ProfileModel(title: "", value: ""))
        data.append(ProfileModel(title: "a", value: "a"))
    }
    
    func getData () -> [ProfileModel] {
        return data
    }
}
