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
    let country: String
    let displayLocation: String
    let uid: String
    let locationDetail: LocationDetail
    let dialCode: String
    let languages: [String]
}

struct LocationDetail: Codable {
    let buildingNo: String
    let country: String
    let state: String
    let streetName: String
    let streetNo: String
    let suburb: String
}
