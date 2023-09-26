//
//  ViewController.swift
//  Discovero
//
//  Created by Sujal Shrestha on 14/09/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getUsers()
    }
    
    func testSendOTP(for phoneNumber: String) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("Error: ", error.localizedDescription)
                    // show alert
                    return
                }
                print("Verification ID: ", verificationID)
                // goto OTP screen
                // Sign in using the verificationID and the code sent to the user
                // ...
            }
    }
    
    func verifyOTP(verificationID: String, verificationCode: String) { // verificationCode -> 6 digit OTP
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
            
            print("id: ", authResult?.user.uid)
        }
    }
    
    func getUsers() {
        Firestore.firestore().collection("Users").getDocuments { query, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                // Show alert
                return
            }
            guard let documents = query?.documents else { return } // Swift Struct model
            let firstData = documents.first?.data()
            print("First data: ", firstData)
        }
    }
}
