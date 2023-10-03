//
//  FirestoreDatabaseHelper.swift
//  Discovero
//
//  Created by Mac on 28/09/2023.
//

import Foundation
import UIKit
import FirebaseFirestore

struct UsersInfoList {
    typealias Item = [String: Any]
    let country, dialCode, docId, uid, name, gender, displayLocation, countryCode, email: String
    let phoneNumber: Int
    let languages: [String]
    let locationDetail, locationDetails: Location
    let myAds: [Announcement]
    let roomOffer, roomWanted, jobOffer, jobWanted, salesOffer, salesWanted: [Item]
    let favorites: [String: Any]
    
    struct Location {
        let buildingNo, country, state, streetName, streetNo, suburb: String
    }
    
    struct Announcement {
        let adType, description, expirationDate, id, propertyType, title: String
        let commentCount, isAnonymous, noOfBathrooms, noOfBedrooms, noOfParkings, price, timeStamp, viewCount: Int
        let comments, viewedUserIds: [Any]
        let userInfo: UserInfo
    }
    
    struct UserInfo {
        let languagesSpeaks, phoneNo, uid: String
    }
}

struct FireStoreDatabaseHelper {
    var handleNextPage: ((UIViewController) -> Void)?
    func checkAuthentication(uid: String, phone: String, completion: @escaping ([QueryDocumentSnapshot]) -> Void) {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            
            completion(documents)
        }
    }
    
    func getRoomOffered(completion: @escaping ([QueryDocumentSnapshot]) -> Void) {
        Firestore.firestore().collection("RoomOffer").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            completion(documents)

        }
    }
}

