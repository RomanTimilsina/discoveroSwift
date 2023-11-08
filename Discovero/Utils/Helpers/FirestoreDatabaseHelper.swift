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
var roomWanted: [RoomOffer] = []
var lastDocument: DocumentSnapshot?
var next: Query?
var batchSize = 33
var isFirst = true
var firstTimeRun = true
var selectedLanguage: [String] = []
var loopOnce = true

struct FireStoreDatabaseHelper {
    
//    var handleNextPage: ((UIViewController) -> Void)?
//    var country, state: String?
//    var countryName: String = "", stateName: String = "", suburb: String = "",
//        property: String = "",languages: [String] = [], noOfBedrooms: Int = 0, noOfBathrooms: Int = 0, noOfParkings: Int = 0, min: Double = 0, max: Double = 5000
    
    func checkAuthentication(uid: String, phone: String, completion: @escaping (String, String) -> Void) {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let documents = query?.documents else { return }
            if let document = documents.first(where: { $0.data()["uid"] as? String == uid }) {
                let data = document.data()
                let name = data["name"] as? String
                let uid = data["uid"] as? String
                
                completion(name ?? "", uid ?? "")
            } else {
                completion("", uid)
            }
        }
    }
    
    func getUserData(uid: String, completion: @escaping (UserData) -> Void) {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            
            guard let documents = query?.documents else { return }
            if let document = documents.first(where: { $0.data()["uid"] as? String == uid }) {
                let data = document.data()
                
                let countryCode = data["countryCode"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let phoneNumber = data["phoneNumber"] as? String ?? ""
                let country = data["country"] as? String ?? ""
                let displayLocation = data["displayLocation"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                
                let locationDetailData = data["locationDetail"] as? [String: String] ?? [:]
                let locationDetail = LocationDetail(
                    buildingNo: locationDetailData["buildingNo"] ?? "",
                    country: locationDetailData["country"] ?? "",
                    state: locationDetailData["state"] ?? "",
                    streetName: locationDetailData["streetName"] ?? "",
                    streetNo: locationDetailData["streetNo"] ?? "",
                    suburb: locationDetailData["suburb"] ?? ""
                )
                
                let dialCode = data["dialCode"] as? String ?? ""
                let languages = data["languages"] as? [String] ?? []
                
                let userData = UserData(
                    countryCode: countryCode,
                    name: name,
                    phoneNumber: phoneNumber,
                    country: country,
                    displayLocation: displayLocation,
                    uid: uid,
                    locationDetail: locationDetail,
                    dialCode: dialCode,
                    languages: languages
                )
                CurrentUser.user.data = userData
                completion(userData)
            }
        }
    }
    
    func saveUserDataToDefault(userData: UserData?) {
        if let userData = userData {
            UserDefaultsHelper.setmodel(value: userData, key: .userData)
        }
    }
    
    func getUserDataFromDefaults() {
        CurrentUser.user.data = UserDefaultsHelper.getModelData(.userData)
    }
    
    func getRoomOffered(isRoomOffer: Bool,
                        filterModel: FilterModel,
                        completion: @escaping ([RoomOffer]) -> Void) {
        
        var fireStoreCollection =  Firestore.firestore().collection(isRoomOffer ? "RoomOffer" : "RoomWanted")
            .whereField("location.state", isEqualTo: filterModel.stateName ?? "")
            .whereField("location.country", isEqualTo: filterModel.countryName ?? "")
        
        if filterModel.noOfBedrooms ?? 0 > 0 {
            fireStoreCollection = fireStoreCollection
                .whereField("noOfBedrooms", isEqualTo: filterModel.noOfBedrooms ?? 0)
        }
        
        if filterModel.noOfParkings ?? 0 > 0 {
            fireStoreCollection = fireStoreCollection
                .whereField("noOfParkings", isEqualTo: filterModel.noOfParkings ?? 0)
        }
        
        if filterModel.noOfBathrooms ?? 0 > 0 {
            fireStoreCollection = fireStoreCollection
                .whereField("noOfBathrooms", isEqualTo: filterModel.noOfBathrooms ?? 0)
        }
        
        if let propertyType = filterModel.propertyType {
                fireStoreCollection = fireStoreCollection
                    .whereField("propertyType", isEqualTo: propertyType)
        }
        
        if let languageArray = filterModel.languageArray {
            if !languageArray.isEmpty {
                fireStoreCollection = fireStoreCollection
                    .whereField("userInfo.languagesSpeaks", arrayContainsAny: languageArray )
            }
        }
        //MARK: isGreaterThan should be isGreaterThanOrEqualTo
        if let minCost = filterModel.minCost{
            fireStoreCollection = fireStoreCollection
                .whereField("price", isGreaterThanOrEqualTo: minCost-0.1)
        }
        //MARK: isLessThan should be isLessThanOrEqualTo
        if let maxCost = filterModel.maxCost {
            fireStoreCollection = fireStoreCollection
                .whereField("price", isLessThanOrEqualTo: maxCost+0.1)
        }
        
        if let countryName = filterModel.countryName {
            fireStoreCollection = fireStoreCollection
                .whereField("location.country", isEqualTo: countryName)
        }
        
        if let stateName = filterModel.stateName {
            fireStoreCollection = fireStoreCollection
                .whereField("location.state", isEqualTo: stateName)
        }
        
        
        roomOffers.removeAll()
        roomWanted.removeAll()

        fireStoreCollection
            .getDocuments { query, error in
                guard let query = query else {
                    debugPrint("Error retreving cities: \(error.debugDescription)")
                    return
                }
                for (_, document) in query.documents.enumerated() {
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
                        price: price ?? 0 ,
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
                    if isRoomOffer {
                        roomOffers.append(roomOffer)
                    } else {
                        roomWanted.append(roomOffer)
                    }
                }
                completion(isRoomOffer ? roomOffers : roomWanted)
            }
    }
    
    func getCountryWithState(completion: @escaping ([CountryStateModel]) -> Void) {
        Firestore.firestore().collection("Country_State").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            
            guard let documents = query?.documents else { return }
            var states = [States]()
            var countries = [CountryStateModel]()
            var country: CountryStateModel
            for document in documents {
                let data = document.data()
                for countryName in data.keys {
                    if let dataValues = data[countryName] as? [Any] {
                        for state in dataValues {
                            let state = States(name: state as! String)
                            states.append(state)
                        }
                    }
                    country = CountryStateModel(name: countryName, state: states)
                    countries.append(country)
                    states = []
                }
                completion(countries)
            }
        }
    }
}

/*
 bedroom, bathroom and parkings filter should have isGreaterThanOrEqualTo
 proper composite index shold be made for price filter to work
 */
