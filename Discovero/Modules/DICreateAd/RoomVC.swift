//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomVC: UIViewController {
    
    let room = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.appBlack
    }
    
    override func loadView() {
        view = room
    }
}
