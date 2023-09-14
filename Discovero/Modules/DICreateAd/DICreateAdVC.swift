//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class DICreateAdVC: UIViewController {
    
    let createAd = DICreateAdView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.appBlack
    }
    
    override func loadView() {
        view = createAd
    }
}
