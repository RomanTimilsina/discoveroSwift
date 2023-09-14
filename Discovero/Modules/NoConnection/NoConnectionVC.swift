//
//  NoConnectionViewController.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class NoConnectionVC: UIViewController {
    
    let noConnectionView = NoConnectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = noConnectionView
    }

}
