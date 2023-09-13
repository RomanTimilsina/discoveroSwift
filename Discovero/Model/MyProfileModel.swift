//
//  MyProfileModel.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

struct profileModel {
    let title: String
    let value: String
}

struct profileManager {
    private var data = [profileModel]()
    
    init() {
        data.append(profileModel(title: "Full Name", value: "Name"))
        data.append(profileModel(title: "Email Address", value: "Email"))
        data.append(profileModel(title: "Phone Number", value: "(9898989898)"))
        data.append(profileModel(title: "Address", value: "ktm"))
        data.append(profileModel(title: "Nationality", value: "Nepali"))
        data.append(profileModel(title: "Gender", value: "Male"))
        data.append(profileModel(title: "", value: ""))
        data.append(profileModel(title: "a", value: "a"))
        
    }
    
    func getData () -> [profileModel] {
        return data
    }
}
