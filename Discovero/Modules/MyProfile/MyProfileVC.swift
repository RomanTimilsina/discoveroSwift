//
//  MyProfileVC.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileVC: UIViewController {
    
    let profileData = profileManager()
    let profileView = MyProfileView()
    let email = EmailVC()
    let value1 = ["name", "email", "phone number", "address", "nationality", "gender"]
    let value2 = ["Your name", "Your email", "Your phone number", "Your address", "Your nationality", "Your gender"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, profile) in profileView.profileArray.enumerated() {
            profile.profileTap = {[weak self] text in
                guard let self = self else {return}
                
                    print(index)
                    email.onTitle = value1[index]
                    email.onPlaceholder = value2[index]

                    navigationController?.pushViewController(email, animated: true)
                
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Color.appBlack
        view = profileView
    }
}
