//
//  RoomOfferModel.swift
//  Discovero
//
//  Created by Mac on 03/10/2023.
//

import Foundation

struct RoomOffer {
    let id, title, description: String
    let price: Double
    let bedrooms, bathrooms, parkings, viewCount, commentCount: Int
    let isAnonymous: Bool
    let userInfo: UserInfo
    let location: Location
    let comments, favorites: [String]
}

struct UserInfo {
    let name, phoneNo: String
    let languagesSpeaks, uid: [String]
}

struct Location {
    let buildingNo, country, state, streetName, streetNo, suburb: String
}

struct Comment {
    let comment, commentID, commentedBy, parentCommentID, postID: String
    let commentTime: TimeInterval
    let replies: [Comment]
}
