////
////  AnnoucementModel.swift
////  Discovero
////
////  Created by admin on 23/11/2023.
////
//
//
//import UIKit
//
//struct AnnouncementModel: Decodable {
//    let username: String
//    let postTime: String
//    var views: String
//    var likes: String
//    var comments: String
//}
//
// 
//struct AnnouncementManager {
//    
//    var data = [AnnouncementModel]()
//    
//    init(){
//        data.append(AnnouncementModel( username: "Samman Shakaya", postTime: "34 minutes ago", views: "200", likes: "42", comments: "7"))
//        data.append(AnnouncementModel( username: "Samman Shakaya", postTime: "34 minutes ago", views: "200", likes: "42", comments: "7"))
//        data.append(AnnouncementModel( username: "Samman Shakaya", postTime: "34 minutes ago", views: "200", likes: "42", comments: "7"))
//        data.append(AnnouncementModel( username: "Samman Shakaya", postTime: "34 minutes ago", views: "200", likes: "42", comments: "7"))
//        data.append(AnnouncementModel( username: "Samman Shakaya", postTime: "34 minutes ago", views: "200", likes: "42", comments: "7"))
//    }
//}
//
//

import Foundation

struct AnnouncementModel {
    let id: String
    let description: String
    let timestamp: TimeInterval
    var viewCount: Int
    var commentCount: Int
    let isAnonymous: Bool
    let userInfo: UserInfos
    let location: Location
    let comments: [String]
    let favorites: [String]
    let viewCountArray: [String]
    let expirationDate: TimeInterval
    let adType: String
    let lastUpdated: TimeInterval
}

