//
//  PropertyInfo.swift
//  Discovero
//
//  Created by Mac on 27/09/2023.
//

struct UserModel: Codable {
    let uid: String
    let name: String
    let phoneNo: String
    // Add other properties as needed
    
    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case phoneNo
        // Add other coding keys for additional properties
    }
}

