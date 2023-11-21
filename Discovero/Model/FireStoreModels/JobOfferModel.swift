//
//  JobOfferModel.swift
//  Discovero
//
//  Created by admin on 20/11/2023.
//

import Foundation


struct JobOffer: Decodable {
    let id: String
    let title: String
    let description: String
    let salary: Int
    let noOfPositions: Int
    let jobType: String
    let timestamp: TimeInterval
    let viewCount: Int
    let commentCount: Int
    let isAnonymous: Bool
    let userInfo: UserInfos
    let location: Location
    let comments: [String]
    let favorites: [String]
    let viewCountArray: [String]
    let adType: String
    let expirationDate: TimeInterval
    let isSoldOut: Bool
    let paymentType: String
    let lastUpdated: TimeInterval
    
}

struct UserInfos:Decodable {
    let name, phoneNo, uid: String
    let languagesSpeaks: [String]
}

struct Comments:Decodable {
    let comment, commentID, commentedBy, parentCommentID, postID: String
    let commentTime: TimeInterval
    let replies: [Comment]
}
