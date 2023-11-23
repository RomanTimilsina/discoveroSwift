//
//  AllUserData.swift
//  Discovero
//
//  Created by Mac on 09/10/2023.
//

import Foundation

struct UserData: Codable {
    let countryCode: String
    let name: String
    let phoneNumber: String
    var country: String
    let displayLocation: String
    let uid: String
    var locationDetail: LocationDetail
    let dialCode: String
    let languages: [String]
}

struct LocationDetail: Codable {
    let buildingNo: String
    let country: String
    var state: String
    let streetName: String
    let streetNo: String
    var suburb: String
}
