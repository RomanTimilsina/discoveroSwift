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
var roomOffers: [RoomOffer] = []

struct FireStoreDatabaseHelper {
   
    var handleNextPage: ((UIViewController) -> Void)?
    func checkAuthentication(uid: String, phone: String, completion: @escaping (String, String) -> Void) {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            let uids = documents.map { $0.data()["uid"] as? String ?? "" }
            if let document = documents.first(where: { $0.data()["uid"] as? String == uid }) {
                let name = document.data()["name"] as? String ?? ""
                completion(name, "")
            } else {
                completion("", uid)
            }
        }
    }
    
     func getRoomOffered(completion: @escaping ([RoomOffer]) -> Void) {
        Firestore.firestore().collection("RoomOffer").getDocuments { query, error in
            
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            for document in documents {
                let data = document.data()
                let id = data["id"] as? String
                let title = data["title"] as? String
                let description = data["description"] as? String
                let price = data["price"] as? Double
                let bedrooms = data["noOfBedrooms"] as? Int
                let bathrooms = data["noOfBathrooms"] as? Int
                let parkings = data["noOfParkings"] as? Int
                let propertyType = data["propertyType"] as? String
                let timestamp = data["timestamp"] as? TimeInterval
                let viewCount = data["viewCount"] as? Int
                let commentCount = data["commentCount"] as? Int
                let isAnonymous = data["isAnonymous"] as? Bool
                let userInfoData = data["userInfo"] as? [String: Any]
                let locationData = data["location"] as? [String: String]
                let comments = data["comments"] as? [String]
                let favorites = data["favorites"] as? [String]
                
                let userInfoName = userInfoData?["name"] as? String
                let userInfoPhoneNo = userInfoData?["phoneNo"] as? String
                let userInfoLanguagesSpeaks = userInfoData?["languagesSpeaks"] as? [String]
                let userInfoUid = userInfoData?["uid"] as? [String]
                let locationBuildingNo = locationData?["buildingNo"]
                let locationCountry = locationData?["country"]
                let locationState = locationData?["state"]
                let locationStreetName = locationData?["streetName"]
                let locationStreetNo = locationData?["streetNo"]
                let locationSuburb = locationData?["suburb"]
                
                
                let userInfo = UserInfo(
                    name: userInfoName ?? "",
                    phoneNo: userInfoPhoneNo ?? "",
                    languagesSpeaks: userInfoLanguagesSpeaks ?? [],
                    uid: userInfoUid ?? []
                )
                
                let location = Location(
                    buildingNo: locationBuildingNo ?? "",
                    country: locationCountry ?? "",
                    state: locationState ?? "",
                    streetName: locationStreetName ?? "",
                    streetNo: locationStreetNo ?? "",
                    suburb: locationSuburb ?? ""
                )
                
                let roomOffer = RoomOffer(
                    id: id ?? "",
                    title: title ?? "",
                    description: description ?? "",
                    propertyType: propertyType ?? "",
                    price: price ?? 0,
                    noOfBedroom: bedrooms ?? 0,
                    noOfBathroom: bathrooms ?? 0,
                    noOfParkings: parkings ?? 0,
                    viewCount: viewCount ?? 0,
                    commentCount: commentCount ?? 0,
                    timestamp: timestamp ?? 0,
                    isAnonymous: isAnonymous ?? false,
                    userInfo: userInfo,
                    location: location,
                    comments: comments ?? [],
                    favorites: favorites ?? []
                )
                
                roomOffers.append(roomOffer)
            }
            completion(roomOffers)

        }
    }
}

