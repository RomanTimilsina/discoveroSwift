//
//  FirestoreDatabaseHelper.swift
//  Discovero
//
//  Created by Wishuv on 28/09/2023.
//

import Foundation
import UIKit
import FirebaseFirestore

struct UserProfile {
    let favorites: [String: Any]
    let phoneNumber: Int
    let fcmToken: String
    let gender: String
    let docId: String
    let myAds: [String: [Ad]]
    let languages: [String]
    let name: String
    let locationDetail: LocationDetail
    let email: String
    let country: String
    let dialCode: String
    let displayLocation: String
    let uid: String
    let countryCode: String
}

struct LocationDetail {
    let buildingNo: String
    let country: String
    let state: String
    let streetName: String
    let streetNo: String
    let suburb: String
}

struct Ad {
    let adType: String
    let commentCount: Int
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
    let timestamp: Int
    let title: String
    let userInfo: UserInfo
    let viewCount: Int
}

struct Location {
    let buildingNo: String
    let country: String
    let state: String
    let streetName: String
    let streetNo: String
    let suburb: String
}

struct UserInfo {
    let languagesSpeaks: [String]
    let name: String
    let phoneNo: String
    let uid: String
}


enum Advertisement {
    case roomOffer(RoomAd)
    case roomWanted(RoomAd)
    case salesOffer(SalesAd)
    case salesWanted(SalesAd)
}

struct RoomAd {
    let adsType: String
    let commentCount: Int
    let comments: [String]
    let description: String
    let expirationDate: Int
    let favorites: [String]
    let id: String
    let isAnonymous: Int
    let location: Location
    let noOfBathrooms: Int
    let noOfBedrooms: Int
    let noOfParkings: Int
    let price: Int
    let propertyType: String
    let soldOut: Int
    let timestamp: Int
    let title: String
    let userInfo: UserInfo
    let viewCount: Int
    let viewedUserIds: [String]
}

struct SalesAd {
    let adType: String
    let commentCount: Int
    let comments: [String]
    let description: String
    let expirationDate: Int
    let favorites: [String]
    let id: String
    let isAnonymous: Int
    let isSoldOut: Int
    let location: Location
    let noOfItems: Int
    let price: Int
    let salesType: String
    let timestamp: Int
    let title: String
    let userInfo: UserInfo
    let viewCount: Int
    let viewCountArray: [String]
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
                // Show alert
                return
            }
            guard let documents = query?.documents else { return }
            
            let uids = documents.map { $0.data()["uid"] as? String ?? "" }
            if uids.contains(uid) {
                self.navigationController.pushViewController(RoomVC(), animated: true)
            } else {
                self.navigationController.pushViewController(RegistrationVC(), animated: true)
            }
        }
    }
}
