//
//  RoomOfferModel.swift
//  Discovero
//
//  Created by Mac on 03/10/2023.
//

import Foundation

struct RoomOffer {
    let id, title, description, propertyType: String
    let price: Double
    let noOfBedroom, noOfBathroom, noOfParkings, viewCount, commentCount: Int
    let timestamp: TimeInterval
    let isAnonymous: Bool
    let userInfo: UserInfo
    let location: Location
    let comments, favorites: [String]
}

struct UserInfo:Decodable {
    let name, phoneNo: String
    let languagesSpeaks, uid: [String]
}

struct Location:Decodable {
    let buildingNo, country, state, streetName, streetNo, suburb: String
}

struct Comment:Decodable {
    let comment, commentID, commentedBy, parentCommentID, postID: String
    let commentTime: TimeInterval
    let replies: [Comment]
}
