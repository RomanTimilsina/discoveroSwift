
//
//  ConfigureNotificationVC.swift
//  Discovero
//
//  Created by Mac on 02/10/2023.
//

import UIKit

class ConfigureNotificationVC: UIViewController {

    let currentView = ConfigureNotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = currentView
    }
}
