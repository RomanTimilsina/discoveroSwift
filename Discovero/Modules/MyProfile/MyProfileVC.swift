//
//  MyProfileVC.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileVC: UIViewController {
    
    let profileView = MyProfileView()
    
    let value1 = ["name", "email", "phone number", "address",  "nationality", "gender",]
    let value2 = ["Your name", "Your email", "Your phone number", "Your address", "Your nationality", "Your gender" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        for (index, profile) in profileView.profileArray.enumerated() {
            profile.profileTap = { [weak self] text in
                guard let self = self else { return }
                setProfileTab(index: index)
            }
        }
    }
    
    func setProfileTab(index: Int) {
        let profileItem = ProfileItemVC()
        
        if index < 6 && index != 2{
            profileItem.onTitle = value1[index]
            profileItem.onPlaceholder = value2[index]
            navigationController?.pushViewController(profileItem, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Color.appBlack
        view = profileView
    }
}
