//
//  otpConfirmVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

class OTPConfirmVC: UIViewController {
    
    let currentView = OTPConfirmView()
    var isFromLogin: Bool?
    var verificationId: String?
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        currentView.codeTextField.otpTextfield.configure()
        observeViewEvents()
//        getUsers()

    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        currentView.didNotReceiveCode = {[weak self] in
            guard let self else {return}
            
        }
        
        currentView.onNextClick = {[weak self] otpText in
            guard let self else {return}
            showHUD()
            gotoNextPage(verificationID: verificationId ?? "", verificationCode: otpText)
        }
    }
    
    private func gotoNextPage(verificationID: String, verificationCode: String) {
      
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                // Show alert
                return
            }
            // User is signed in -> Check if user id is present in firestore db and decide where to go
            // Check "Users" table in firestore db
            self.hideHUD()
            
            if let uid = authResult?.user.uid {
                print("id: ", uid)
                
                self.getUsers(uid: uid)
            }
        }
    }
    
    func getUsers(uid: String) {
        Firestore.firestore().collection("Users")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { query, error in
                if let error = error {
                    print("Error: ", error.localizedDescription)
                    // Show alert
                    return
                }
                
                guard let documents = query?.documents else { return }
                
                if let firstDocument = documents.first {
                    let userData = firstDocument.data()
                    print(userData)
                } else {
                    print("No matching document found")
                    // No matching document found
                    // Handle the case where no document matches the provided UID
                }
            }
    }

    
//    func getUsers() {
//        Firestore.firestore().collection("Users").getDocuments { query, error in
//            if let error = error {
//                print("Error: ", error.localizedDescription)
//                // Show alert
//                return
//            }
//            guard let documents = query?.documents else { return } // Swift Struct model
//            let firstData = documents.first?.data()
//            print(firstData)
//            
//        }
//    }
    
//    func getUserWithUID(_ targetUID: String) {
//        Firestore.firestore().collection("Users")
//            .whereField("userInfo.uid", isEqualTo: targetUID)
//            .getDocuments { querySnapshot, error in
//                if let error = error {
//                    print("Error: ", error.localizedDescription)
//                    // Show an alert
//                    return
//                }
//                
//                if let document = querySnapshot?.documents.first {
//                    let userData = document.data()
//                    if let userInfoData = userData["userInfo"] as? [String: Any],
//                       let uid = userInfoData["uid"] as? String {
//                        print("Found user with UID:", uid)
//                        // Now you have the user data with the matching UID
//                    } else {
//                        print("User data format is incorrect")
//                        // Show an alert indicating the incorrect data format
//                    }
//                } else {
//                    print("No user found with the specified UID")
//                    // Show an alert indicating that no user with the specified UID was found
//                }
//            }
//    }
    
//    func getUserData() {
//        Firestore.firestore().collection("Users").getDocuments { query, error in
//            if let error = error {
//                print("Error: ", error.localizedDescription)
//                // Show alert
//                return
//            }
//            guard let documents = query?.documents else { return } // Swift Struct model
////            let firstData = documents.first?.data()
//            let jsonData = """
//            {
//                "adsType": "RoomWanted",
//                "commentCount": 0,
//                "comments": [],
//                "description": "jjj",
//                "expirationDate": 1680196963331,
//                "favorites": [],
//                "id": "HiEE2TxmtQ9byUCpQLf7",
//                "isAnonymous": 0,
//                "location": {
//                    "buildingNo": "",
//                    "country": "Nepal",
//                    "state": "Bagmati Province",
//                    "streetName": "",
//                    "streetNo": "",
//                    "suburb": "test"
//                },
//                "noOfBathrooms": 1,
//                "noOfBedrooms": 1,
//                "noOfParkings": 0,
//                "price": 11,
//                "propertyType": "Apartment",
//                "soldOut": 0,
//                "timestamp": 1677604965701,
//                "title": "hjkk",
//                "userInfo": {
//                    "languagesSpeaks": ["English", "Nepali"],
//                    "name": "Ankit Kumar",
//                    "phoneNo": "+11234567899",
//                    "uid": "SEc7jHQAvzWzZYgUKnQJLFfaHJg1"
//                }
//            }
//            """.data(using: .utf8)!        }
//    }
}
