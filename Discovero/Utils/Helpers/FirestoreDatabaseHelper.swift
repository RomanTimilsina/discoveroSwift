//
//  FirestoreDatabaseHelper.swift
//  Discovero
//
//  Created by Wishuv on 28/09/2023.
//

import Foundation
import UIKit
import FirebaseFirestore



struct FinalModel {
    // Properties from FirstData
    let country: String
    let languages: [String]
    let dialCode: String
    let docId: String
    let locationDetail: LocationDetail
    let phonenumber: Int
    let email: String
    let uid: String
    let name: String
    let gender: String
    let displayLocation: String
    let myads: MyAds
    
    // Properties from SecondData
    let countryCode: String
    
    // Properties from ThirdUserData
    let favorites: [String: Any]
    let phoneNumber: Int
    let fcmToken: String
    let locationDetails: LocationDetails
    
    // Properties for RoomOffer
    let roomOffer: [RoomOffer]
    
    // Properties for RoomWanted
    let roomWanted: [RoomWanted]
    
    // Properties for JobOffer
    let jobOffer: [JobOffer]
    
    // Properties for JobWanted
    let jobWanted: [JobWanted]
    
    // Properties for SalesOffer
    let salesOffer: [SalesOffer]
    
    // Properties for SalesWanted
    let salesWanted: [SalesWanted]
    
    struct LocationDetail {
        let buildingNo: String
        let country: String
        let state: String
        let streetName: String
        let streetNo: String
        let suburb: String
    }
    
    struct LocationDetails {
        let buildingN: String
        let country: String
        let state: String
        let streetName: String
        let streetNo: String
        let suburb: String
    }
    
    struct MyAds {
        // Properties for Announcement
        let announcement: [Announcement]
    }
    
    struct Announcement {
        let adType: String
        let commentCount: Int
        let comments: [Any]
        let description: String
        let expirationDate: String
        let favorites: Favorites
        let id: String
        let isAnonymmous: Int
        let location: LocationDetail
        let timestamp: Int
        let userinfo: UserInfo
        let viewCount: Int
        let viewCountArray: [Any]
    }
    
    struct RoomOffer {
        // Properties for RoomOffer
        let adsType: String
        let commentsCount: Int
        let comments: [Any]
        let description: String
        let expirationDate: Int
        let id: String
        let isAnonymous: Int
        let location: LocationDetail
        let noOfBathrooms: Int
        let noOfBedrooms: Int
        let noOfParkings: Int
        let price: Int
        let propertyType: String
        let timeStamp: Int
        let title: String
        let userInfo: UserInfo
        let viewcount: Int
        let viewedUserIds: [Any]
    }
    
    struct RoomWanted {
        // Properties for RoomWanted
        let adsType: String
        let commentCount: Int
        let comments: [Any]
        let description: String
        let expirationDate: Int
        let favorites: Favorites
        let id: String
        let isAnonymous: Int
        let location: LocationDetail
        let noOfBathrooms: Int
        let noOfBedroomss: Int
        let noOfParkings: Int
        let price: Int
        let propertyType: String
        let soldOut: Int
        let timestamp: Int
        let title: String
        let userInfo: UserInfo
        let viewCount: Int
        let viewCountArray: [Any]
    }
    
    struct JobOffer {
        // Properties for JobOffer
        let adType: String
        let commentCount: Int
        let comments: [Any]
        let descriptions: String
        let expirationData: Int
        let favorites: Favorites
        let id: String
        let isAnonymous: Int
        let isSoldOut: Int
        let jobTypes: String
        let location: LocationDetail
        let noOfPostions: Int
        let paymentTypes: String
        let salary: Int
        let timestamp: Int
        let title: String
        let userInfo: UserInfo
        let viewCount: Int
        let viewCountArray: [Any]
    }
    
    struct JobWanted {
        // Properties for JobWanted
        let adTyps: String
        let commentCount: Int
        let comments: [Any]
        let description: String
        let expirationDate: Int
        let favorites: Favorites
        let id: String
        let isAnonymous: Int
        let isSoldOut: Int
        let jobTyps: String
        let location: LocationDetail
        let paymentType: String
        let salary: Int
        let timestamp: Int
        let title: String
        let userInfo: UserInfo
        let viewCounts: Int
        let viewCountArray: [Any]
    }
    
    struct SalesOffer {
        // Properties for SalesOffer
        let adType: String
        let commentCount: Int
        let commenst: [Any]
        let descriptions: String
        let expirationData: Int
        let favorites: Favorites
        let id: String
        let isAnonymous: Int
        let isSoldOut: Int
        let loaction: LocationDetail
        let noOfitems: Int
        let price: Int
        let salesType: String
        let timestamp: Int
        let title: String
        let userInfo: UserInfo
        let viewCount: Int
        let viewCountArray: [Any]
    }
    
    struct SalesWanted {
        // Properties for SalesWanted
        let adTypes: String
        let commentCount: Int
        let comments: [Any]
        let descriptions: String
        let expirationDate: Int
        let favorites: Favorites
        let id: String
        let isAnonymous: Int
        let isSoldout: Int
        let loaction: LocationDetail
        let noOfItems: Int
        let price: Int
        let salesTypes: String
        let timestamps: Int
        let titles: String
        let userInfo: UserInfo
        let viewCount: Int
        let viewCountArray: [Any]
    }
    
    struct UserInfo {
        // Properties for UserInfo
        let languagesSpeaks: [String]
        let name: String
        let phoneNo: String
        let uid: String
    }
    
    struct Favorites {
        // Properties for Favorites
        let announcement: [Announcement]
        let roomOffer: [RoomOffer]
        let jobOffer: [JobOffer]
        let jobWanted: [JobWanted]
    }
}

struct FireStoreDatabaseHelper {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func checkAuthentication(uid: String) {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            
            let uids = documents.map { $0.data()["uid"] as? String ?? "" }
            if let document = documents.first(where: { $0.data()["uid"] as? String == uid }) {
                let name = document.data()["name"] as? String ?? ""
                let welcomeVC = WelcomeVC()
                welcomeVC.nameText = name
                self.navigationController.pushViewController(welcomeVC, animated: true)
            } else {
                // User not found
                self.navigationController.pushViewController(RegistrationVC(), animated: true)
            }
        }
    }
}
