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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for profile in profileView.profileArray {
            profile.profileTap = {[weak self] text in
                guard let self = self else {return}
                if let text = text {
                    print(text)
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Color.appBlack
        view = profileView
    }
}
